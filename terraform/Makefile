.PHONY: init plan apply destroy setup-backend add-my-ip

WHITELIST_FILE := ssh_whitelist.auto.tfvars

setup-backend:
	@if [ ! -f backend.tf ]; then \
		echo "backend.tf not found. Copy the example first:"; \
		echo "  cp backend.tf.example backend.tf"; \
		echo "Then fill in your bucket name, region, and key."; \
		exit 1; \
	fi
	terraform init -reconfigure

add-my-ip:
	@MY_IP=$$(curl -s https://checkip.amazonaws.com | tr -d '[:space:]'); \
	MY_CIDR="$$MY_IP/32"; \
	if [ -f $(WHITELIST_FILE) ]; then \
		EXISTING=$$(grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[0-9]+' $(WHITELIST_FILE) | tr '\n' ' '); \
	else \
		EXISTING=""; \
	fi; \
	if echo " $$EXISTING " | grep -qF " $$MY_CIDR "; then \
		echo "Your IP $$MY_CIDR is already in the whitelist."; \
	else \
		ALL_IPS=$$(echo "$$EXISTING $$MY_CIDR" | tr ' ' '\n' | grep -v '^$$' | sort -u | tr '\n' ' '); \
		LIST=$$(for ip in $$ALL_IPS; do printf '"%s", ' "$$ip"; done | sed 's/, $$//'); \
		echo "ssh_whitelist = [$$LIST]" > $(WHITELIST_FILE); \
		echo "Added $$MY_CIDR. Current whitelist:"; \
		cat $(WHITELIST_FILE); \
	fi

init:
	terraform init

plan:
	terraform fmt --recursive
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy
