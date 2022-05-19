# secretduty
✨ A GitHub Action that automatically checks for hardcoded secrets in your code. You can integrate it in your CI/CD pipeline.

## Detects
* Passwords
* API tokens
* AWS keys
* Private keys
* Hashed credentials
* Authentication tokens
* Dangerous functions
* Sensitive files

# Installation

## Action
This action fails the build when there is an hardcoded secrets found in your code.

## Inputs
comming soon

## Outputs
`result` - List of vulnerabilities detetced with there severity.

## Example usage

```yaml
on: [push]

jobs:
  secret_checker:
    runs-on: ubuntu-latest
    name: Vulnerabilities check
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Check for vulnerabilities
        id: checks
        uses: maddygoround/secretduty@v1.2
      - name: Get results of scan
        run: echo "Scan Results - ${{ steps.checks.outputs.result }}"
```

# License
The scripts and documentation in this project are released under the [MIT License](LICENSE).