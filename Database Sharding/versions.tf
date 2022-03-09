# Copyright 2020 Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl
terraform {
  required_version = ">=0.12, <0.13"

  required_providers {
    oci = {
      version = "4.44.0"
    }
  }
}
