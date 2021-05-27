app:
  title: Frontside Backstage
  baseUrl: "http://localhost:3000"
organization:
  name: Frontside
backend:
  baseUrl: "http://localhost:7000"
  listen:
    port: 7000
  database:
    client: pg
    connection:
      database: backstage
      host: backstage-postgres
      user: backstage
      port: 5432
      ssl:
        ca: "/config/certs/root.crt"
        key: "/config/certs/client.key"
        cert: "/config/certs/client.crt"
  csp:
    connect-src: ["'self'", 'http:', 'https:']
  cors:
    origin: "*"
    methods: [GET, POST, PUT, DELETE]
    credentials: true
auth:
  providers: {}
techdocs:
  builder: 'local'
  generators:
    techdocs: 'docker'
  publisher:
    type: 'local'
catalog:
  rules:
    - allow: [Component, System, API, Group, User, Template, Location]
  locations:
    - type: file
      target: "./random-word-config.yaml"
    - type: file
      target: "./backstage-backend-config.yaml"
    - type: file
      target: "./backstage-postgres-config.yaml"
kubernetes:
  serviceLocatorMethod:
    type: 'multiTenant'
  clusterLocatorMethods:
    - type: 'config'
      clusters:
        - url: 'https://kubernetes.default.svc'
          name: microk8s-cluster
          authProvider: serviceAccount
          serviceAccountToken:
            $file: /config/sa/token.txt
