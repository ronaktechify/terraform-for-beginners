# Terraform Demo — Student Reference

This repository is a compact, hands-on Terraform demo for learning core Terraform concepts: providers, resources, variables, outputs, and state management. It's designed for students to quickly experiment and practice safe workflows.

## Project Structure

- `main.tf` — core Terraform configuration and resources used in the demo.
- `provider.tf` — provider configuration (e.g., cloud provider settings).
- `variables.tf` — input variable definitions and descriptions.
- `terraform.tfvars` — example values for variables used during local runs.
- `outputs.tf` — output values exposed after `apply`.
- `terraform.tfstate` / `terraform.tfstate.backup` — local state files (auto-generated).
- `cmd.txt` — example commands or notes.

> Note: Keep state files out of version control in real projects. They are committed here only for demonstration purposes.

## Prerequisites

- Install Terraform (recommended version >= 1.0). See https://www.terraform.io/downloads.
- Configure any provider credentials required by `provider.tf` (environment variables, shared config, or provider-specific CLI).
- A terminal with network access to apply resources (if provider provisions cloud resources).

## Quickstart — safe student workflow

1. Initialize the working directory (installs provider plugins):

```bash
terraform init
```

2. See what Terraform will do (plan):

```bash
terraform plan -out=tfplan
```

3. Review the plan and apply it (creates resources):

```bash
terraform show tfplan
terraform apply "tfplan"
```

4. When finished, destroy resources to avoid charges:

```bash
terraform destroy
```

Tips:
- Use `terraform plan -out=NAME` to produce a reusable plan file.
- Avoid committing `terraform.tfstate` to git in real projects — use remote state (e.g., S3, GCS, Terraform Cloud).

## Variables and Overrides

- Default values and types are defined in `variables.tf`.
- Local overrides can be provided via `terraform.tfvars` or a custom `*.tfvars` file:

```bash
terraform apply -var-file="terraform.tfvars"
```

- You can also set individual variables on the CLI with `-var 'name=value'` or via environment variables `TF_VAR_name`.

## Outputs

- Outputs are defined in `outputs.tf`. After `apply`, show them with:

```bash
terraform output
```

To get a specific output value:

```bash
terraform output <output_name>
```

## State Management (student notes)

- Local state: the `terraform.tfstate` file stores resource mappings. Treat it as sensitive data.
- Remote state: for team projects, configure a backend (e.g., S3 + DynamoDB for locking, or Terraform Cloud).
- Locking: enable state locking to avoid concurrent updates.

## Common Troubleshooting

- `terraform init` errors: check provider versions and network access.
- `plan`/`apply` fails: examine the error message, then check credentials and resource limits.
- Stale state issues: run `terraform refresh` (with caution) or inspect the resource in the provider console.

If your last `terraform destroy` failed, try:

```bash
terraform plan
terraform destroy -refresh=true
```

Or manually remove problematic resources in the provider console and then run `terraform apply` to reconcile.

## Exercises for students

1. Add a new variable in `variables.tf` and use it in `main.tf` to create an additional (optional) resource.
2. Convert local state to a remote backend (S3/GCS) and demonstrate applying from two different machines.
3. Add an output that exposes a computed value (e.g., resource ID or endpoint URL) and read it via `terraform output`.
4. Experiment with `terraform taint` for forced replacement of a resource.

## Best Practices

- Use version control for `.tf` files but never commit secrets or `terraform.tfstate`.
- Use modules to structure reusable Terraform code.
- Pin provider versions in `required_providers` to avoid unexpected upgrades.
- Add meaningful `description` fields to variables and outputs for clarity.

## References

- Official Terraform docs: https://www.terraform.io/docs
- Remote state and backends: https://www.terraform.io/language/state/backends
