/*
 * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
 */
locals {
  empty_list="${list(list(""))}"
}

output "application_subnet_id" {
  value = "${join(",",oci_core_subnet.application.*.id)}"
}

output "bastion_subnet_id" {
  value = "${join(",", oci_core_subnet.bastion.*.id)}"
}

output "vcn_id" {
  value = "${join(",",oci_core_vcn.vcn.*.id)}"
}
