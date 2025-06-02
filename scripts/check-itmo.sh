#!/usr/bin/env bash

PATTERN="ITMO"
STAGED_TXT=$(git diff --cached --name-only --diff-filter=ACM | grep '\.txt$')

if [ -z "$STAGED_TXT" ]; then
  exit 0
fi

ERROR_FOUND=0

for FILE in $STAGED_TXT; do
  if [ ! -f "$FILE" ]; then
    continue
  fi

  if ! grep -qi "$PATTERN" "$FILE"; then
    echo "Error: in file '$FILE' was not found '$PATTERN'."
    ERROR_FOUND=1
  fi
done

if [ $ERROR_FOUND -ne 0 ]; then
  echo ""
  echo "Commit was interrupted"
  exit 1
fi

echo "Commit was completed successfully"
