/*
 * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
 */

// General settings
variable "tenancy_ocid" {}

variable "compartment_ocid" {}

variable "region" {}

variable "service_name" {
  default = ""
}

variable "advanced_mode" {
  default = false
}

variable "runtime_mode" {
  default = "production"
}

variable "quick_create" {
  default = true
}

variable "use_marketplace_image" {
  default = true
}

variable "mp_listing_id" {
  default = "ocid1.appcataloglisting.oc1..aaaaaaaat7fdtoicx5x34ofrcckfoimlrjb4tly5pgm3qfoyqssp2qnvsl6q"
}

variable "mp_listing_resource_version" {
  default = "2.0.1"
}

variable "mp_listing_resource_id" {
  description = "Target image id"
  default = "ocid1.image.oc1..aaaaaaaa75ews3q2shrqiof6fk4xrar7eetqplkowvetfjp34zubtk7vfiyq"
}

variable "instance_shape" {
  default = "VM.Standard2.4"
}

variable "instance_availability_domain" {}

variable "ssh_public_key" {}


variable "vcn_cidr" {
  default = "10.1.0.0/16"
}

variable "create_public_subnet" {
  default = true
}

variable "odi_vnc_password" {
}

variable "subnet" {
  default = ""
}

variable "subnetCompartment" {
  default = ""
}

variable "vcn" {
  default = ""
}

variable "assign_public_ip" {
  default = false
}

variable "odi_repo" {
}

variable "adw_instance" {
  default = "adwctry1"
}

variable "adw_password" {
  default = ""
}

variable "odi_password" {
  default = ""
}

variable "odi_schema_prefix" {
  default = ""
}

variable "odi_schema_password" {
  default = ""
}

variable "new_adw_instance" {
  default = ""
}


variable "new_adw_password" {
  default = ""
}

variable "new_odi_password" {
  default = ""
}

variable "new_odi_schema_prefix" {
  default = ""
}

variable "new_odi_schema_password" {
  default = ""
}