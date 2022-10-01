# GitHub workflows to manage BABS projects

These workflows can be used in BABS project repositories to automate tasks.

## Usage

Workflows in this repository can be linked from the project repository by adding a workflow YAML to the `.github/workflows/` directory in the project. The name of the workflow is not important but should be sensible!

For example, the following workflow could be in a project repository `.github/workflows/convert-experiment-table-xlsx.yml`. Whenever a specific commit is pushed to the project repository or this workflow is triggered, remote `convert-experiment-table-xlsx` workflow is used.

```yaml
name: Convert experiment_table.xlsx

on:
  push:
    paths:
      - 'babs/docs/experiment_table.xlsx'
  workflow_dispatch:

jobs:
  run-remote-workflow:
    uses: ChristopherBarrington/babs-workflows/.github/workflows/convert-experiment-table-xlsx.yml@main
    with:
      target-file: 'babs/docs/experiment_table.xlsx'
```
Each action that can be used should have a separate (and similarly named) directory here. In this directory, there are Dockerfiles (etc) that are required by the workflow. Names should be as consistent as possible!

### Docker images

For workflows that use a docker image, the image should be created (somewhere) and pushed to docker hub from which they will be downloaded when the action runs. The directory for the action should contain everything to make the docker image and optionally push the image. Generally, the steps required to make (and push) the image should be contained in the `build` shell script and run, for example, with `sh build`.

# convert-experiment-table-xlsx

This workflow uses an image on docker hub to convert an `experiment_table.xlsx` file to comma- and/or tab-delimted text files that can be viewed in GitHub directly.

The `converter` is the entrypoint of the container and takes multiple arguments: the first is the path to the `xlsx` file and the remaining are output formats (in this case, only `csv` and `tsv` can be used).
