
# Details

## Repo Organization

### Reusable Components

Reusable components are managed in a separate branch: `reference-data`.

This branch contains:

* **messages**
  - channel messages that are reused across different specs.

* **parameters**
  - channel parameters that are reused across different specs.

* **schemas**
  - schemas that are reused across different specs or messages.

> _Hint:_
> To make working easier, set up a git worktree with the reference-data branch.


### Async Api Specs

Released versions of the async api specs live in the `main` branch, directory: `specs`.

Reference reusable components via it's **raw** URL in the `reference-data` branch, e.g.

````yaml
...
components:
  messages:
    storeTillReceipt-v1:
      $ref: "https://raw.githubusercontent.com/solace-iot-team/apim-uc-acme-retail/reference-data/messages/storeTillReceipt-v1.yml"
...
````


## Work, Test, Release

### Working on specs

* create a new branch from `main`, e.g. `my-new-spec`
* work on the spec(s)
* push the new branch (`my-new-spec`)

### Pull Request & Testing

Once the specs are finished, create a pull request from branch `my-new-spec` to `main`.

This will trigger the [test workflow](https://github.com/solace-iot-team/apim-uc-acme-retail/blob/main/.github/workflows/test.yml).

Once the tests have been successfully completed, merge branch `my-new-spec`.

### Release

Draft a new release (e.g. Release 1.1.0) and create it.

This will trigger the [release workflow](https://github.com/solace-iot-team/apim-uc-acme-retail/blob/main/.github/workflows/release.yml) which
will take all specs and publish them to Solace Event Portal.


---
