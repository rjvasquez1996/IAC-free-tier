.PHONY: init plan apply destroy setup-backend

setup-backend:
	@if [ ! -f backend.tf ]; then \
		echo "backend.tf not found. Copy the example first:"; \
		echo "  cp backend.tf.example backend.tf"; \
		echo "Then fill in your bucket name, region, and key."; \
		exit 1; \
	fi
	terraform init -reconfigure

init:
	terraform init

plan:
	terraform fmt --recursive
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy
