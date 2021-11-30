APB=ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook --diff
APB_LIN=ANSIBLE_STRATEGY_PLUGINS=linear $(APB)
INVENTORY=inventory/inventory.yml

initialize:
	@$(APB) init.yml -i $(INVENTORY)

kubernetes:
	@$(APB) --become --become-user=root ../../.kubespray/cluster.yml -i $(INVENTORY)
	@$(APB) post.yml -i $(INVENTORY)

remove-kubernetes:
	@$(APB_LIN) --become --become-user=root ../../.kubespray/reset.yml -i $(INVENTORY)

hcloud:
	@$(APB) hcloud.yml -i $(INVENTORY)

remove-hcloud:
	@$(APB) hcloud.yml -e state=absent -i $(INVENTORY)

provision: initialize kubernetes hcloud

.PHONY: initialize kubernetes remove-kubernetes hcloud remove-hcloud provision
