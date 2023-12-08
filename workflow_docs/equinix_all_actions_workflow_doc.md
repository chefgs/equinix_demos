# Equinix All GitHub Actions Demos

[![Equinix-Metal-All_GHActions-Demo](https://github.com/chefgs/equinix_demos/actions/workflows/equinix_all_actions_workflow.yml/badge.svg?branch=main)](https://github.com/chefgs/equinix_demos/actions/workflows/equinix_all_actions_workflow.yml)

## Objective of this Workflow
The provided code is a part of a GitHub Actions workflow that manages resources on Equinix Metal.

## Workflow Pre-requisites
We need to get the metal user API key `METAL_AUTH_TOKEN` from Equinix user settings and we will be using it for the project creation authentication purposes. 

The `METAL_AUTH_TOKEN` has to be added as a GitHub repo secret for further use it in the GitHub action implementation.

## Workflow explanation
The workflow consists of a single job named `manage-metal-project-device`, which runs on the latest version of Ubuntu. This job performs several steps:

### Step 1 Create Temporary Project 
This step uses the `equinix-labs/metal-project-action` GitHub Action to create a temporary project on Equinix Metal.

It requires a user token, which should be stored as a secret in your GitHub repository under the name `METAL_AUTH_TOKEN`. 

The output of this step, which includes the project's SSH keys and project ID, is stored in the metal-project id.

### Step 2 Use the Project ID outputs (display it)
In this step simply display the name and ID of the project created in a previous step. 

It does this by echoing the `PROJECT_NAME` and `PROJECT_ID` environment variables, which are set using the outputs from the metal-project step.

### Step 3 Create device in temporary project
This step uses the `equinix-labs/metal-device-action` GitHub Action to create a device in the temporary project.

The authentication token and project ID for this action are obtained from the outputs of the metal-project step. 

The device is created in the `'da'` metro, with the `'m3.small.x86'` plan, and the `'ubuntu_22_04'` operating system. If the creation of the device fails, the workflow will continue to the next step due to the `continue-on-error: true` setting.

### Step 4 SSH into Metal Device and Display CloudInit Logs
In this step the `ssh` command is used to connect to the metal device. 

The `-o StrictHostKeyChecking=no` option is used to automatically add new host keys to the user known hosts files and to prevent user prompts. The `-i` option is used to specify the private SSH key, which is obtained from the `PROJECT_PRIVATE_SSH_KEY` environment variable. 

The cat `/var/log/cloud-init-output.log && exit` command is then run on the metal device to display the cloud-init logs and then exit the SSH session.

### Step 5 Delete temporary project & device"
This step uses the `equinix-labs/metal-sweeper-action` GitHub Action to delete the temporary project and device. 

It requires the user token from the METAL_AUTH_TOKEN secret and the project ID output from the metal-project step.

## Workflow Logs
The workflow logs can be viewable from `Repo > Actions` tab