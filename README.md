# OpenTimestamps Github Action

## About

GitHub Action to timestamp git tags on the Bitcoin blockchain.

## Usage

### Workflow

```yaml
name: CI
on: [push]
jobs:
  Example-Job:
    runs-on: ubuntu-latest
    steps:
      - name: Check out repository code
        uses: actions/checkout@v2
      - name: Run OpenTimestamps github action
        uses: yzernik/open-timestamps-github-action@v1
        with:
          customTagMessage: "Put anything you want here or nothing at all."
```
