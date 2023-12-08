# Equinix GitHub Actions Demos

[![Equinix-Metal-Actions-Demo](https://github.com/chefgs/equinix_demos/actions/workflows/equinix_workflow.yml/badge.svg?branch=main)](https://github.com/chefgs/equinix_demos/actions/workflows/equinix_workflow.yml)

## Objective of this Workflow
This GitHub Actions workflow, named `'Equinix-Metal-Actions-Demo'`, is designed to create a metal instance in an existing project on Equinix Metal, access the metal instance from a GitHub runner, and display the cloud-init logs. The workflow is triggered manually using the workflow_dispatch event.

## Workflow Pre-requisites
We need to get the project `PROJECT_ID` and `PROJECT_TOKEN` from Equinix Project settings and we will be using it in the project for authentication purposes. 

## Workflow explanation
- The workflow uses two environment variables: `PROJECT_ID` and `PROJECT_TOKEN`, which are fetched from the repository's secrets. These are used to authenticate and interact with the Equinix Metal API.

- The workflow consists of two jobs: `manage-metal-resources` and `destroy-metal-resources`.

### manage-metal-resources
The `manage-metal-resources` job runs on the latest version of Ubuntu and performs several steps:

- Create Runner SSH key and Add to Equinix Project: This step updates the system packages, installs `jq` (a command-line JSON processor), and creates a directory for SSH keys. It then generates an SSH key and adds public key to the Equinix Metal project. This is done by making a POST request to the Equinix Metal API.

- Create Metal Device in Project: This step uses the `equinix-labs/metal-device-action` GitHub Action to create a metal device in the project. The metal device is created with specific parameters such as the `metro`, `plan`, and `operating system`. It also includes user data, which is a bash script that simply prints `'Hello, Equinix Metal!'`.

- SSH into Metal Device and Display CloudInit Logs: This step SSHs into the metal device and displays the cloud-init logs. It does this by running the cat `/var/log/cloud-init-output.log` command on the metal device.

### destroy-metal-resources
The destroy-metal-resources job depends on the previously explained `manage-metal-resources` job and is responsible for cleaning up the resources created by the workflow. It uses the `equinix-labs/metal-sweeper-action` GitHub Action to delete the metal device. The `keepProject` input is set to true, which means the project will not be deleted.

### Workflow Logs
The workflow logs can be viewable from `Repo > Actions` tab
