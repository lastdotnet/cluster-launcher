aws:
	cd aws && terraform init && terraform apply

aws-backups:
	@read -p "Add backups? Cluster and node must be running... (press any key to continue)"
	cd aws/backups && terraform init && terraform apply

destroy-aws:
	cd aws && terraform destroy

destroy-aws-backups:
	cd aws/backups && terraform destroy

do:
	cd do && terraform init && terraform apply

destroy-do:
	cd do && terraform destroy

.PHONY: aws destroy-aws do destroy-do
