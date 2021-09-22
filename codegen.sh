#!/usr/bin/env sh
echo "==> Running locale generation"
flutter gen-l10n
echo "==> Running build runner"
flutter packages pub run build_runner build --delete-conflicting-outputs