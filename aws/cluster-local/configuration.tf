module "configuration" {
  source = "../../common/configuration"

  configuration = var.configuration
  base_key      = var.configuration_base_key
}

locals {
  # current workspace config
  cfg = module.configuration.merged[terraform.workspace]

  name_prefix = local.cfg["name_prefix"]

  base_domain = local.cfg["base_domain"]

  http_port_default = terraform.workspace == "apps" ? 80 : 8080
  http_port         = lookup(local.cfg, "http_port", local.http_port_default)

  https_port_default = terraform.workspace == "apps" ? 443 : 8443
  https_port         = lookup(local.cfg, "https_port", local.https_port_default)

  manifest_path_default = "manifests/overlays/${terraform.workspace}"
  manifest_path         = var.manifest_path != null ? var.manifest_path : local.manifest_path_default

  disable_default_ingress = lookup(local.cfg, "disable_default_ingress", false)

  node_image = lookup(local.cfg, "node_image", "kindest/node:v1.18.0")

  node_count = lookup(local.cfg, "cluster_min_size", 1)
  nodes = [
    for node, _ in range(local.node_count) :
    "worker"
  ]
  extra_nodes = join(",", local.nodes)

}
