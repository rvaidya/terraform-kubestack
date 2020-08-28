clusters = {
  aks_zero = {
    # Settings for Apps-cluster
    apps = {
      # Set name_prefix used to generate the cluster_name
      # [name_prefix]-[workspace]-[region]
      # e.g. name_prefix = kbst becomes: `kbst-apps-eu-west-1`
      # for small orgs the name works well
      # for bigger orgs consider department or team names
      name_prefix = ""

      # Set the base_domain used to generate the FQDN of the cluster
      # [cluster_name].[provider_name].[base_domain]
      # e.g. kbst-apps-eu-west-1.aws.infra.example.com
      base_domain = ""

      # The Azure resource group to use
      resource_group = ""
    }

    # Settings for Ops-cluster
    ops = {}

    loc = {}
  }

  eks_zero = {
    # Settings for Apps-cluster
    apps = {
      # Set name_prefix used to generate the cluster_name
      # [name_prefix]-[workspace]-[region]
      # e.g. name_prefix = kbst becomes: `kbst-apps-eu-west-1`
      # for small orgs the name works well
      # for bigger orgs consider department or team names
      name_prefix = ""

      # Set the base_domain used to generate the FQDN of the cluster
      # [cluster_name].[provider_name].[base_domain]
      # e.g. kbst-apps-eu-west-1.aws.infra.example.com
      base_domain = ""

      cluster_instance_type    = "t3.small"
      cluster_desired_capacity = "1"
      cluster_min_size         = "1"
      cluster_max_size         = "3"

      # Comma seperated list of zone names to deploy worker nodes in
      # EKS requires a min. of 2 zones
      # Must match region set in provider
      # e.g. cluster_availability_zones = "eu-west-1a,eu-west-1b,eu-west-1c"
      # FIXME: Use actual list when TF 0.12 finally supports heterogeneous maps
      cluster_availability_zones = ""
    }

    # Settings for Ops-cluster
    ops = {
      # Overwrite apps["cluster_availability_zones"] to have a smaller
      # ops cluster
      # EKS requires a min. of 2 zones
      # e.g. cluster_availability_zones = "eu-west-1a,eu-west-1b"
      cluster_availability_zones = ""
    }

    loc = {}
  }

  gke_zero = {
    # Settings for Apps-cluster
    apps = {
      # The Google cloud project ID to use
      project_id = ""

      # Set name_prefix used to generate the cluster_name
      # [name_prefix]-[workspace]-[region]
      # e.g. name_prefix = kbst becomes: `kbst-apps-europe-west3`
      # for small orgs the name works well,
      # for bigger orgs consider department or team names
      name_prefix = ""

      # Set the base_domain used to generate the FQDN of the cluster
      # [cluster_name].[provider_name].[base_domain]
      # e.g. kbst-apps-europe-west3.gcp.infra.example.com
      base_domain = ""

      # Initial desired K8s version, will be upgraded automatically
      cluster_min_master_version = "1.15"

      # Initial number of desired nodes per zone
      cluster_initial_node_count = 1

      # The Google cloud region to deploy the clusters in
      region = ""

      # Comma seperated list of zone names to deploy worker nodes in.
      # Must match region above.
      # e.g. cluster_node_locations = "europe-west3-a,europe-west3-b,europe-west3-c"
      # FIXME: Use actual list when TF 0.12 finally supports heterogeneous maps
      cluster_node_locations = ""
    }

    # Settings for Ops-cluster
    # configuration here overwrites the values from apps
    ops = {
      # Overwrite apps["cluster_node_locations"] to have a smaller
      # ops cluster
      # e.g. cluster_node_locations = "europe-west3-a"
      cluster_node_locations = ""
    }

    loc = {}
  }
}
