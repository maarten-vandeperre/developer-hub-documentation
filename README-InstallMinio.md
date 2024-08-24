# Minio Installation
MinIO is an open-source, high-performance, distributed object storage system designed for storing unstructured data such as photos, 
videos, log files, backups, and container images. It is compatible with Amazon S3 APIs, making it easy to integrate with existing cloud-native applications. 
MinIO is known for its simplicity, scalability, and robustness, enabling it to handle petabytes of data with minimal resource consumption. 
It is often used in cloud-native environments, including Kubernetes, and supports features like erasure coding, bitrot protection, and encryption. 
MinIO can be deployed on-premises, in the cloud, or at the edge, making it versatile for various storage needs.

## Installation of Minio
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
   1. The API route: https://minio-api-demo-project.apps.cluster-475kf.475kf.sandbox268.opentlc.com
   2. The web UI route: https://minio-webui-demo-project.apps.cluster-475kf.475kf.sandbox268.opentlc.com