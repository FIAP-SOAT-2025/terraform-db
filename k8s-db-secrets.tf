resource "kubectl_manifest" "db_secrets" {
    depends_on = [kubectl_manifest.db_namespace]
    yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: db-credentials-secret
  namespace: lanchonete-db
type: Opaque
data:
  DB_USER: "YWRtaW4="
  DB_PASSWORD: "YWRtaW4="
  DB_NAME: "bGFuY2hvbmV0ZV9kYg=="

YAML
}