#!/usr/bin/env bash

echo "SSH_KEY_NAME=${SSH_KEY_NAME}"
echo "RELEASE_EMAIL=${RELEASE_EMAIL}"
echo "REPO=${REPO}"

#set -x

KEY_PATH="$HOME/.ssh/id_ed25519"
PUB_KEY_PATH="${KEY_PATH}.pub"

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -f "${KEY_PATH}" -N "" -C "${RELEASE_EMAIL}"

SSH_PRIV=$(cat "${KEY_PATH}");

gh secret set "${SSH_KEY_NAME}" --body "${SSH_PRIV}" --repo "${REPO}"

gh repo deploy-key add "${PUB_KEY_PATH}" --title "release" --repo "${REPO}"

# Clean up
rm -f "${KEY_PATH}" "${PUB_KEY_PATH}"

