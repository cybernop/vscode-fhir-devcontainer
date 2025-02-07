# VS Code FHIR development containers

[![Docker Images](https://github.com/cybernop/vscode-fhir-devcontainer/actions/workflows/docker.yaml/badge.svg)](https://github.com/cybernop/vscode-fhir-devcontainer/actions/workflows/docker.yaml)

Prebuilt VS Code development containers providing tools to build FHIR profiles using FSH sushi and IGs.

## Images and tags

Available images:

* only FSH sushi: `ghcr.io/cybernop/vscode-fhir-devcontainer/fsh-sushi`
* FSH sushi and IG publisher: `ghcr.io/cybernop/vscode-fhir-devcontainer/ig-publisher`

Tags have the schema `<sushi version>-<os base>`.

Available `<sushi version>`:

* `2.10.2`
* `3.0.0`
* `3.5.0`
* `3.10.0`
* `3.11.0`
* `3.11.1`
* `3.12.0`
* `3.12.1`
* `3.13.0`
* `3.13.1`
* `3.14.0`

Available `<os-base>`:

* `alpine`
* `ubuntu`

## Usage

### Simple usage

The easiest way using one of the development containers is by creating `.devcontainer/devcontainer.json` in your project root and set

```json
{
    "image": "<image>:<tag>"
}
```

### Advanced usage

To modify the base image, e.g. for installing other dependencies, one can create your own `Dockerfile` in `.devcontainer` like:

```Dockerfile
FROM <image>:<tag>

# Do stuff
```

and instead of setting the `image` property in `devcontainer.json` set

```json
{
    "build": {
        "dockerfile": "Dockerfile"
    }
}
```

For more information about dev containers, see [https://containers.dev/implementors/json_reference/](https://containers.dev/implementors/json_reference/).
