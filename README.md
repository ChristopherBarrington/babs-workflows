# GitHub workflows to manage BABS projects

These workflows can be used in BABS project repositories to automate tasks.

Workflows in this repository can be linked from the project repository by adding a workflow YAML to the `.github/workflows/` directory in the project. The name of the project's workflow is not important but should be sensible!

Each workflow that can be used should have a (similarly named) directory in the root of this repository. In this directory, there are Dockerfiles (etc) that are required by the workflow. Names should be as consistent as possible!

### Docker images

For workflows that use a docker image, the image should be created (somewhere) and pushed to docker hub from which they will be downloaded when the action runs. The directory for the action should contain everything to make the docker image and optionally push the image. Generally, the steps required to make (and push) the image should be contained in the `build` shell script and run, for example, with `sh build`.

```bash
cd convert-experiment-table-xlsx
sh build
docker images
# docker run --rm --mount source=<path>,destination=<path>,type=bind <repository>/<image> [arg] [arg] ... [arg]
```

# convert-experiment-table-xlsx

This workflow uses `christopherbarrington/convert-experiment-table-xlsx` on docker hub to convert an `experiment_table.xlsx` file to comma- and/or tab-delimited text files that can be viewed in GitHub directly.

The `converter` is the entrypoint of the container and takes multiple arguments: the first is the path to the `xlsx` file and the remaining are output formats (in this case, only `csv` and `tsv` can be used).

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

# convert-proposal-docx

This workflow uses `christopherbarrington/convert-proposal-docx` on docker hub to convert a `proposal.docx` file to a GitHub-flavoured markdown that can be read directly in GitHub.

The `converter` is the entrypoint of the container and takes precisely three arguments:

1. the path to the proposal Word document, typically `babs/docs/proposal.docx` but can be configured per project repository
1. the output format, should be `gfm`, is provided to `pandoc --to`
1. the output file, should be `babs/docs/proposal.md`, is provided to `pandoc --output`

```yaml
name: Convert proposal.docx

on:
  push:
    paths:
      - 'babs/docs/proposal.docx'
  workflow_dispatch:

jobs:
  run-remote-workflow:
    uses: ChristopherBarrington/babs-workflows/.github/workflows/convert-proposal-docx.yml
    with:
      target-file: 'babs/docs/proposal.docx'
```
