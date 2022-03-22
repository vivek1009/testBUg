/*
 * Copyright (c) 2019 Oracle and/or its affiliates. All rights reserved.
 */

output "bucket_namespace" {
  value = "${data.oci_objectstorage_namespace.user.namespace}"
}

output "bucket_name" {
  value = "${oci_objectstorage_bucket.data.name}"
}
