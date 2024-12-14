if [ -d "flutter" ]; then
  cd flutter &&
  git pull &&
  cd ..;
else
  git clone https://github.com/flutter/flutter.git;
fi &&
  flutter/bin/flutter config --no-analytics &&
  flutter/bin/flutter config --no-cli-animations &&
  flutter/bin/flutter --version &&
  curl -L -o web/drift_worker.js https://github.com/simolus3/drift/releases/latest/download/2.22.0.js &&
  curl -L -o web/sqlite3.wasm https://github.com/simolus3/sqlite3.dart/releases/latest/download/sqlite3.wasm &&
  flutter/bin/flutter gen-l10n &&
  flutter/bin/dart run build_runner build &&
  flutter/bin/flutter build web