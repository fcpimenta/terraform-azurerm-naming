module "web_app" {
  source     = "../../../."
  name       = var.name
  prefixes   = var.prefixes
  suffixes   = var.suffixes
  separator  = "-"
  max_length = 60
  nb_instances = var.nb_instances
}

data "null_data_source" "names" {
  count = var.nb_instances
  inputs = {
    result = var.nb_instances > 1 ? regex("^[a-zA-Z0-9]{1}[a-zA-Z0-9-]*$", module.web_app.results[count.index]) : regex("^[a-zA-Z0-9]{1}[a-zA-Z0-9-]*$", module.web_app.result)
  }
}

locals {
  results = data.null_data_source.names.*.outputs.result
}