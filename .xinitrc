# It seems to me like a graphical shell is a shell, so I would like to source
# .bashrc right here and make my personal settings available to all programs
# launched by the windowing system or window manager.  Doing so seems to break
# startx, though.  I haven't spent much time digging into why that happens nor
# whether I should try to fix it.
#
# . ~/.bashrc

# Necessary for correct PINENTRY_USER_DATA to be available to programs like
# "torrent", which passes it to "pass", which passes it to "gpg" and/or related
# tools, which pass it along when communicating with "gpg-agent", which then
# makes it available to the pinentry program, which in my case is
# "pinentry-wrapper", which uses the contents to decide which real pinentry
# program to invoke.  (What could be simpler?)
#
# For some reason, without this line, PINENTRY_USER_DATA gets set, but its
# value for DISPLAY is empty.
eval "$(grep 'PINENTRY_USER_DATA=' ~/.bashrc)"

# Run this before xscreensaver to style the unlock dialogue.
xrdb -merge ~/.Xresources
xscreensaver -nosplash &

# Adjust output if appropriate.
~/bin/monitors &

# Black background.
xsetroot -solid '#000000' &

# Dim/redden everything.
redshift &

# Turn off that stupid light.
# No longer necessary since I found the BIOS setting.
#openrgb -b 0 &

# Notify/remind about required reboots.
~/bin/required_reboot_reminder &

# Inhibit screensaver when youtube is on full screen.  (Among other conditions.)
#~/code/github/devkral/lightsonplus/lightson+ &
~/code/github/devkral/lightsonplus/lightson+ --html5 1 --mpv  1 &

# See:  .config/pulse/client.conf
# With "autospawn = yes", this is probably unnecessary.
# "Probably".
pulseaudio &

## tap-to-click:
#synclient TapButton1=1 &
## No mouse acceleration:
#synclient AccelFactor=0 &
#synclient MinSpeed=2.25 &
#synclient MaxSpeed=2.25 &

conky &

exec ssh-agent i3
