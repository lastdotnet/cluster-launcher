aws:
	cd aws && terraform init && terraform apply

destroy-aws:
	cd aws && terraform destroy

.PHONY: aws destroy-aws
