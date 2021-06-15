aws:
	cd aws && terraform init && terraform apply
	kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
	cd aws && kubectl apply -f storage-snapshot-crd.yml
	cd aws && kubectl apply -f storage-snapshot-class.yml

kubeconfig-aws:
	aws eks --region $(shell cd aws && terraform output -raw region) update-kubeconfig --name $(shell cd aws && terraform output -raw cluster_name)

aws-backups:
	@read -p "Add backups? Cluster and node must be running... (press any key to continue)"
	cd aws/backups && terraform init && terraform apply

destroy-aws:
	cd aws && terraform destroy

destroy-aws-backups:
	cd aws/backups && terraform destroy

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

gcp:
	@echo "Don't forget to run 'make gcp-post' as the last step."
	@echo "Your cluster will not run as a proper THORNode if skipped."
	@echo "Read the docs. Continue [y/n] " && read ans && [ $${ans:-N} == y ]
	cd gcp && terraform init && terraform apply

gcp-post:
	kubectl patch storageclass premium-rwo -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
	kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubeconfig-gcp:
	gcloud container clusters get-credentials $(shell cd gcp && terraform output -raw cluster_name) --region $(shell cd gcp && terraform output -raw location)

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

linode:
	@echo "Don't forget to run 'make linode-post' after this step."
	@echo "Your cluster will not run as a proper THORNode if skipped."
	@echo "Read the docs. Continue [y/n] " && read ans && [ $${ans:-N} == y ]
	cd linode && terraform init && terraform apply

linode-post:
	cd linode && kubectl apply -f metrics-server.yml

kubeconfig-linode:
	KUBECONFIG="$(HOME)/.kube/config:$(HOME)/.kube/config-linode" kubectl config view --flatten > "$(HOME)/.kube/tmpcfg" && mv -f "$(HOME)/.kube/tmpcfg" "$(HOME)/.kube/config" && kubectl config use-context $(shell kubectl config current-context --kubeconfig="$(HOME)/.kube/config-linode")

destroy-linode:
	cd linode && terraform destroy

.PHONY: aws kubeconfig-aws aws-backups destroy-aws destroy-aws-backups azure kubeconfig-azure destroy-azure do kubeconfig-do destroy-do gcp kubeconfig-gcp destroy-gcp hcloud kubeconfig-hcloud destroy-hcloud linode linode-post kubeconfig-linode destroy-linode
