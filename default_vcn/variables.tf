
    // Copyright (c) 2020, Oracle and/or its affiliates. All rights reserved.
    // Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
    
    variable "compartment_ocid" {}
    variable "tenancy_ocid" {}
    variable "region" {}

    variable "vcn_display_name" {
      type = "string"
      default = "1234"
    }
    
    variable "vcn_cidr" {
      type = "string"
      default = "192.0. 2.146"
    }

    variable "vcn_dns_label" {
      default     = "vcn"
    }

    variable "subnet_dns_label" {
      default = "subnet"
    }

  
