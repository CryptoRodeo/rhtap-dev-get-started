local params = import 'params.libsonnet';

[
   {
      "apiVersion": "v1",
      "kind": "Service",
      "metadata": {
         "name": params.name,
         "namespace": params.namespace
      },
      "spec": {
         "ports": [
            {
               "port": params.servicePort,
               "targetPort": params.containerPort
            }
         ],
         "selector": {
            "app": params.name
         },
         "type": params.type
      }
   },
   {
      "apiVersion": "apps/v1",
      "kind": "Deployment",
      "metadata": {
         "name": params.name,
          "namespace": params.namespace
      },
      "spec": {
         "replicas": params.replicas,
         "revisionHistoryLimit": 3,
         "selector": {
            "matchLabels": {
               "app": params.name
            },
         },
         "template": {
            "metadata": {
               "labels": {
                  "app": params.name
               }
            },
            "spec": {
               "containers": [
                  {
                     "image": params.image,
                     "name": params.name,
                     "ports": [
                     {
                        "containerPort": params.containerPort
                     }
                     ]
                  }
               ]
            }
         }
      }
   }
]
