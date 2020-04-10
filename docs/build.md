## Prerequisite
Install the Azure CLI, choose which platform you were using [here](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest)

```bash
$ kubectl config view
$
```


## Connect to the Azure Kubernetes Service (AKS) cluster
1. Login using your Azure Active Directory account
```bash
$ az login
Note, we have launched a browser for you to login. For old experience with device code, use "az login --use-device-code"
You have logged in. Now let us find all the subscriptions to which you have access...
[
  {
    "cloudName": "AzureCloud",
    "id": "abc1234456223ffhhhhhh",
    "isDefault": true,
    "name": "Pay-As-You-Go",
    "state": "Enabled",
    "tenantId": "asdf93k-sej3-do3d-3ffd-3osdklfasdlk",
    "user": {
      "name": "ramil.joaquin@ubidy.com",
      "type": "user"
    }
  }
]
$
```

2. To manage a Kubernetes cluster, you use kubectl, the Kubernetes command-line client. If you use Azure Cloud Shell, kubectl is already installed. To install kubectl locally, use the [az aks install-cli](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-install-cli) command:
```bash
$ az aks install-cli
$
```
3. To configure kubectl to connect to your Kubernetes cluster, use the [az aks get-credentials](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-get-credentials) command. This command downloads credentials and configures the Kubernetes CLI to use them.
```bash
$ az aks get-credentials --resource-group Ubidy.IT.Kubernetes.SoutheastAsia.DevLab --name ubidy-kube-devlab
Merged "ubidy-kube-devlab" as current context in /Users/ramil.ubidy/.kube/config
$
```
4. To verify the connection to your cluster, use the [kubectl get](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get) command to return a list of the cluster nodes.
```bash
$ kubectl get nodes
NAME                       STATUS   ROLES   AGE   VERSION
aks-agentpool-13901333-0   Ready    agent   46m   v1.12.8
aks-agentpool-13901333-1   Ready    agent   46m   v1.12.8
aks-agentpool-13901333-2   Ready    agent   46m   v1.12.8

$
```
The following example output above shows the three nodes created in the previous steps. Make sure that the status of the node is Ready

5. To initialize your terraform provider, run the command
```bash
$ terraform init
$
```

6. Execute the terraform apply

```bash
$ terraform apply
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_namespace.this will be created
  + resource "kubernetes_namespace" "this" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "my-first-devlab-namespace"
          + resource_version = (known after apply)
          + self_link        = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

kubernetes_namespace.this: Creating...
kubernetes_namespace.this: Creation complete after 1s [id=my-first-devlab-namespace]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
$ 
```

7. Try to destroy it by executing the terraform destroy
```bash
$ terraform destroy
kubernetes_namespace.example: Refreshing state... [id=my-first-lab-namespace]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # kubernetes_namespace.this will be destroyed
  - resource "kubernetes_namespace" "this" {
      - id = "my-first-devlab-namespace" -> null

      - metadata {
          - annotations      = {} -> null
          - generation       = 0 -> null
          - labels           = {} -> null
          - name             = "my-first-devlab-namespace" -> null
          - resource_version = "114114" -> null
          - self_link        = "/api/v1/namespaces/my-first-devlab-namespace" -> null
          - uid              = "149de9c8-a78a-11e9-b4a9-fa5c341ae14f" -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

kubernetes_namespace.example: Destroying... [id=my-first-lab-namespace]
kubernetes_namespace.example: Destruction complete after 7s

Destroy complete! Resources: 1 destroyed.
$ 
```

## Run the application