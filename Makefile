aws:
	cd aws && terraform init && terraform apply

aws-backups:
	@read -p "Add backups? Cluster and node must be running... (press any key to continue)"
	cd aws/backups && terraform init && terraform apply

destroy-aws:
	cd aws && terraform destroy

destroy-aws-backups:
	cd aws/backups && terraform destroy

azure:
	cd azure && terraform init && terraform apply

destroy-azure:
	cd azure && terraform destroy

do:
	cd do && terraform init && terraform apply

destroy-do:
	cd do && terraform destroy

linode:
	cd linode && terraform init && terraform apply

destroy-linode:
	cd linode && terraform destroy

.PHONY: aws aws-backups destroy-aws destroy-aws-backups azure destroy-azure do destroy-do linode destroy-linode
