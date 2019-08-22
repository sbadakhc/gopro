# GoPro

Simple in cluster go client based on:
https://github.com/kubernetes/client-go/tree/master/examples/in-cluster-client-configuration

### Authenticating inside the cluster

This example shows you how to configure a client with client-go to authenticate
to the Kubernetes API from an application running inside the Kubernetes cluster.

client-go uses the [Service Account token][sa] mounted inside the Pod at the
`/var/run/secrets/kubernetes.io/serviceaccount` path when the
`rest.InClusterConfig()` is used.

### Build the source

```
GOOS=linux go build -o ./gopro .
```

Then package it to a docker image using the provided Dockerfile to run it on
Kubernetes.

If you are running a [Minikube][mk] cluster, you can build this image directly
on the Docker engine of the Minikube node without pushing it to a registry. To
build the image on Minikube:

```
eval $(minikube docker-env)
docker build -t gopro .
```

If you are not using Minikube, you should build this image and push it to a registry
that your Kubernetes cluster can pull from.

If you have RBAC enabled on your cluster, use the following
snippet to create role binding which will grant the default service account view
permissions.

```
kubectl create clusterrolebinding default-view --clusterrole=view --serviceaccount=default:default
```

Then, run the image in a Pod with a single instance Deployment:

```
kubectl run --generator=run-pod/v1 gopro --image=gopro --image-pull-policy=Never

There are 4 pods in the cluster
There are 4 pods in the cluster
There are 4 pods in the cluster
...
```

You can also verify the client by checking the pods logs.

```
kubectl logs gopro
```

The example now runs on Kubernetes API and successfully queries the number of
pods in the cluster every 10 seconds.

### Clean up

To stop this example and clean up the pod, press <kbd>Ctrl</kbd>+<kbd>C</kbd> on
the `kubectl run` command and then run:

```
kubectl delete deployment demo
```

[sa]: https://kubernetes.io/docs/admin/authentication/#service-account-tokens
[mk]: https://kubernetes.io/docs/getting-started-guides/minikube/
