# I3

This is my I3 config.

```shell
git clone git@github.com:johe37/i3.git ~/.config/i3
```

# Set GTK for apps

```shell
sudo dnf install lxapperance
```

GTK-based apps (like Firefox, Gedit etc.) respect
`~/.config/gtk-3.0/settings.ini` and `~/.config/gtk-4.0/settings.ini`.

```shell
ln -s gtk-3.0 ~/.config
ln -s gtk-4.0 ~/.config
```

