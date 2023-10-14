# config
MacOS and Ubuntu Setups

## Simple setup
```
wget https://github.com/passutte/coding/archive/master.zip && \
unzip master.zip && \
rm master.zip && \
cd config-main
```

* MacOS ($NAME should be the name after /Users/... and $USER is `echo $USER`):
  ```
  sudo bash install.sh $NAME macOS $USER 2>&1 | tee /tmp/initial_setup.log
  ```
* Ubuntu:
  ```
  sudo bash install.sh $USER ubuntu 2>&1 | tee /tmp/initial_setup.log
  ```
* Parallels (Ubuntu):
  ```
  sudo bash install.sh $USER parallels 2>&1 | tee /tmp/initial_setup.log
  ```

The setup script will print to screen and log the same contents to `/tmp/initial_setup.log`.

### Tmux
Run ```Prefix + I``` to initialize plugins.

### Iterm2
For MacOS, key mappings config found in `macOS`

### Guake 
For Linux, key mappings config found in `ubuntu`
```bash
guake --restore-preferences=guake.cfga
guake --save-preferences=guake.cfg
```

### Additional Plugins
* https://github.com/ohmyzsh/ohmyzsh/tree/master
* https://github.com/ohmybash/oh-my-bash
