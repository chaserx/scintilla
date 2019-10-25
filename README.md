# Scintilla

Scintilla: A spark. A script that sparks an AWS development environment into being.

## Dependencies

Requires the use of [Terraform](https://terraform.io) for managing infrastructure from code.

* an AWS account
* AWS cli tools
* On MacOS, install terraform with `brew install terraform`. Assuming that you already have [homebrew](https://brew.sh) installed.

## Configuration

Adjust settings in the `var.tf` file to suit your needs. Adjustments like the chosen AMI, AWS EC2 instance type, and key pair are available.

## Developing

* Install dependencies
* Run `terraform init`
* When you make changes, try to keep it clean with `terraform fmt`
* See what's going to change with `terraform plan`
* When satified, run `terraform apply` to spin up the proposed environment.

## License

[The Unlicense](https://choosealicense.com/licenses/unlicense/)
