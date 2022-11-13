#!/bin/bash

IMG=$(base64 -w 0 build/deps.svg)
t=$(mktemp )
cat <<eof > $t
IMG_URL="data:image/svg+xml;base64,$IMG"
VIDEO_URL=https://defalsify.org/chaintool_pychain_pitch.mp4
VIDEO_SIG_URL=https://defalsify.org/chaintool_pychain_pitch.mp4.asc
eof

>&2 echo building README.md with following vars:
>&2 cat $t
bash aux/bash-templater $t < README.in > README.md
