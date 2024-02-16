# Create Self Hosted Runner Workflow

## Objective of this Workflow
This is a GitHub Actions workflow named `'Equinix-Metal-Self-hosted-Runner-Setup'`. This workflow is designed to create a temporary project on Equinix Metal, create a device in that project, run a self-hosted runner script for a GitHub repository, and finally delete the project and device. The workflow is manually triggered using the workflow_dispatch event.

## Workflow Pre-requisites
We need to get the metal user API key `METAL_AUTH_TOKEN` from Equinix user settings and we will be using it for the project creation authentication purposes. 

The `METAL_AUTH_TOKEN` has to be added as a GitHub repo secret for further use it in the GitHub action implementation.

## Workflow explanation
The workflow consists of a single job named manage-metal-project-device, which runs on the latest version of Ubuntu. This job has several steps:

Step 1 "Create temporary project": This step uses the equinix-labs/metal-project-action@main GitHub Action to create a new project on Equinix Metal. The action requires an authentication token, which is stored as a secret in your GitHub repository under the name METAL_AUTH_TOKEN.

Step 2 "Create device in temporary project": This step uses the equinix-labs/metal-device-action@main GitHub Action to create a new device in the project created in the previous step. The action requires the project token and project ID from the previous step, as well as several other parameters to specify the device configuration. The user_data parameter is used to provide a script that is run on the device when it is created. This script downloads, configures, and runs a GitHub Actions self-hosted runner.

Step 3 "Delete temporary project & device": This step uses the equinix-labs/metal-sweeper-action@main GitHub Action to delete the project and device created in the previous steps. The action requires an authentication token and the project ID from the first step. The keepProject parameter is set to 'false', indicating that the project should be deleted.

Since it is a DEMO, We are deleting the project as part of the workflow, but recommend skipping this step in a real-world scenario.

## Setup a Self-hosted runner for a specific repository
The comments at the end of the workflow file provide additional We can use the instructions below for setting up the self-hosted runner in the GitHub repository,
- Select the repository where you want to add the self-hosted runner
- Creating a new runner, 
- Copying the runner setup script, pasting it into the user_data section of the device creation step
- Finally use the `runs-on: self-hosted` syntax in the workflow file to run the workflow on the self-hosted runner.
