resource "kubectl_manifest" "ebs_storage_class" {
  yaml_body = <<YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: gp2-ebs
provisioner: ebs.csi.aws.com
parameters:
  type: gp2
  fsType: ext4
volumeBindingMode: Immediate
allowVolumeExpansion: true
reclaimPolicy: Delete
YAML
}