#!/usr/bin/env bash

#echo "SSH_KEY_NAME=${SSH_KEY_NAME}"
#echo "RELEASE_EMAIL=${RELEASE_EMAIL}"
#echo "REPO=${REPO}"

set -e
set -x

#[ -z "SSH_KEY" ] && echo "SSH_KEY is not set" && exit 1

KEY_PATH="$HOME/.ssh/id_ed25519"
PUB_KEY_PATH="${KEY_PATH}.pub"

gh secret list --repo "${REPO}" | grep "${SSH_KEY_NAME}" > /dev/null && echo "SSH key already exists" && exit 0

echo "Creating SSH key for ${REPO}"
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -f "${KEY_PATH}" -N "" -C "${RELEASE_EMAIL}" > /dev/null

SSH_PRIV=$(cat "${KEY_PATH}");
echo "ssh_key=${SSH_PRIV}" >> $GITHUB_OUTPUT

gh secret set "${SSH_KEY_NAME}" --body "${SSH_PRIV}" --repo "${REPO}"
echo "SSH key added to GitHub secret ${SSH_KEY_NAME}"

gh repo deploy-key add "${PUB_KEY_PATH}" --title "release" --repo "${REPO}"
echo "SSH key added to GitHub deploy keys"
# Clean up
rm -f "${KEY_PATH}" "${PUB_KEY_PATH}"
echo "SSH key removed from local storage"



