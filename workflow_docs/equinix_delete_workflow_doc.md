# Equinix GitHub Actions Demos

[![Equinix-Metal-Actions-Demo](https://github.com/chefgs/equinix_demos/actions/workflows/equinix_workflow.yml/badge.svg?branch=main)](https://github.com/chefgs/equinix_demos/actions/workflows/equinix_workflow.yml)

## Objective of this Workflow
The provided code is a GitHub Actions workflow named 'Equinix-Metal-Delete-Action'. This workflow is designed to delete resources in a specified project on Equinix Metal. The workflow is manually triggered using the workflow_dispatch event.

## Workflow Pre-requisites
- We need to get the project `PROJECT_ID` from Equinix Project settings and we will be using it in the project for authentication purposes. 
- We also need to set the `METAL_AUTH_TOKEN` as a repo secret to use for authentication purpose.


## Workflow explanation
- The workflow_dispatch event has two inputs: `PROJECT_ID` and `Keep_Project`. 
  - `PROJECT_ID` is the ID of the Equinix Metal project that you want to manage, and Keep_Project is a boolean value that determines whether the project should be kept or deleted. 
  - Both inputs are required and have default values.


- Job: The workflow consists of a single job named `destroy-metal-resources`, which runs on the latest version of Ubuntu. This job has one step: `"Device and Project Cleanup"`.

- Job Step: `"Device and Project Cleanup"`.
  - In the "`Device and Project Cleanup`" step, the `equinix-labs/metal-sweeper-action` GitHub Action is used to delete the resources in the specified project. 
  - This action requires an authentication token, which is stored as a secret in your GitHub repository under the name `METAL_AUTH_TOKEN`. 
  - The projectID and keepProject parameters for this action are obtained from the `PROJECT_ID` and `Keep_Project` inputs, respectively. 
  - If `keepProject` is set to '`false`', the project will be deleted.

## Workflow Logs
The workflow logs can be viewable from `Repo > Actions` tab