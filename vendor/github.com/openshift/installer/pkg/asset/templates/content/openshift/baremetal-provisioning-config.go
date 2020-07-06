package openshift

import (
	"os"
	"path/filepath"

	"github.com/openshift/installer/pkg/asset"
	"github.com/openshift/installer/pkg/asset/templates/content"
)

const (
	baremetalConfigFilename = "baremetal-provisioning-config.yaml.template"
)

var _ asset.WritableAsset = (*BaremetalConfig)(nil)

// BaremetalConfig is the custom resource definitions for the baremetal deployment
type BaremetalConfig struct {
	FileList []*asset.File
}

// Dependencies returns all of the dependencies directly needed by the asset
func (t *BaremetalConfig) Dependencies() []asset.Asset {
	return []asset.Asset{}
}

// Name returns the human-friendly name of the asset.
func (t *BaremetalConfig) Name() string {
	return "Baremetal Config CR"
}

// Generate generates the actual files by this asset
func (t *BaremetalConfig) Generate(parents asset.Parents) error {
	fileName := baremetalConfigFilename
	data, err := content.GetOpenshiftTemplate(fileName)
	if err != nil {
		return err
	}
	t.FileList = []*asset.File{
		{
			Filename: filepath.Join(content.TemplateDir, fileName),
			Data:     []byte(data),
		},
	}
	return nil
}

// Files returns the files generated by the asset.
func (t *BaremetalConfig) Files() []*asset.File {
	return t.FileList
}

// Load returns the asset from disk.
func (t *BaremetalConfig) Load(f asset.FileFetcher) (bool, error) {
	file, err := f.FetchByName(filepath.Join(content.TemplateDir, baremetalConfigFilename))
	if err != nil {
		if os.IsNotExist(err) {
			return false, nil
		}
		return false, err
	}
	t.FileList = append(t.FileList, file)
	return true, nil
}
