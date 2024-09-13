# Jenkins Installation
Jenkins is an open-source automation server widely used for continuous integration and continuous 
delivery (CI/CD) pipelines. It automates the process of building, testing, and deploying software, 
allowing developers to integrate changes more frequently and reliably. Jenkins supports a vast ecosystem 
of plugins that extend its capabilities to work with various tools, platforms, and technologies. 
It can be easily integrated into any development workflow, providing flexibility to automate a wide 
range of tasks across different environments. Jenkins is highly customizable, 
making it a popular choice for managing complex CI/CD processes in both small and large-scale projects.


https://medium.com/@rajithakumaraprog/how-to-setup-a-jenkins-organization-folder-job-cf6f1a88aecc










## Installation of Jenkins
### Create an admin password
In order to have a hardcoded admin user that we can use, you'll first have to create the password and store it
in a secret. This can be done by applying [](gitops/jenkins/jenkins-admin-secret.yaml), which will configure the 
encoded admin password 'rhdh'.

### Create a persistent volume claim
A Persistent Volume Claim (PVC) in OpenShift is a request for storage by a user or application. It abstracts the details of storage provisioning 
by allowing users to claim a specific amount of storage from a Persistent Volume (PV), which is a piece of storage in the cluster. 
The PVC defines the desired size, access modes, and other properties, while OpenShift dynamically binds it to an available PV that meets the specified 
requirements. Once bound, the PVC provides persistent storage that can be used by pods, ensuring data remains available even if the pod is deleted or rescheduled.

Creating the persistent volume claim is nothing more than applying the yaml definition, which
you can find at [](gitops/minio/minio-persistent-volume-claim.yaml). When applied, you should wait until
it becomes ready, which can take a couple of minutes.

### Create a deployment and expose it
1. Apply [](gitops/minio/minio-deployment.yaml) to have Minio running on OpenShift.
2. Create a service to the running pods by applying [](gitops/minio/minio-service.yaml). 
Both port 9000 (i.e., API port) and 9090 (i.e., web UI port) will be exposed.
3. Now create 2 routes to access Minio outside the OpenShift cluster (e.g., for testing purposes),
by applying [](gitops/minio/minio-route.yaml). _(!!! notice that you will have to chance the
base domain to match yours in the following routes.)_
   1. The API route: https://minio-api-demo-project.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com
   2. The web UI route: https://minio-webui-demo-project.apps.cluster-tqg9r.tqg9r.sandbox1273.opentlc.com