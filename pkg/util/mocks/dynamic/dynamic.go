// Code generated by MockGen. DO NOT EDIT.
// Source: dynamic.go

// Package mock_dynamic is a generated GoMock package.
package mock_dynamic

import (
	context "context"
	reflect "reflect"

	azcore "github.com/Azure/azure-sdk-for-go/sdk/azcore"
	gomock "github.com/golang/mock/gomock"

	api "github.com/Azure/ARO-RP/pkg/api"
	dynamic "github.com/Azure/ARO-RP/pkg/validate/dynamic"
)

// MockServicePrincipalValidator is a mock of ServicePrincipalValidator interface.
type MockServicePrincipalValidator struct {
	ctrl     *gomock.Controller
	recorder *MockServicePrincipalValidatorMockRecorder
}

// MockServicePrincipalValidatorMockRecorder is the mock recorder for MockServicePrincipalValidator.
type MockServicePrincipalValidatorMockRecorder struct {
	mock *MockServicePrincipalValidator
}

// NewMockServicePrincipalValidator creates a new mock instance.
func NewMockServicePrincipalValidator(ctrl *gomock.Controller) *MockServicePrincipalValidator {
	mock := &MockServicePrincipalValidator{ctrl: ctrl}
	mock.recorder = &MockServicePrincipalValidatorMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockServicePrincipalValidator) EXPECT() *MockServicePrincipalValidatorMockRecorder {
	return m.recorder
}

// ValidateServicePrincipal mocks base method.
func (m *MockServicePrincipalValidator) ValidateServicePrincipal(ctx context.Context, spTokenCredential azcore.TokenCredential) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ValidateServicePrincipal", ctx, spTokenCredential)
	ret0, _ := ret[0].(error)
	return ret0
}

// ValidateServicePrincipal indicates an expected call of ValidateServicePrincipal.
func (mr *MockServicePrincipalValidatorMockRecorder) ValidateServicePrincipal(ctx, spTokenCredential interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ValidateServicePrincipal", reflect.TypeOf((*MockServicePrincipalValidator)(nil).ValidateServicePrincipal), ctx, spTokenCredential)
}

// MockDynamic is a mock of Dynamic interface.
type MockDynamic struct {
	ctrl     *gomock.Controller
	recorder *MockDynamicMockRecorder
}

// MockDynamicMockRecorder is the mock recorder for MockDynamic.
type MockDynamicMockRecorder struct {
	mock *MockDynamic
}

// NewMockDynamic creates a new mock instance.
func NewMockDynamic(ctrl *gomock.Controller) *MockDynamic {
	mock := &MockDynamic{ctrl: ctrl}
	mock.recorder = &MockDynamicMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockDynamic) EXPECT() *MockDynamicMockRecorder {
	return m.recorder
}

// ValidateDiskEncryptionSets mocks base method.
func (m *MockDynamic) ValidateDiskEncryptionSets(ctx context.Context, oc *api.OpenShiftCluster) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ValidateDiskEncryptionSets", ctx, oc)
	ret0, _ := ret[0].(error)
	return ret0
}

// ValidateDiskEncryptionSets indicates an expected call of ValidateDiskEncryptionSets.
func (mr *MockDynamicMockRecorder) ValidateDiskEncryptionSets(ctx, oc interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ValidateDiskEncryptionSets", reflect.TypeOf((*MockDynamic)(nil).ValidateDiskEncryptionSets), ctx, oc)
}

// ValidateEncryptionAtHost mocks base method.
func (m *MockDynamic) ValidateEncryptionAtHost(ctx context.Context, oc *api.OpenShiftCluster) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ValidateEncryptionAtHost", ctx, oc)
	ret0, _ := ret[0].(error)
	return ret0
}

// ValidateEncryptionAtHost indicates an expected call of ValidateEncryptionAtHost.
func (mr *MockDynamicMockRecorder) ValidateEncryptionAtHost(ctx, oc interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ValidateEncryptionAtHost", reflect.TypeOf((*MockDynamic)(nil).ValidateEncryptionAtHost), ctx, oc)
}

// ValidatePreConfiguredNSGs mocks base method.
func (m *MockDynamic) ValidatePreConfiguredNSGs(ctx context.Context, oc *api.OpenShiftCluster, subnets []dynamic.Subnet) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ValidatePreConfiguredNSGs", ctx, oc, subnets)
	ret0, _ := ret[0].(error)
	return ret0
}

// ValidatePreConfiguredNSGs indicates an expected call of ValidatePreConfiguredNSGs.
func (mr *MockDynamicMockRecorder) ValidatePreConfiguredNSGs(ctx, oc, subnets interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ValidatePreConfiguredNSGs", reflect.TypeOf((*MockDynamic)(nil).ValidatePreConfiguredNSGs), ctx, oc, subnets)
}

// ValidateServicePrincipal mocks base method.
func (m *MockDynamic) ValidateServicePrincipal(ctx context.Context, spTokenCredential azcore.TokenCredential) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ValidateServicePrincipal", ctx, spTokenCredential)
	ret0, _ := ret[0].(error)
	return ret0
}

// ValidateServicePrincipal indicates an expected call of ValidateServicePrincipal.
func (mr *MockDynamicMockRecorder) ValidateServicePrincipal(ctx, spTokenCredential interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ValidateServicePrincipal", reflect.TypeOf((*MockDynamic)(nil).ValidateServicePrincipal), ctx, spTokenCredential)
}

// ValidateSubnets mocks base method.
func (m *MockDynamic) ValidateSubnets(ctx context.Context, oc *api.OpenShiftCluster, subnets []dynamic.Subnet) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "ValidateSubnets", ctx, oc, subnets)
	ret0, _ := ret[0].(error)
	return ret0
}

// ValidateSubnets indicates an expected call of ValidateSubnets.
func (mr *MockDynamicMockRecorder) ValidateSubnets(ctx, oc, subnets interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ValidateSubnets", reflect.TypeOf((*MockDynamic)(nil).ValidateSubnets), ctx, oc, subnets)
}

// ValidateVnet mocks base method.
func (m *MockDynamic) ValidateVnet(ctx context.Context, location string, subnets []dynamic.Subnet, additionalCIDRs ...string) error {
	m.ctrl.T.Helper()
	varargs := []interface{}{ctx, location, subnets}
	for _, a := range additionalCIDRs {
		varargs = append(varargs, a)
	}
	ret := m.ctrl.Call(m, "ValidateVnet", varargs...)
	ret0, _ := ret[0].(error)
	return ret0
}

// ValidateVnet indicates an expected call of ValidateVnet.
func (mr *MockDynamicMockRecorder) ValidateVnet(ctx, location, subnets interface{}, additionalCIDRs ...interface{}) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	varargs := append([]interface{}{ctx, location, subnets}, additionalCIDRs...)
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "ValidateVnet", reflect.TypeOf((*MockDynamic)(nil).ValidateVnet), varargs...)
}
