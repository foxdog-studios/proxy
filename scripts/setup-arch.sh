#!/bin/bash

set -o errexit
set -o nounset

readonly REPO="$(
    realpath -- "$(
        dirname -- "$(
            realpath -- "${BASH_SOURCE[0]}"
        )"
    )/.."
)"

cd -- "${REPO}"

sudo pacman --needed --noconfirm -Sy \
        nodejs

npm install

