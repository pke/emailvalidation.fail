#!/bin/bash

set -o errexit -o nounset

if [ -a ./.env ]; then
  echo "Loading local .env"
  . ./.env
fi

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not the master! No deploy!"
  exit 0
fi

rev=$(git rev-parse --short HEAD)

rm -rf _build
mkdir _build
cd _build

branch="feature/$(date +"%Y%m%d%H%M%S")-trello-update"

git init
git config user.name "ValidationFailBot"
git config user.email "bot+travis-ci.org@emailvalidation.fail"

git remote add upstream "https://$GH_TOKEN@github.com/pke/emailvalidation.fail.git"
git fetch upstream master:"${branch}" --depth 1

git checkout "${branch}"

baseUri="https://api.trello.com/1/lists"
cardFields="cards?fields=name,desc,date,cover&attachments=true&actions=emailCard,cardCreate&key=${TRELLO_KEY}&token=${TRELLO_TOKEN}"

failsUri="${baseUri}/${TRELLO_FAILS_LIST}/${cardFields}"
unfailsUri="${baseUri}/${TRELLO_UNFAILS_LIST}/${cardFields}"

echo "Loading fails"
curl --fail --silent "${failsUri}" | node <<< "var o = $(cat); console.log(JSON.stringify(o, null, 2));" > ./docs/_data/fails.json

echo "Loading unfails"
curl --fail --silent "${unfailsUri}" | node <<< "var o = $(cat); console.log(JSON.stringify(o, null, 2));" > ./docs/_data/unfails.json

git add -A .
git commit -m "chore: Rebuild pages at ${rev}"
git checkout master
git merge "${branch}"
git push -q upstream HEAD:master