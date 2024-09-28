if [ -d "flutter" ]; then
  cd flutter &&
  git pull &&
  cd ..;
else
  git clone https://github.com/flutter/flutter.git;
  fi;
#  flutter/bin/dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
  flutter/bin/flutter gen-l10n
  flutter/bin/flutter build web --release --wasm