apiVersion: core.oam.dev/v1alpha2
kind: ApplicationConfiguration
metadata:
  annotations:
    appId: flycore
    clusterId: master
    namespaceId: ${NAMESPACE_ID}
    stageId: prod
  name: flycore
spec:
  components:
  - dependencies: []
    parameterValues:
    - name: REPLICAS
      toFieldPaths:
      - spec.replicas
      value: 1
    - name: Global.ENDPOINT_PAAS_GATEWAY
      value: prod-flycore-paas-gateway
    - name: Global.ENDPOINT_PAAS_APPMANAGER
      value: sreworks-appmanager
    - name: Global.NETWORK_PROTOCOL
      value: http
    - name: Global.ENV_TYPE
      value: Standalone
    - name: Global.DNS_PAAS_HOME
      value: '{{Global.COOKIE_DOMAIN}}'
    - name: Global.DB_NAME_AUTHPROXY
      value: abm_paas_authproxy
    - name: Global.DB_NAME
      value: abm_paas_authproxy
    - name: Global.DEFAULT_AMDIN_AVATOR
      value: /static/icons/aliyun.png
    - name: Global.URL_PAAS_HOME
      value: '{{Global.HOME_URL}}'
    - name: Global.LOGIN_URL
      value: fake-login-url
    - name: Global.ENDPOINT_PAAS_AUTHPROXY
      value: prod-flycore-paas-authproxy
    - name: Global.NAMESPACE_DATAOPS
      value: sreworks-dataops
    - name: Global.ACCOUNT_SUPER_ID
      value: admin
    - name: Global.ACCOUNT_SUPER_ACCESS_ID
      value: test-access-id
    - name: Global.ACCOUNT_SUPER_ACCESS_KEY
      value: test-access-key
    - name: Global.ACCOUNT_SUPER_PK
      value: '999999999'
    - name: Global.POSTRUN_WAIT_TIME
      value: 5s
    - name: Global.CORE_STAGE_ID
      value: prod
    - name: Global.CORE_APP_ID
      value: flycore
    revisionName: K8S_MICROSERVICE|paas-frontend|_
    scopes:
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Cluster
        name: '{{ Global.CLUSTER_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Namespace
        name: '{{ Global.NAMESPACE_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Stage
        name: '{{ Global.STAGE_ID }}'
    traits:
    - name: service.trait.abm.io
      runtime: post
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 80
    - name: ingress.trait.abm.io
      runtime: post
      spec:
        rules:
        - host: '{{ Global.COOKIE_DOMAIN }}'
          http:
            paths:
            - backend:
                service:
                  name: prod-flycore-paas-frontend
                  port:
                    number: 80
              path: /
              pathType: ImplementationSpecific
  - dependencies: []
    parameterValues:
    - name: REPLICAS
      toFieldPaths:
      - spec.replicas
      value: 1
    - name: Global.NACOS_NAMESPACE
      value: ad2d92c6-1a21-47ac-9da8-203fcbed9146
    - name: Global.NACOS_ENDPOINT
      value: prod-flycore-paas-nacos:8848
    - name: Global.MANAGER_SERVER_PORT
      value: '7002'
    - name: Global.STORE_NACOS_GROUP
      value: DEFAULT_GROUP
    - name: Global.STORE_NACOS_DATA_ID
      value: abm-paas-gateway.route.config_default_default
    - name: Global.REDIS_DB
      value: '0'
    - name: Global.ENDPOINT_PAAS_AUTHPROXY
      value: prod-flycore-paas-authproxy
    - name: Global.AUTH_JWT_SECRET
      value: '{{Global.APPMANAGER_JWT_SECRET_KEY}}'
    - name: Global.AUTH_ADMIN_TOKEN
      value: '{{Global.APPMANAGER_JWT_SECRET_KEY}}'
    revisionName: K8S_MICROSERVICE|paas-gateway|_
    scopes:
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Cluster
        name: '{{ Global.CLUSTER_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Namespace
        name: '{{ Global.NAMESPACE_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Stage
        name: '{{ Global.STAGE_ID }}'
    traits:
    - name: service.trait.abm.io
      runtime: post
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 7001
  - dependencies: []
    parameterValues:
    - name: REPLICAS
      toFieldPaths:
      - spec.replicas
      value: 1
    - name: Global.ENDPOINT_PAAS_HOME
      value: prod-flycore-paas-frontend
    - name: Global.ENDPOINT_PAAS_TKGONE
      value: prod-flycore-paas-tkgone
    - name: Global.URL_PAAS_HOME
      value: '{{Global.HOME_URL}}'
    - name: Global.DB_NAME
      value: abm_paas_action
    revisionName: K8S_MICROSERVICE|paas-action|_
    scopes:
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Cluster
        name: '{{ Global.CLUSTER_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Namespace
        name: '{{ Global.NAMESPACE_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Stage
        name: '{{ Global.STAGE_ID }}'
    traits:
    - name: service.trait.abm.io
      runtime: post
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 7001
  - dependencies: []
    parameterValues:
    - name: REPLICAS
      toFieldPaths:
      - spec.replicas
      value: 1
    - name: Global.DB_NAME
      value: abm_paas_nacos
    revisionName: K8S_MICROSERVICE|paas-nacos|_
    scopes:
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Cluster
        name: '{{ Global.CLUSTER_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Namespace
        name: '{{ Global.NAMESPACE_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Stage
        name: '{{ Global.STAGE_ID }}'
    traits:
    - name: service.trait.abm.io
      runtime: post
      spec:
        ports:
        - port: '8848'
          protocol: TCP
          targetPort: 8848
  - dependencies: []
    parameterValues:
    - name: REPLICAS
      toFieldPaths:
      - spec.replicas
      value: 1
    - name: Global.DB_NAME
      value: abm_paas_authproxy
    - name: Global.REDIS_DB
      value: '0'
    - name: Global.DATABASE_AUTH_SERVICE_MGR_CLASS_NAME
      value: com.alibaba.tesla.authproxy.service.impl.DataBaseAuthServiceManager
    - name: Global.DATABASE_LOGIN_INTERCEPTOR_CLASS_NAME
      value: com.alibaba.tesla.authproxy.interceptor.DataBaseLoginInterceptor
    - name: Global.ACCOUNT_SUPER_ACCESS_KEY
      value: test-access-key
    - name: Global.ACCOUNT_SUPER_PK
      value: '999999999'
    - name: Global.ACCOUNT_SUPER_ACCESS_ID
      value: test-access-id
    - name: Global.ACCOUNT_SUPER_ID
      value: admin
    - name: Global.DNS_PAAS_HOME
      value: '{{Global.COOKIE_DOMAIN}}'
    - name: Global.NETWORK_PROTOCOL
      value: http
    - name: Global.URL_PAAS_HOME
      value: '{{Global.HOME_URL}}'
    - name: Global.OAUTH2_JWT_SECRET_KEY
      value: '{{Global.APPMANAGER_JWT_SECRET_KEY}}'
    revisionName: K8S_MICROSERVICE|paas-authproxy|_
    scopes:
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Cluster
        name: '{{ Global.CLUSTER_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Namespace
        name: '{{ Global.NAMESPACE_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Stage
        name: '{{ Global.STAGE_ID }}'
    traits:
    - name: service.trait.abm.io
      runtime: post
      spec:
        ports:
        - port: 80
          protocol: TCP
          targetPort: 7001
  - dataInputs: []
    dataOutputs:
    - fieldPath: '{{ spec.env.DB_HOST }}'
      name: Global.DB_HOST
    - fieldPath: '{{ spec.env.DB_PASSWORD }}'
      name: Global.DB_PASSWORD
    - fieldPath: '{{ spec.env.DB_PORT }}'
      name: Global.DB_PORT
    - fieldPath: '{{ spec.env.DB_USER }}'
      name: Global.DB_USER
    - fieldPath: '{{ spec.env.APPMANAGER_ACCESS_ID }}'
      name: Global.APPMANAGER_USERNAME
    - fieldPath: '{{ spec.env.APPMANAGER_ACCESS_SECRET }}'
      name: Global.APPMANAGER_PASSWORD
    - fieldPath: '{{ spec.env.APPMANAGER_CLIENT_ID }}'
      name: Global.APPMANAGER_CLIENT_ID
    - fieldPath: '{{ spec.env.APPMANAGER_CLIENT_SECRET }}'
      name: Global.APPMANAGER_CLIENT_SECRET
    - fieldPath: '{{ spec.env.COOKIE_DOMAIN }}'
      name: Global.COOKIE_DOMAIN
    - fieldPath: '{{ spec.env.APPMANAGER_PACKAGE_ACCESS_KEY }}'
      name: Global.APPMANAGER_PACKAGE_ACCESS_KEY
    - fieldPath: '{{ spec.env.APPMANAGER_PACKAGE_SECRET_KEY }}'
      name: Global.APPMANAGER_PACKAGE_SECRET_KEY
    - fieldPath: '{{ spec.env.APPMANAGER_PACKAGE_ENDPOINT_PROTOCOL }}'
      name: Global.APPMANAGER_PACKAGE_ENDPOINT_PROTOCOL
    - fieldPath: '{{ spec.env.APPMANAGER_PACKAGE_ENDPOINT }}'
      name: Global.APPMANAGER_PACKAGE_ENDPOINT
    - fieldPath: '{{ spec.env.STORAGE_CLASS }}'
      name: Global.STORAGE_CLASS
    - fieldPath: '{{ spec.env.ACCOUNT_SUPER_CLIENT_ID }}'
      name: Global.ACCOUNT_SUPER_CLIENT_ID
    - fieldPath: '{{ spec.env.ACCOUNT_SUPER_CLIENT_SECRET }}'
      name: Global.ACCOUNT_SUPER_CLIENT_SECRET
    - fieldPath: '{{ spec.env.DATA_ES_PASSWORD }}'
      name: Global.DATA_ES_PASSWORD
    - fieldPath: '{{ spec.env.DATA_ES_USER }}'
      name: Global.DATA_ES_USER
    - fieldPath: '{{ spec.env.DATA_ES_HOST }}'
      name: Global.DATA_ES_HOST
    - fieldPath: '{{ spec.env.DATA_ES_PORT }}'
      name: Global.DATA_ES_PORT
    - fieldPath: '{{ spec.env.DATA_PROM_HOST }}'
      name: Global.DATA_PROM_HOST
    - fieldPath: '{{ spec.env.DATA_PROM_PORT }}'
      name: Global.DATA_PROM_PORT
    - fieldPath: '{{ spec.env.DATA_DB_PORT }}'
      name: Global.DATA_DB_PORT
    - fieldPath: '{{ spec.env.DATA_DB_HOST }}'
      name: Global.DATA_DB_HOST
    - fieldPath: '{{ spec.env.DATA_DB_USER }}'
      name: Global.DATA_DB_USER
    - fieldPath: '{{ spec.env.DATA_DB_PASSWORD }}'
      name: Global.DATA_DB_PASSWORD
    - fieldPath: '{{ spec.env.KAFKA_ENDPOINT }}'
      name: Global.KAFKA_ENDPOINT
    - fieldPath: '{{ spec.env.MINIO_ENDPOINT }}'
      name: Global.MINIO_ENDPOINT
    - fieldPath: '{{ spec.env.MINIO_ACCESS_KEY }}'
      name: Global.MINIO_ACCESS_KEY
    - fieldPath: '{{ spec.env.MINIO_SECRET_KEY }}'
      name: Global.MINIO_SECRET_KEY
    - fieldPath: '{{ spec.env.HOME_URL }}'
      name: Global.HOME_URL
    - fieldPath: '{{ spec.env.REDIS_ENDPOINT }}'
      name: Global.REDIS_ENDPOINT
    - fieldPath: '{{ spec.env.APPMANAGER_REDIS_PORT }}'
      name: Global.APPMANAGER_REDIS_PORT
    - fieldPath: '{{ spec.env.REDIS_PASSWORD }}'
      name: Global.REDIS_PASSWORD
    - fieldPath: '{{ spec.env.APPMANAGER_JWT_SECRET_KEY }}'
      name: Global.APPMANAGER_JWT_SECRET_KEY
    - fieldPath: '{{ spec.env.PLATFORM_NAME }}'
      name: Global.PLATFORM_NAME
    - fieldPath: '{{ spec.env.PLATFORM_LOGO }}'
      name: Global.PLATFORM_LOGO
    - fieldPath: '{{ spec.env.K8S_NAMESPACE }}'
      name: Global.K8S_NAMESPACE
    - fieldPath: '{{ spec.env.ENDPOINT_PAAS_MINIO }}'
      name: Global.ENDPOINT_PAAS_MINIO
    - fieldPath: '{{ spec.env.ZOOKEEPER_ENDPOINT }}'
      name: Global.ZOOKEEPER_ENDPOINT
    - fieldPath: '{{ spec.env.ACCOUNT_SUPER_SECRET_KEY }}'
      name: Global.ACCOUNT_SUPER_SECRET_KEY
    - fieldPath: '{{ spec.env.ADMIN_INIT_PASSWORD }}'
      name: Global.ADMIN_INIT_PASSWORD
    dependencies: []
    parameterValues:
    - name: keys
      toFieldPaths:
      - spec.keys
      value:
      - DB_HOST
      - DB_PASSWORD
      - DB_PORT
      - DB_USER
      - APPMANAGER_ACCESS_ID
      - APPMANAGER_ACCESS_SECRET
      - APPMANAGER_CLIENT_ID
      - APPMANAGER_CLIENT_SECRET
      - COOKIE_DOMAIN
      - APPMANAGER_PACKAGE_ACCESS_KEY
      - APPMANAGER_PACKAGE_SECRET_KEY
      - APPMANAGER_PACKAGE_ENDPOINT_PROTOCOL
      - APPMANAGER_PACKAGE_ENDPOINT
      - STORAGE_CLASS
      - ACCOUNT_SUPER_CLIENT_ID
      - ACCOUNT_SUPER_CLIENT_SECRET
      - DATA_ES_PASSWORD
      - DATA_ES_USER
      - DATA_ES_HOST
      - DATA_ES_PORT
      - DATA_PROM_HOST
      - DATA_PROM_PORT
      - DATA_DB_HOST
      - DATA_DB_PORT
      - DATA_DB_USER
      - DATA_DB_PASSWORD
      - KAFKA_ENDPOINT
      - MINIO_ENDPOINT
      - MINIO_ACCESS_KEY
      - MINIO_SECRET_KEY
      - HOME_URL
      - REDIS_ENDPOINT
      - APPMANAGER_REDIS_PORT
      - REDIS_PASSWORD
      - APPMANAGER_JWT_SECRET_KEY
      - PLATFORM_NAME
      - PLATFORM_LOGO
      - K8S_NAMESPACE
      - ENDPOINT_PAAS_MINIO
      - ZOOKEEPER_ENDPOINT
      - ACCOUNT_SUPER_SECRET_KEY
      - ADMIN_INIT_PASSWORD
    revisionName: RESOURCE_ADDON|system-env@system-env|1.0
    scopes:
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Cluster
        name: '{{ Global.CLUSTER_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Namespace
        name: '{{ Global.NAMESPACE_ID }}'
    - scopeRef:
        apiVersion: apps.abm.io/v1
        kind: Stage
        name: '{{ Global.STAGE_ID }}'
    traits: []
  parameterValues:
  - name: CLUSTER_ID
    value: master
  - name: NAMESPACE_ID
    value: ${NAMESPACE_ID}
  - name: STAGE_ID
    value: prod
  - name: APP_ID
    value: flycore
  - name: REDIS_HOST
    value: '{{ env.APPMANAGER_REDIS_HOST }}'
  - name: REDIS_PORT
    value: '{{ env.APPMANAGER_REDIS_PORT }}'
  - name: REDIS_PASSWORD
    value: '{{ env.APPMANAGER_REDIS_PASSWORD }}'
  - name: REDIS_HOST
    value: '{{ env.APPMANAGER_REDIS_HOST }}'
  - name: REDIS_PORT
    value: '{{ env.APPMANAGER_REDIS_PORT }}'
  - name: REDIS_PASSWORD
    value: '{{ env.APPMANAGER_REDIS_PASSWORD }}'
  policies: []
  workflow:
    steps: []
