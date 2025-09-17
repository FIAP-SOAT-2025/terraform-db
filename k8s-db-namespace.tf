resource "kubectl_manifest" "db_namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: lanchonete-db

YAML
}