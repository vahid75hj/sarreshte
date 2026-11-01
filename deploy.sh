#!/usr/bin/env bash
# Usage: ./deploy.sh [--apk] [--no-push] ["commit message"]
set -euo pipefail
cd "$(dirname "$0")"
FLUTTER="${FLUTTER:-/Users/vahid/.puro/envs/env_3_44_9/flutter/bin/flutter}"
APK=0; PUSH=1; MSG="Update MVP"
for a in "$@"; do case "$a" in --apk) APK=1;; --no-push) PUSH=0;; *) MSG="$a";; esac; done
echo "== client"; mkdir -p client; cp -R src/client-side/. client/
echo "== seller web"; (cd src/seller-side && "$FLUTTER" pub get >/dev/null && "$FLUTTER" analyze && "$FLUTTER" build web --release --base-href /sarreshte/seller/)
rm -rf seller && cp -R src/seller-side/build/web seller
if [ $APK = 1 ]; then echo "== apk"; (cd src/seller-side && "$FLUTTER" build apk --release); mkdir -p downloads; cp src/seller-side/build/app/outputs/flutter-apk/app-release.apk downloads/sarreshte.apk; fi
touch .nojekyll
[ $PUSH = 1 ] || { echo "Built, not pushed."; exit 0; }
git add -A; git commit -m "$MSG" || echo "nothing to commit"; git pull --rebase -q; git push
echo "Live in ~1 min: https://vahid75hj.github.io/sarreshte/"
