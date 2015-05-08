#!/usr/bin/env sh
CHATWORKTOKEN=（チャットワークのトークンが入ります。）
CHATWORKROOMID=（チャットワークのルームIDが入ります。）
 
# ビルド成功時は develop ブランチのみ通知
if [ ${TRAVIS_TEST_RESULT} -eq 0 ] && [ ${TRAVIS_BRANCH} != "develop" ]; then
  echo "exit: build success on any branch without develop"
  exit 0
fi
if [ ${TRAVIS_TEST_RESULT} -eq 0 ]; then
  result="BUILD SUCCESS"
else
  result="BUILD FAILED"
fi
 
body=`cat <<EOF
 EOT
[info][title]${result} - ${TRAVIS_REPO_SLUG} [/title]branch: ${TRAVIS_BRANCH}
commit: https://github.com/${TRAVIS_REPO_SLUG}/commit/${TRAVIS_COMMIT}
build: https://magnum.travis-ci.com/${TRAVIS_REPO_SLUG}/builds/${TRAVIS_BUILD_ID}
[/info]
EOT`
 
echo "$body"
 
script="puts URI.encode_www_form_component('${body}')"
encoded=`ruby -r uri -e "${script}"`
echo $encoded
#curl -X POST -H X-ChatWorkToken:$CHATWORKTOKEN -d body=${encoded} https://api.chatwork.com/v1/rooms/$CHATWORKROOMID/messages
