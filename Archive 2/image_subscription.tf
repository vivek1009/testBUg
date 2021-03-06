
#Get Image Agreement
resource "oci_core_app_catalog_listing_resource_version_agreement" "mp_image_agreement" {
  count = "${var.use_marketplace_image ? 1 : 0}"

  listing_id               = "${var.mp_listing_id}"
  listing_resource_version = "${var.mp_listing_resource_version}"
}

#Accept Terms and Subscribe to the image, placing the image in a particular compartment
resource "oci_core_app_catalog_subscription" "mp_image_subscription" {
  count                    = "${var.use_marketplace_image ? 1 : 0}"
  compartment_id           = "${var.compartment_ocid}"
  eula_link                = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.eula_link}"
  listing_id               = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.listing_id}"
  listing_resource_version = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.listing_resource_version}"
  oracle_terms_of_use_link = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.oracle_terms_of_use_link}"
  signature                = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.signature}"
  time_retrieved           = "${oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.time_retrieved}"

  timeouts {
    create = "20m"
  }
}

# Gets the partner image subscription
data "oci_core_app_catalog_subscriptions" "mp_image_subscription" {
  count = "${var.use_marketplace_image ? 1 : 0}"
  #Required
  compartment_id = "${var.compartment_ocid}"

  #Optional
  listing_id = "${var.mp_listing_id}"

  filter {
    name   = "listing_resource_version"
    values = ["${var.mp_listing_resource_version}"]
  }
}
