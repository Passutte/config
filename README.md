# config
MacOS and Ubuntu Setups

## Simple setup
```
wget https://github.com/passutte/coding/archive/master.zip && \
unzip master.zip && \
rm master.zip && \
cd coding-main/setup
```

* MacOS:
  ```
  sudo bash install.sh $USER macOS 2>&1 | tee /tmp/initial_setup.log
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

### Additional Plugins
* https://github.com/ohmyzsh/ohmyzsh/tree/master
* https://github.com/ohmybash/oh-my-bash
