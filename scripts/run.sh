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

make
node_modules/coffee-script/bin/coffee bin/proxy "${@}"

