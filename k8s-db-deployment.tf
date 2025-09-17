resource "kubectl_manifest" "db_pvc" {
    depends_on = [kubectl_manifest.db_namespace, kubectl_manifest.ebs_storage_class]
    yaml_body = <<YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-pvc
  namespace: lanchonete-db
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: gp2-ebs
  resources:
    requests:
      storage: 1Gi

YAML
}

resource "kubectl_manifest" "db_deployment" {
    depends_on = [kubectl_manifest.db_secrets, kubectl_manifest.db_pvc, kubectl_manifest.db_namespace]
    yaml_body = <<YAML
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres-db
  namespace: lanchonete-db
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres-db
  template:
    metadata:
      labels:
        app: postgres-db
    spec:
      containers:
      - name: postgres
        image: postgres:15-alpine
        ports:
        - containerPort: 5432
        env:
        - name: POSTGRES_DB
          valueFrom:
            secretKeyRef:
              name: db-credentials-secret
              key: DB_NAME
        - name: POSTGRES_USER
          valueFrom:
            secretKeyRef:
              name: db-credentials-secret
              key: DB_USER
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-credentials-secret
              key: DB_PASSWORD
        volumeMounts:
        - name: postgres-storage
          mountPath: /var/lib/postgresql/data
          subPath: postgres
      volumes:
      - name: postgres-storage
        persistentVolumeClaim:
          claimName: db-pvc

YAML
}