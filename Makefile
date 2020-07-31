aws:
	cd aws && terraform init && terraform apply

destroy-aws:
	cd aws && terraform destroy

do:
	cd do && terraform init && terraform apply

destroy-do:
	cd do && terraform destroy

.PHONY: aws destroy-aws do destroy-do
