package lib.common
import future.keywords.in

# shared structures, functions, etc.

is_exempted_account(review) = true {
  has_field(review, "userInfo")
  has_field(review.userInfo, "username")
  username := get_username(review)
  groups := get_user_group(review)
  is_exempted_user_or_groups(username, groups)
} {
  not has_field(review, "userInfo")
} {
  has_field(review, "userInfo")
  not has_field(review.userInfo, "username")
}

get_username(review) = name {
  not has_field(review.userInfo, "username")
  name = "notfound"
} {
  has_field(review.userInfo, "username")
  name = review.userInfo.username
  print(name)
}

get_user_group(review) = group {
    not review.userInfo
    group = []
} {
    not review.userInfo.groups
    group = []
} {
    group = review.userInfo.groups
}

is_exempted_user_or_groups(user, groups) = true {
  exempted_user[user]
  print("exempted user:", user)
} {
  group := [ g | g := groups[_]; (g in cast_set(exempted_groups)) ]
  count(group) > 0
  print("exempted group:", group)
}

has_field(object, field) = true {
    object[field]
}

is_exempted_user(user) = true {
  exempted_user[user]
}

is_priv_namespace(ns) = true {
  privileged_ns[ns]
}

is_critical_crd(crd_name) = true {
  critical_crds[crd_name]
}

exempted_user = {
  "system:kube-controller-manager",
  "system:admin" # comment out temporarily for testing in console
}

exempted_groups = {
  # "system:cluster-admins", # dont allow kube:admin
  "system:nodes", # eg, "username": "system:node:jeff-test-cluster-pcnp4-master-2"
  "system:serviceaccounts", # to allow all system service account?
  # "system:serviceaccounts:openshift-monitoring", # monitoring operator
  # "system:serviceaccounts:openshift-network-operator", # network operator
  # "system:serviceaccounts:openshift-machine-config-operator", # machine-config-operator, however the request provide correct sa name
  "system:masters" # system:admin
}

privileged_ns = {
  # Kubernetes specific namespaces
  "kube-node-lease",
  "kube-public",
  "kube-system",

  # ARO specific namespaces
  "openshift-azure-logging",
  "openshift-azure-operator",
  "openshift-managed-upgrade-operator",
  "openshift-azure-guardrails",

  # OCP namespaces
  "openshift",
  "openshift-apiserver",
  "openshift-apiserver-operator",
  "openshift-authentication-operator",
  "openshift-cloud-controller-manager",
  "openshift-cloud-controller-manager-operator",
  "openshift-cloud-credential-operator",
  "openshift-cluster-csi-drivers",
  "openshift-cluster-machine-approver",
  "openshift-cluster-node-tuning-operator",
  "openshift-cluster-samples-operator",
  "openshift-cluster-storage-operator",
  "openshift-cluster-version",
  "openshift-config",
  "openshift-config-managed",
  "openshift-config-operator",
  "openshift-console",
  "openshift-console-operator",
  "openshift-console-user-settings",
  "openshift-controller-manager",
  "openshift-controller-manager-operator",
  "openshift-dns",
  "openshift-dns-operator",
  "openshift-etcd",
  "openshift-etcd-operator",
  "openshift-host-network",
  "openshift-image-registry",
  "openshift-ingress",
  "openshift-ingress-canary",
  "openshift-ingress-operator",
  "openshift-insights",
  "openshift-kni-infra",
  "openshift-kube-apiserver",
  "openshift-kube-apiserver-operator",
  "openshift-kube-controller-manager",
  "openshift-kube-controller-manager-operator",
  "openshift-kube-scheduler",
  "openshift-kube-scheduler-operator",
  "openshift-kube-storage-version-migrator",
  "openshift-kube-storage-version-migrator-operator",
  "openshift-machine-api",
  "openshift-machine-config-operator",
  "openshift-marketplace",
  "openshift-monitoring",
  "openshift-multus",
  "openshift-network-diagnostics",
  "openshift-network-operator",
  "openshift-oauth-apiserver",
  "openshift-openstack-infra",
  "openshift-operators",
  "openshift-operator-lifecycle-manager",
  "openshift-ovirt-infra",
  "openshift-sdn",
  "openshift-service-ca",
  "openshift-service-ca-operator"
}

critical_crds = {
  "alertmanagerconfigs.monitoring.coreos.com",
  "alertmanagers.monitoring.coreos.com",
  "apirequestcounts.apiserver.openshift.io",
  "apiservers.config.openshift.io",
  "assign.mutations.gatekeeper.sh",
  "assignmetadata.mutations.gatekeeper.sh",
  "authentications.config.openshift.io",
  "authentications.operator.openshift.io",
  "baremetalhosts.metal3.io",
  "bmceventsubscriptions.metal3.io",
  "builds.config.openshift.io",
  "catalogsources.operators.coreos.com",
  "cloudcredentials.operator.openshift.io",
  "cloudprivateipconfigs.cloud.network.openshift.io",
  "clusterautoscalers.autoscaling.openshift.io",
  "clustercsidrivers.operator.openshift.io",
  "clusteroperators.config.openshift.io",
  "clusterresourcequotas.quota.openshift.io",
  "clusters.aro.openshift.io",
  "clusterserviceversions.operators.coreos.com",
  "clusterversions.config.openshift.io",
  "configs.config.gatekeeper.sh",
  "configs.imageregistry.operator.openshift.io",
  "configs.operator.openshift.io",
  "configs.samples.operator.openshift.io",
  "consoleclidownloads.console.openshift.io",
  "consoleexternalloglinks.console.openshift.io",
  "consolelinks.console.openshift.io",
  "consolenotifications.console.openshift.io",
  "consoleplugins.console.openshift.io",
  "consolequickstarts.console.openshift.io",
  "consoles.config.openshift.io",
  "consoles.operator.openshift.io",
  "consoleyamlsamples.console.openshift.io",
  "constraintpodstatuses.status.gatekeeper.sh",
  "constrainttemplatepodstatuses.status.gatekeeper.sh",
  "constrainttemplates.templates.gatekeeper.sh",
  "containerruntimeconfigs.machineconfiguration.openshift.io",
  "controllerconfigs.machineconfiguration.openshift.io",
  "credentialsrequests.cloudcredential.openshift.io",
  "csisnapshotcontrollers.operator.openshift.io",
  "dnses.config.openshift.io",
  "dnses.operator.openshift.io",
  "dnsrecords.ingress.operator.openshift.io",
  "egressfirewalls.k8s.ovn.org",
  "egressips.k8s.ovn.org",
  "egressqoses.k8s.ovn.org",
  "egressrouters.network.operator.openshift.io",
  "etcds.operator.openshift.io",
  "expansiontemplate.expansion.gatekeeper.sh",
  "featuregates.config.openshift.io",
  "firmwareschemas.metal3.io",
  "helmchartrepositories.helm.openshift.io",
  "hostfirmwaresettings.metal3.io",
  "imagecontentpolicies.config.openshift.io",
  "imagecontentsourcepolicies.operator.openshift.io",
  "imagepruners.imageregistry.operator.openshift.io",
  "images.config.openshift.io",
  "infrastructures.config.openshift.io",
  "ingresscontrollers.operator.openshift.io",
  "ingresses.config.openshift.io",
  "installplans.operators.coreos.com",
  "ippools.whereabouts.cni.cncf.io",
  "kubeapiservers.operator.openshift.io",
  "kubecontrollermanagers.operator.openshift.io",
  "kubeletconfigs.machineconfiguration.openshift.io",
  "kubeschedulers.operator.openshift.io",
  "kubestorageversionmigrators.operator.openshift.io",
  "machineautoscalers.autoscaling.openshift.io",
  "machineconfigpools.machineconfiguration.openshift.io",
  "machineconfigs.machineconfiguration.openshift.io",
  "machinehealthchecks.machine.openshift.io",
  "machines.machine.openshift.io",
  "machinesets.machine.openshift.io",
  "modifyset.mutations.gatekeeper.sh",
  "mutatorpodstatuses.status.gatekeeper.sh",
  "network-attachment-definitions.k8s.cni.cncf.io",
  "networks.config.openshift.io",
  "networks.operator.openshift.io",
  "nodes.config.openshift.io",
  "oauths.config.openshift.io",
  "olmconfigs.operators.coreos.com",
  "openshiftapiservers.operator.openshift.io",
  "openshiftcontrollermanagers.operator.openshift.io",
  "operatorconditions.operators.coreos.com",
  "operatorgroups.operators.coreos.com",
  "operatorhubs.config.openshift.io",
  "operatorpkis.network.operator.openshift.io",
  "operators.operators.coreos.com",
  "overlappingrangeipreservations.whereabouts.cni.cncf.io",
  "performanceprofiles.performance.openshift.io",
  "podmonitors.monitoring.coreos.com",
  "podnetworkconnectivitychecks.controlplane.operator.openshift.io",
  "preprovisioningimages.metal3.io",
  "previewfeatures.preview.aro.openshift.io",
  "probes.monitoring.coreos.com",
  "profiles.tuned.openshift.io",
  "projecthelmchartrepositories.helm.openshift.io",
  "projects.config.openshift.io",
  "prometheuses.monitoring.coreos.com",
  "prometheusrules.monitoring.coreos.com",
  "providers.externaldata.gatekeeper.sh",
  "provisionings.metal3.io",
  "proxies.config.openshift.io",
  "rangeallocations.security.internal.openshift.io",
  "rolebindingrestrictions.authorization.openshift.io",
  "schedulers.config.openshift.io",
  "securitycontextconstraints.security.openshift.io",
  "servicecas.operator.openshift.io",
  "servicemonitors.monitoring.coreos.com",
  "storages.operator.openshift.io",
  "storagestates.migration.k8s.io",
  "storageversionmigrations.migration.k8s.io",
  "subscriptions.operators.coreos.com",
  "thanosrulers.monitoring.coreos.com",
  "tuneds.tuned.openshift.io",
  "upgradeconfigs.upgrade.managed.openshift.io",
  "volumesnapshotclasses.snapshot.storage.k8s.io",
  "volumesnapshotcontents.snapshot.storage.k8s.io",
  "volumesnapshots.snapshot.storage.k8s.io"
}