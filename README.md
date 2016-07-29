[![](https://badge.imagelayers.io/wernight/kubectl:latest.svg)](https://imagelayers.io/?images=wernight/kubectl:latest 'Get your own badge on imagelayers.io')

Dockerized `kubectl` CLI tool for [Kubernetes](http://kubernetes.io/). Built on top of Alpine Linux (very small) with `glibc` installed (required by `kubectl`).

## Usage

Within Docker:

    $ docker run --rm --net=host wernight/kubectl kubectl --help

Within Kubernetes

    $ kubectl run --rm -it --image mumoshu/kubectl:1.3.3 kubesh -- sh
    # Or dive into an interactive shell
    $ kubectl run --rm -it --image mumoshu/kubectl:1.3.3 kubesh -- sh

## Why use it

It's mostly meant to be used during continuous integration or as part of an automated build/deployment:

  * So that your machine (e.g. build server) doesn't need `kubectl` to be installed; only Docker.
  * To avoid `kubectl config use-context` and similar to affect your build and other projects' builds.
