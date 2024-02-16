# Create Self Hosted Runner Workflow

## Objective of this Workflow
This is a GitHub Actions workflow named `'Equinix-Metal-Self-hosted-Runner-Setup'`. This workflow is designed to create a device in a pre-existing project on Equinix Metal and run a self-hosted runner script for a GitHub repository named 'linktoqr'. Optionally, it can also delete the device and the project.

## Workflow Pre-requisites
We need to get the metal user API key `METAL_AUTH_TOKEN` from Equinix user settings and we will be using it for the project creation authentication purposes. 

The `METAL_AUTH_TOKEN` has to be added as a GitHub repo secret for further use it in the GitHub action implementation.

We also need to get the project `PROJECT_ID` and `PROJECT_TOKEN` from Equinix Project settings and we will be using it in the project for authentication purposes. 

## Workflow explanation
The workflow is manually triggered using the workflow_dispatch event, which has two inputs: Clean_Up_Device and Keep_Project. Clean_Up_Device is a boolean value that determines whether the device should be deleted after the workflow runs, and Keep_Project is a boolean value that determines whether the project should be kept or deleted. Both inputs are required and have default values.

The workflow consists of a single job named create-self-hosted-runner, which runs on the latest version of Ubuntu. 

This job has two steps:

Step 1 "Create metal device in project": This step uses the equinix-labs/metal-device-action@main GitHub Action to create a new device in the specified project. The action requires an authentication token and project ID, which are stored as secrets in your GitHub repository and accessed through environment variables. The device is created in the 'da' metro with the 'm3.small.x86' plan and the 'ubuntu_22_04' operating system. The user_data parameter is used to provide a script that is run on the device when it is created. This script downloads, configures, and runs a GitHub Actions self-hosted runner for the 'linktoqr' repository.

Step 2 "Delete temporary project & device": This step uses the equinix-labs/metal-sweeper-action@main GitHub Action to delete the device and optionally the project. The action requires an authentication token and the project ID from the environment variables. The keepProject parameter is obtained from the Keep_Project input. If Clean_Up_Device is set to 'true', the device and optionally the project will be deleted.

Since it is a DEMO, We are deleting the project as part of the workflow, but recommend skipping this step in a real-world scenario.

## Setup a Self-hosted runner for a specific repository
The comments at the end of the workflow file provide additional We can use the instructions below for setting up the self-hosted runner in the GitHub repository,
- Select the repository where you want to add the self-hosted runner
- Creating a new runner, 
- Copying the runner setup script, pasting it into the user_data section of the device creation step
- Finally use the `runs-on: self-hosted` syntax in the workflow file to run the workflow on the self-hosted runner.