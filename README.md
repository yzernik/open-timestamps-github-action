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

### Create a timestamped tag

To create a timestamped tag, simply push a tag to your Github repository.

```
git push origin <TAG_NAME>
```

The Github action will automatically create a new tag named `<TAG_NAME>-ots`.


### Verify the timestamped tag

Install opentimestamps-client:

```
pip install opentimestamps-client
```

Add the following bash script to your home directory:

```bash
#!/bin/sh

# Wrapper for the ots-git-gpg-wrapper
#
# Required because git's gpg.program option doesn't allow you to set command
# line options; see the doc/git-integration.md

ots-git-gpg-wrapper \
    --gpg-program "`which gpg`" \
    --bitcoin-node http://<BITCOIN_USER>:<BITCOIN_PASS>@<BITCOIN_HOST>:<BITCOIN_PORT>/ \
    -- "$@"

```

Optionally include a tor socks5-proxy in your script:

```bash
    --socks5-proxy "<PROXY_HOST>:<PROXY_PORT>" \
```

Configure your git to use the new script for PGP signatures:

```
git config --global gpg.program <path to ots-git-gpg-wrapper.sh>
```

Use the git tag command to check the timestamped tag:

```
git tag -v <TAG_NAME>-ots
```


### Example

```
(venv) yzernik@yzernik-MacBookPro:~/work/open-timestamps-github-action$ git tag -v v1.0.2-ots
object c08887fc4bcef5fe43efe2511a1a91beda9ada5b
type commit
tag v1.0.2-ots
tagger OpenTimestamps Github Action <fake@email.com> 1633583868 +0000

OpenTimestamps Github Action
Github repository: yzernik/open-timestamps-github-action
Github actor: yzernik
Running my own action as dogfood!
ots: Success! Bitcoin block 703912 attests existence as of 2021-10-06 PDT
ots: Good timestamp
gpg: Signature made Wed 06 Oct 2021 10:17:48 PM PDT
gpg:                using RSA key 4508375EC1594D8A284EFB5FAFD08F9C86FAE9CB
gpg: Can't check signature: No public key
```
