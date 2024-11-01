if [ -d "flutter" ]; then
  cd flutter &&
  git pull &&
  cd ..;
else
  git clone https://github.com/flutter/flutter.git;
  fi &&
  flutter/bin/flutter gen-l10n &&
  flutter/bin/dart run build_runner build &&
  curl -L -o web/drift_worker.js https://github.com/simolus3/drift/releases/latest/download/drift_worker.js &&
  curl -L -o web/sqlite3.wasm https://github.com/simolus3/sqlite3.dart/releases/latest/download/sqlite3.wasm &&
  flutter/bin/flutter build web --release --wasm