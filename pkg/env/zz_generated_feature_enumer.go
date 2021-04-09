// Code generated by "enumer -type Feature -output zz_generated_feature_enumer.go"; DO NOT EDIT.

//
package env

import (
	"fmt"
)

const _FeatureName = "FeatureDisableDenyAssignments"

var _FeatureIndex = [...]uint8{0, 29}

func (i Feature) String() string {
	if i < 0 || i >= Feature(len(_FeatureIndex)-1) {
		return fmt.Sprintf("Feature(%d)", i)
	}
	return _FeatureName[_FeatureIndex[i]:_FeatureIndex[i+1]]
}

var _FeatureValues = []Feature{0}

var _FeatureNameToValueMap = map[string]Feature{
	_FeatureName[0:29]: 0,
}

// FeatureString retrieves an enum value from the enum constants string name.
// Throws an error if the param is not part of the enum.
func FeatureString(s string) (Feature, error) {
	if val, ok := _FeatureNameToValueMap[s]; ok {
		return val, nil
	}
	return 0, fmt.Errorf("%s does not belong to Feature values", s)
}

// FeatureValues returns all values of the enum
func FeatureValues() []Feature {
	return _FeatureValues
}

// IsAFeature returns "true" if the value is listed in the enum definition. "false" otherwise
func (i Feature) IsAFeature() bool {
	for _, v := range _FeatureValues {
		if i == v {
			return true
		}
	}
	return false
}