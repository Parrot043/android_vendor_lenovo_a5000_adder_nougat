#!/sbin/sh
# 
# /system/addon.d/34-camera.sh
# During a CM13.0 upgrade, this script backs up /system/*,
# /system is formatted and reinstalled, then the file is restored.
#

. /tmp/backuptool.functions

list_files() {
cat <<EOF
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
  ;;
  pre-backup)
    # Stub
  ;;
  post-backup)
    # Stub
  ;;
  pre-restore)
    # Stub
  ;;
  post-restore)
	# Enable Camera2 API
	  echo "# Enable Camera2 API" >> /system/build.prop
      echo "persist.camera.HAL3.enabled=1" >> /system/build.prop
  ;;
esac
