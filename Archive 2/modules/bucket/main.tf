/*
 * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
 */

data "oci_objectstorage_namespace" "user" {
  # TODO Enable  # compartment_id = "${var.compartment_id}"
}

resource "oci_objectstorage_bucket" "data" {
  compartment_id = "${var.compartment_id}"
  namespace      = "${data.oci_objectstorage_namespace.user.namespace}"
  name           = "${var.bucket_name}"
  access_type    = "NoPublicAccess"
}
