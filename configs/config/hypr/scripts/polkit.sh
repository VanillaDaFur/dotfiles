#!/usr/bin/env sh

if pidof polkit-mate-authentication-agent-1 >/dev/null 2>&1; then
  printf "Mate-polkit is already running, aborting...\n"
  exit 0 
fi

if [ -x /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 ]; then
  /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
  printf "Mate-polkit initialized (from /usr/lib)\n"
elif [ -x /usr/libexec/polkit-mate-authentication-agent-1 ]; then
  /usr/libexec/polkit-mate-authentication-agent-1 &
  printf "Mate-polkit initialized (from /usr/libexec)\n"
else
  printf "Mate-polkit not found\n"
  exit 1
fi
