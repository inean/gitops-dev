# GitOps Development workflow
[![CI][badge-gh-actions]][link-gh-actions]

This repo configures most of the software I use on my for software development.

## How this is organized.

We use git branches to separe code specific to different OS. *main* branch is where most of the work is done. Specific code for the different OS variants could be find in their respectives branches


## Installation

  1. Checkout branch relates to your development OS
  2. Run `make init`. This will create a local Python 3 environment where Ansible will be installed`

[badge-gh-actions]: https://github.com/inean/gitops-dev/actions/workflows/main.yml/badge.svg?event=push
[link-gh-actions]: https://github.com/inean/gitops-dev/actions?query=workflow%3ACI