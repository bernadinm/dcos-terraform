#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

CURRENT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
ROOT_DIR="${CURRENT_DIR}/.."

# shellcheck source=/dev/null
. "${ROOT_DIR}/PACKAGE"

BRANCH=${BRANCH:-"default-branch"}

CHANGES=$(git status --porcelain --untracked-files=all)

if [ -n "${CHANGES}" ]; then
  git push origin "${BRANCH}"
  hub pull-request
fi
