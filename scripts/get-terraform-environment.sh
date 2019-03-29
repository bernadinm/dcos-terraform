#!/usr/bin/env bash

set -o errexit

PROVIDER_CHANGED_LIST=$(git status -s | grep -E 'modules|examples' | cut -d / -f 2 | grep -vE 'null|template|localfile|.git*' | sort | uniq)
PROVIDER=${PROVIDER:=$PROVIDER_CHANGED_LIST}
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

# Local Development for Auto-generation
for provider in ${PROVIDER:=$DEFAULT_PROVIDER};
do
  cd "${TARGET_DIR}/examples/${provider}";
  terraform init;
  cat >> ${TARGET_OUTPUT} <<EOF
--------------------------------------------------------------------
$(echo ${provider} | tr a-z A-Z): ${TARGET_DIR}/examples/${provider}
EOF

# Print Output
cat ${TARGET_OUTPUT}
done
