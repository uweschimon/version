#!/bin/sh
# 39f7f9e340ae3512b19983f2bf733028
# uwe.schimon@mailpost.de 20211208 09
# set -x
# set default-values
S=example.sh
BACKUP=backup
echo -n "[-s|--source]= [-b|--backup]=" > args.usage
. /usr/bin/args.create.sh
. ./args.sh
args $@

mkdir -p "$BACKUP"
b="$BACKUP/$S."`date +%s`
cp "$S" "$b"
if [ -e "$b" ]; then	# when memory is not scarce
 m0=`grep -P "^# [0-9a-f]+$" "$b"`
 m1=`grep -vP "^# [0-9a-f]+$" "$b" | md5sum | cut -d " " -f1 | xargs echo "#"`
 if [ -z "$m0" ]; then
  sed "2i$m1" "$b">"$S"
 else
  sed "s/$m0/$m1/" "$b">"$S"
 fi
fi
