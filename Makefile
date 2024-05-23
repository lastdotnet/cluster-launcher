aws:
	cd aws && terraform init && terraform apply

kubeconfig-aws:
	aws eks --region $(shell cd aws && terraform output -raw region) update-kubeconfig --name $(shell cd aws && terraform output -raw cluster_name)

destroy-aws:
	cd aws && terraform destroy

azure:
	cd azure && terraform init && terraform apply

kubeconfig-azure:
	az aks get-credentials -a -g $(shell cd azure && terraform output -raw resource_group) -n $(shell cd azure && terraform output -raw cluster_name)

destroy-azure:
	cd azure && terraform destroy

do:
	cd do && terraform init && terraform apply

kubeconfig-do:
	doctl kubernetes cluster kubeconfig save $(shell cd do && terraform output -raw cluster_name)

destroy-do:
	cd do && terraform destroy

gcp-pre:
	cd gcp && terraform init && terraform apply

gcp-post:
	kubectl patch storageclass standard-rwo -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
	kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
	cd gcp && kubectl apply -f storage-snapshot-class.yml

kubeconfig-gcp:
	gcloud container clusters get-credentials $(shell cd gcp && terraform output -raw cluster_name) --project $(shell cd gcp && terraform output -raw project_id) --region $(shell cd gcp && terraform output -raw location)

gcp: gcp-pre kubeconfig-gcp gcp-post

destroy-gcp:
	cd gcp && terraform destroy

hcloud:
	cd hcloud && terraform init && terraform apply && cd ansible && make provision

kubeconfig-hcloud:
	scp $(shell cd hcloud && terraform output -raw hcloud_config) "$(HOME)/.kube/config-hcloud"
	KUBECONFIG="$(HOME)/.kube/config:$(HOME)/.kube/config-hcloud" kubectl config view --flatten > "$(HOME)/.kube/tmpcfg" && mv -f "$(HOME)/.kube/tmpcfg" "$(HOME)/.kube/config" && kubectl config use-context $(shell kubectl config current-context --kubeconfig="$(HOME)/.kube/config-hcloud")

destroy-hcloud:
	cd hcloud && terraform destroy
	rm "$(HOME)/.kube/config-hcloud"


.PHONY: aws kubeconfig-aws destroy-aws azure kubeconfig-azure destroy-azure do kubeconfig-do destroy-do gcp kubeconfig-gcp destroy-gcp hcloud kubeconfig-hcloud destroy-hcloud
