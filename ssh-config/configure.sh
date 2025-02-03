#!/usr/bin/env bash

echo "SSH_KEY_NAME=${SSH_KEY_NAME}"
echo "RELEASE_EMAIL=${RELEASE_EMAIL}"
echo "REPO=${REPO}"

set -x

mkdir -p ~/.ssh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "${RELEASE_EMAIL}"

SSH_PRIV=$(cat ~/.ssh/id_ed25519);
#SSH_PUB=$(cat ~/.ssh/id_ed25519.pub);



gh secret set "${SSH_KEY_NAME}" --body "${SSH_PRIV}" --repo "${REPO}"


gh repo deploy-key add ~/.ssh/id_ed25519.pub --title "release" --repo "${REPO}"




