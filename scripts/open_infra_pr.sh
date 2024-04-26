#!/bin/bash

BRANCH_NAME=gitops-demo-bot/$TAG

git clone https://$GH_TOKEN@github.com/cicd-excellence/infra.git

cd infra

git config --global user.email ""
git config --global user.name "GitOps Demo Bot"

git checkout -b $BRANCH_NAME

TAG=$TAG make dev.update

git add .
git commit -m "Update dev to $TAG"
git push origin $BRANCH_NAME

gh pr create \
  --body "" \
  --title "Update dev to $TAG" \
  --head "$BRANCH_NAME" \
  --base "main"

gh pr merge --admin --rebase
