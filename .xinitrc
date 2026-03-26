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
