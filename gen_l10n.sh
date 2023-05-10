#generate_localizations() {
#  for DIR in $(ls $1); do
#    path=$1/$DIR
#
#    (
#      cd "$path" || exit
#      cat l10n.yaml &>/dev/null && echo "Found localizations config in $path" && flutter gen-l10n
#    )
#  done
#}
#
#generate_localizations modules
flutter gen-l10n