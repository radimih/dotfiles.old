#!/bin/sh
#-------------------------------------------------------------------------------
# Настройка клавиатуры в X-сессии через подсистему xkb
# ----------------------------------------------------
#
# Скрипт независим от используемой WM или DE. Так как DE в момент своего запуска
# перекрывает своими настройками существующие xkb-настройки, то необходимо:
#   1) сделать так, чтобы данный скрипт запускался уже после загрузки окружения
#   2) отключить keyboard plugin, чтобы переодически DE не сбрасывало настройки
#
#-------------------------------------------------------------------------------

#-----------------------------------------------------------
# Параметры xkb (см. /usr/share/X11/xkb/rules/base[.lst])

XKB_OPTS='compose:ralt'                    # правый Alt в качестве клавиши Compose
XKB_OPTS=${XKB_OPTS}',grp_led:caps'        # индикатор раскладки на лампочке CapsLock
XKB_OPTS=${XKB_OPTS}',grp_led:scroll'      # индикатор раскладки на лампочке ScrollLock
XKB_OPTS=${XKB_OPTS}',caps:swapescape'     # клавиша CapsLock как дополнительная клавиша ESC

# Сделать циклическое переключение раскладок по Alt-Shift.
# Так как далее клавиши Ctrl и Alt меняются местами, то
# указывается комбинация Ctrl-Shift

XKB_OPTS=${XKB_OPTS}',grp:ctrl_shift_toggle'

# Поменять местами левые Ctrl и Alt, если скрипт запускается НЕ под виртуальной машиной.
# Под виртуальной машиной лучше поменять эти клавиши средствами хостовой ОС.

if ! systemd-detect-virt > /dev/null
then
  XKB_OPTS=${XKB_OPTS}',ctrl:swap_lalt_lctl'
fi

#-----------------------------------------------------------
# Предварительная подготовка для DE

# Если в системе присутствует GNOME-подобное DE
if which gsettings > /dev/null 2>&1
then

  FILE_SCRIPT="$0"
  NAME_SCRIPT=`basename "$0"`
  PATH_AUTOSTART=$HOME/.config/autostart
  FILE_AUTOSTART=$PATH_AUTOSTART/$NAME_SCRIPT.desktop

  # Добавить данный скрипт в автозагрузку DE
  if [ ! -f $FILE_AUTOSTART ]
  then
    mkdir -p $PATH_AUTOSTART
    cat <<EOF > $FILE_AUTOSTART
[Desktop Entry]
Type=Application
Name=$NAME_SCRIPT
Comment=xkb-based keyboard tuning
Exec=$FILE_SCRIPT
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
  fi

  # Отключить клавиатурный плагин DE
  # TODO: можно сначала проверить значение параметра командой get
  gsettings set org.gnome.settings-daemon.plugins.keyboard active false

fi

#-----------------------------------------------------------
# Загрузка параметров xkb

setxkbmap -layout "us,ru" -option "" -option "$XKB_OPTS" -print \
  | xkbcomp -I"$HOME/.config/xkb" - "${DISPLAY%%.*}" >/dev/null 2>&1

