# GitHub workflows to manage BABS projects

These workflows can be used in BABS project repositories to automate tasks.

## Usage

Workflows in this repository can be linked from the project repository by adding a workflow YAML to the `.github/workflows/` directory in the project. The name of the workflow is not important but should be sensible!

For example, the following workflow could be in a project repository `.github/workflows/convert_experiment_table.yml`. Whenever a commit is pushed to the project repository this workflow is triggered, which uses the remote `convert-experiment-table` workflow.

```yaml
name: Convert experiment table

on:
  push:
    paths:
      - 'babs/docs/experiment_table.xlsx'
  workflow_dispatch:

jobs:
  run_remote_workflow:
    name: run remote experiment table conversion workflow
    uses: ChristopherBarrington/babs-workflows/.github/workflows/convert-experiment-table.yml@main
```
