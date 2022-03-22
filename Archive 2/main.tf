/*
 * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
 */

// Random suffix to make things unique
resource "random_string" "instance_uuid" {
  length  = 8
  lower   = true
  upper   = false
  special = false
  number  = true
}

locals {
  generated_name_prefix       = "${format("odi_%s", random_string.instance_uuid.result)}"
  generated_dns_label         = "${format("odi%s", random_string.instance_uuid.result)}"
  generated_rcu_schema_prefix = "${format("ODI%s", upper(random_string.instance_uuid.result))}"
  resource_name_prefix = "${var.service_name != "" ? var.service_name : local.generated_name_prefix}"
}


resource "tls_private_key" "runtime_access" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

module "network" {
  source = "./modules/network"
  
  display_name_prefix = "${local.resource_name_prefix}"
  
  compartment_id      = "${var.compartment_ocid}"
  
  vcn_cidr  = "${var.vcn_cidr}"
  
  dns_label = "${local.generated_dns_label}"
  
  create_private_subnet = "${var.create_public_subnet ? 0 : 1}"
  
  network_enabled = "${var.quick_create != "Existing networking components will be used" ? 1 : 0}"
}


module "bastion" {
  source = "./modules/bastion"

  enabled = "${var.create_public_subnet ? 0 : 1}"

  compartment_id      = "${var.compartment_ocid}"
  
  region              = "${var.region}"
  
  availability_domain = "${var.instance_availability_domain}"

  display_name_prefix = "${local.resource_name_prefix}"

  ssh_authorized_keys = "${var.ssh_public_key}\n${tls_private_key.runtime_access.public_key_openssh}"

  subnet_id            = "${module.network.bastion_subnet_id}"
}

/*module "bucket" {
  source = "./modules/bucket"
  compartment_id = "${var.compartment_ocid}"

  # Bucket name needs to be unique
  bucket_name    = "${var.service_name != "" ? format("%s-data-%s", var.service_name, random_string.instance_uuid.result) : format("%s-data", local.generated_name_prefix)}"  
}*/


module "odi" {
  source = "./modules/odi"

  compartment_id       = "${var.compartment_ocid}"
  region               = "${var.region}"
  availability_domain  = "${var.instance_availability_domain}"
  image_id             = "${var.mp_listing_resource_id}"
  display_name_prefix  = "${local.resource_name_prefix}"

  ssh_authorized_keys  = "${var.ssh_public_key}\n${tls_private_key.runtime_access.public_key_openssh}"
  ssh_private_key      = "${tls_private_key.runtime_access.private_key_pem}"

  bastion_host         = "${var.create_public_subnet ? "" : module.bastion.public_ip}"

  node_hostname_prefix = "oracle-odi-inst"
  shape                = "${var.instance_shape}"
  subnet_id            = "${var.quick_create != "Existing networking components will be used" ? module.network.application_subnet_id : var.subnet}"
  assign_public_ip     = "${var.quick_create != "Existing networking components will be used" ? var.create_public_subnet ? 1 : 0 : var.assign_public_ip ? 1 : 0}"  
  odi_vnc_password     = "${var.odi_vnc_password}"
  adw_instance         = "${var.odi_repo != "Connect to an existing ODI Repository in an Autonomous Database" ? var.new_adw_instance : var.adw_instance}"
  adw_password         = "${var.odi_repo != "Connect to an existing ODI Repository in an Autonomous Database" ? var.new_adw_password : var.adw_password}"
  odi_password         = "${var.odi_repo != "Connect to an existing ODI Repository in an Autonomous Database" ? var.new_odi_password : var.odi_password}"
  odi_schema_prefix    = "${var.odi_repo != "Connect to an existing ODI Repository in an Autonomous Database" ? var.new_odi_schema_prefix : var.odi_schema_prefix}"
  odi_schema_password  = "${var.odi_repo != "Connect to an existing ODI Repository in an Autonomous Database" ? var.new_odi_schema_password : var.odi_schema_password}"
  adw_creation_mode    = "${var.odi_repo != "Connect to an existing ODI Repository in an Autonomous Database" ? true : false}"
  embedded_db          = "${var.odi_repo != "Create an embedded ODI Repository" ? false : true}"
}