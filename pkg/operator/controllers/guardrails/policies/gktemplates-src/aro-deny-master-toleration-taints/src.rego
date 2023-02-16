package arodenymastertolerationtaints

import future.keywords.in

violation[{"msg": msg}] {
    # Check if the input namespace is a non-privileged namespace
    ns := input.review.object.metadata.namespace
    non_priv_namespace(ns)

    # Check if the input operation is CREATE or UPDATE
    input.review.operation in ["CREATE", "UPDATE"]

    # Check if pod object has master toleration taints
    some i
    input.request.object.spec.tolerations[i].key in ["node-role.kubernetes.io/master", "node-role.kubernetes.io/control-plane"]

    msg := "Create or update resources to have master toleration taints is not allowed in non-privileged namespaces"
}

non_priv_namespace(ns) {
    not privileged_ns[ns]
}

privileged_ns = {
    # ARO specific namespaces
    "openshift-azure-logging",
    "openshift-azure-operator",
    "openshift-managed-upgrade-operator",
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
    "openshift-operator-lifecycle-manager",
    "openshift-ovirt-infra",
    "openshift-sdn",
    "openshift-service-ca",
    "openshift-service-ca-operator",
}
