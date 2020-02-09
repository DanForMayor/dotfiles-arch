function get_volume {
  pamixer --get-volume
}

function vol_down {
  if is_mute ; then
    toggle_mute
  fi
  pamixer -d 5
}

function vol_up {
  if is_mute ; then
    toggle_mute
  fi
  pamixer -i 5
}

function is_mute {
  pamixer --get-mute > /dev/null
}

function toggle_mute {
  pamixer --toggle > /dev/null
}

function send_notification {

  # these are the two icon paths
  iconSound="~/Pictures/dunstIcons/speaker-icon-grey.png"
  iconMuted="~/Pictures/dunstIcons/speaker-icon-grey-mute.png"

  # Build the notification arguments
  if is_mute ; then
    img="$iconMuted"
    msg=$'Muted'
  else
    volume=$(get_volume)
    
    # This line is crazy, but it makes the continuous bar
    bar=$(seq --separator="──" 0 "$((volume / 5))" | sed 's/[0-9]//g')
    
    img="$iconSound"
    msg="$bar⊙"
  fi

  # Send the notification
  dunstify -i $img -r 2593 -u low $msg
}

# check what command is coming in
case $1 in
  up)
    vol_up
    send_notification
    ;;
  down)
    vol_down
    send_notification
    ;;
  mute)
    toggle_mute
    send_notification
    ;;
esac
