package v20201231preview

// Copyright (c) Microsoft Corporation.
// Licensed under the Apache License 2.0.

import (
	"github.com/Azure/ARO-RP/pkg/api"
)

func exampleOpenShiftCluster() *OpenShiftCluster {
	doc := api.ExampleOpenShiftClusterDocument()
	return (&openShiftClusterConverter{}).ToExternal(doc.OpenShiftCluster).(*OpenShiftCluster)
}

// ExampleOpenShiftClusterPatchParameter returns an example OpenShiftCluster
// object that an end-user might send to create a cluster in a PATCH request
func ExampleOpenShiftClusterPatchParameter() *OpenShiftCluster {
	oc := ExampleOpenShiftClusterPutParameter()
	oc.Location = ""

	return oc
}

// ExampleOpenShiftClusterPutParameter returns an example OpenShiftCluster
// object that an end-user might send to create a cluster in a PUT request
func ExampleOpenShiftClusterPutParameter() *OpenShiftCluster {
	oc := exampleOpenShiftCluster()
	oc.ID = ""
	oc.Name = ""
	oc.Type = ""
	oc.Properties.ProvisioningState = ""
	oc.Properties.ClusterProfile.Version = ""
	oc.Properties.ConsoleProfile.URL = ""
	oc.Properties.APIServerProfile.URL = ""
	oc.Properties.APIServerProfile.IP = ""
	oc.Properties.IngressProfiles[0].IP = ""

	return oc
}

// ExampleOpenShiftClusterResponse returns an example OpenShiftCluster object
// that the RP might return to an end-user
func ExampleOpenShiftClusterResponse() *OpenShiftCluster {
	oc := exampleOpenShiftCluster()
	oc.Properties.ClusterProfile.PullSecret = ""
	oc.Properties.ServicePrincipalProfile.ClientSecret = ""

	return oc
}

// ExampleOpenShiftClusterListResponse returns an example OpenShiftClusterList
// object that the RP might return to an end-user
func ExampleOpenShiftClusterListResponse() *OpenShiftClusterList {
	return &OpenShiftClusterList{
		OpenShiftClusters: []*OpenShiftCluster{
			ExampleOpenShiftClusterResponse(),
		},
	}
}
