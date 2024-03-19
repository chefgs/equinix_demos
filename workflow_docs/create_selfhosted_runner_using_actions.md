# Setup Self Hosted Runner Workflow using Equinix GitHub Actions

## Objective
This workflow is a great example of how to automate the process of setting up a self-hosted runner instance on a Equinix metal device. The self-hosted runner is used by the another job, that runs the CI workflow using the self-hosted runner.

## Workflow Summary
This is a GitHub Actions workflow named 'Equinix-Metal-Selfhosted-Runner-Actions'. This workflow performs the below steps, 
- It is designed to create a project on Equinix Metal
- Setting up a self-hosted runner in that project
- Run a demo action on the self-hosted runner, and 
- Finally delete the project. 
The workflow is triggered whenever a push is made to the 'main' branch of the repository.

## Workflow Details
The workflow consists of four jobs: Project, Runner, Demo, and Cleanup.

- Project: This job creates a new project on Equinix Metal. It uses the equinix-labs/metal-project-action@v0.14.0 GitHub Action, which requires a user token stored as a secret in the GitHub repository. The project name is set to "metal-runner-demo". The ID of the created project is outputted for use in subsequent jobs.

- Runner: This job creates a self-hosted runner in the project created by the Project job. It uses the equinix-labs/metal-action-runner@v0.1.1 GitHub Action, which requires a GitHub token, a Metal authentication token, and the project ID from the Project job. The runner is created in the 'da' metro with the 'c3.small.x86' plan and the 'ubuntu_20_04' operating system.

- Demo: This job runs a demo action on the self-hosted runner. It simply prints a greeting message, the name of the runner, and the architecture and operating system of the runner.

- Cleanup: This job deletes the project created by the Project job. It uses the equinix-labs/metal-sweeper-action@v0.6.0 GitHub Action, which requires a Metal authentication token and the project ID from the Project job. The keepProject parameter is set to 'false', indicating that the project should be deleted.
