variable "marketplace_source_images" {
  type = map(object({
    ocid = string
    is_pricing_associated = bool
    compatible_shapes = set(string)
  }))
  default = {
    main_mktpl_image = {
      ocid = "ocid1.image.oc1..aaaaaaaas56soyh5sfrau5o6vihmlrlccjh7qrep6sxsgehfx5no245nyjia"
      is_pricing_associated = false
      compatible_shapes = ["VM.Standard2.1", "VM.Standard2.2", "VM.Standard2.4", "VM.Standard2.8", "VM.Standard2.16", "VM.Standard2.24"]
    }
  }
}