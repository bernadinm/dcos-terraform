#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

DEFAULT_PROVIDER=aws
CURRENT_DIR="$(cd "$(dirname "$0")"; pwd -P)"
ROOT_DIR="${CURRENT_DIR}/.."

# shellcheck source=/dev/null
. "${ROOT_DIR}/PACKAGE"

TARGET_DIR=$(mktemp -d "${ROOT_DIR}/${DIST_DIR}/terraform-XXXXXX")
TARGET_OUTPUT=$(mktemp)

echo "Creating environment in ${TARGET_DIR}"

# Copy modules to target directory.
rsync -rv --exclude=.git "${ROOT_DIR}/modules" "${TARGET_DIR}"

# Localize the module sources.
"${DIST_DIR}/module-source-converter" -modules-dir "${TARGET_DIR}/modules"

# Copy examples.
rsync -rv "${ROOT_DIR}/examples" "${TARGET_DIR}"

for provider in $(git status -s | grep -E 'modules|examples' | cut -d / -f 2 | grep -vE 'null|template|localfile|.git*' | sort | uniq | sed s/^$/${DEFAULT_PROVIDER}/g);
do
  cd "${TARGET_DIR}/examples/${provider}";
  terraform init;
  cat >> ${TARGET_OUTPUT} <<EOF
--------------------------------------------------------------------
$(echo ${provider} | tr a-z A-Z): ${TARGET_DIR}/examples/${provider}
EOF
done

# Print Output
cat ${TARGET_OUTPUT}
