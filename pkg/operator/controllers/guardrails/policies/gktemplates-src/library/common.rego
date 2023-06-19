package lib.common
import future.keywords.in

# shared structures, functions, etc.

# get all user info for debug purpose, ie, username, service account, group.
get_user(review) = info {
  has_field(review.userInfo, "username")
  username := get_username(review)
  sa := get_sa(review)
  info := sprintf("user name %v %v", [username, sa])
} {
  not has_field(review.userInfo, "username")
  has_service_account(review.object)
  sa := get_service_account(review.object)
  userInfo := get_userinfo(review)
  info := sprintf("service account %v %v", [sa, userInfo])
}

get_userinfo(review)= info {
  has_field(review, "userInfo")
  info := sprintf("userInfo %v", [review.userInfo])
} {
  not has_field(review, "userInfo")
  info := "userInfo not found"
}

get_sa(review)= sa {
  has_service_account(review.object)
  s := get_service_account(review.object)
  sa := sprintf("service account %v", [s])
} {
  not has_service_account(review.object)
  sa := "service account not found"
}

get_service_account(obj) = spec {
  obj.kind == "Pod"
  spec := obj.spec.serviceAccountName
} {
  obj.kind == "CronJob"
  spec := obj.spec.jobTemplate.spec.template.spec.serviceAccountName
} {
  obj.kind in ["ReplicationController","ReplicaSet","Deployment","StatefulSet","DaemonSet","Job"]
  spec := obj.spec.template.spec.serviceAccountName
}

has_service_account(obj) {
  obj.kind in ["Pod","CronJob","ReplicationController","ReplicaSet","Deployment","StatefulSet","DaemonSet","Job"]
}

# check if username or ServiceAccountName or group is exempted
# return true if one of them is exempted
#
# has to be flexible as need to handle
# for network operator, it provides:
#   "serviceAccountName": "multus"
#   ...
#   userInfo:
#     extra:
#       authentication.kubernetes.io/pod-name:
#       - network-operator-5967c954f9-98rgj
#       authentication.kubernetes.io/pod-uid:
#       - 676de236-52cf-4173-8d6b-d4c24a241d62
#     groups:
#     - system:serviceaccounts
#     - system:serviceaccounts:openshift-network-operator
#     - system:authenticated
#     uid: bb9628bf-6fb4-4bdf-8e7b-c61c64ae752c
#     username: system:serviceaccount:openshift-network-operator:default
# in previous restrict mode implementation, when username exists, only validate username
# and ignore serviceAccountName, above case will not be allowed

is_exempted_account(review) {
  not has_field(review.userInfo, "username")
  sa := get_service_account(review.object)
  is_exempted_service_account(sa)
  print("exempted serviceAccount:", sa)
} {
  has_field(review.userInfo, "username")
  is_exempted_user_or_groups_or_sa(review)
}

# requires username to be present
is_exempted_user_or_groups_or_sa(review) {
  username := get_username(review)
  groups := get_user_group(review)
  is_exempted_user_or_groups(username, groups)
} {
  username := get_username(review)
  groups := get_user_group(review)
  not is_exempted_user_or_groups(username, groups)
  sa := get_service_account(review.object)
  is_exempted_service_account(sa)
  print("exempted sa:", sa)
}

is_exempted_service_account(user) {
  exempted_service_account[user]
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

is_exempted_user_or_groups(user, groups) {
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

is_exempted_user(user) {
  exempted_user[user]
}

exempted_user = {
  "system:admin" # comment out temporarily for testing in console
}

exempted_groups = {
  # "system:cluster-admins", # kube:admin
  "system:serviceaccounts", # to allow all system service account?
  # "system:serviceaccounts:openshift-monitoring", # monitoring operator
  # "system:serviceaccounts:openshift-network-operator", # network operator
  # "system:serviceaccounts:openshift-machine-config-operator", # machine-config-operator, however the request provide correct sa name
  "system:masters" # system:admin
}

is_priv_namespace(ns) {
  privileged_ns[ns]
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

exempted_service_account = {
  # "default",
  "aro-sre",
  "openshift-apiserver-operator",
  "openshift-apiserver-sa",
  "authentication-operator",
  "geneva",
  "aro-operator-worker",
  "cluster-cloud-controller-manager",
  "cloud-credential-operator",
  "azure-disk-csi-driver-controller-sa",
  "azure-disk-csi-driver-node-sa",
  "azure-disk-csi-driver-operator",
  "machine-approver-sa",
  "cluster-node-tuning-operator",
  "tuned",
  "cluster-samples-operator",
  "cluster-storage-operator",
  "csi-snapshot-controller",
  "csi-snapshot-controller-operator",
  "openshift-config-operator",
  "console-operator",
  "console",
  "openshift-controller-manager-operator",
  "openshift-controller-manager-sa",
  "dns-operator",
  "dns",
  "node-resolver",
  "etcd-operator",
  "cluster-image-registry-operator",
  "registry",
  "node-ca",
  "ingress-operator",
  "router",
  "operator",
  "kube-apiserver-operator",
  "kube-controller-manager-operator",
  "openshift-kube-scheduler-operator",
  "kube-storage-version-migrator-operator",
  "kube-storage-version-migrator-sa",
  "cluster-autoscaler-operator",
  "cluster-baremetal-operator",
  "cluster-baremetal-operator",
  "machine-api-controllers",
  "machine-api-operator",
  "machine-config-controller",
  "machine-config-daemon",
  "machine-config-server",
  "managed-upgrade-operator",
  "marketplace-operator",
  "alertmanager-main",
  "cluster-monitoring-operator",
  "grafana",
  "kube-state-metrics",
  "node-exporter",
  "openshift-state-metrics",
  "prometheus-adapter",
  "prometheus-k8s",
  "prometheus-operator",
  "thanos-querier",
  "multus",
  "metrics-daemon-sa",
  "network-diagnostics",
  "oauth-apiserver-sa",
  "collect-profiles",
  "olm-operator-serviceaccount",
  "sdn",
  "sdn-controller",
  "service-ca-operator",
  "service-ca",
  "pruner",
  "machine-api-termination-handler",
  "aro-operator-master",
  "installer-sa",

  # gatekeeper specific
  "gatekeeper-admin"
}