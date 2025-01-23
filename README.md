# config
MacOS and Ubuntu Setups

## Simple setup
```
wget https://github.com/passutte/coding/archive/master.zip && \
unzip master.zip && \
rm master.zip && \
cd config-main
```

* MacOS (NAME should be the name after /Users/... and USER is `echo $USER`):
  ```
  sudo bash install.sh macOS $HOME $USER 2>&1 | tee /tmp/initial_setup.log
  ```
* Ubuntu:
  ```
  sudo bash install.sh ubuntu $HOME $USER 2>&1 | tee /tmp/initial_setup.log
  ```
* Parallels (Ubuntu):
  ```
  sudo bash install.sh parallels $HOME $USER 2>&1 | tee /tmp/initial_setup.log
  ```

The setup script will print to screen and log the same contents to `/tmp/initial_setup.log`.

### Tmux
Source config with ```tmux source ~/.tmux.conf```
Run ```Prefix + I``` to initialize plugins.

### Iterm2
For MacOS, key mappings config found in `macOS`
**NOTE:** In settings - Keys - Navigation Shortcuts: change shortcut to choose a split pane to ***No Shortcut*** (otherwise option+numbers cannot be used special characters)

### Guake 
For Linux, key mappings config found in `ubuntu`
```bash
guake --restore-preferences=guake.cfga
guake --save-preferences=guake.cfg
```

Add hot key in keyshortcuts in computer settings. Add `guake -t`.

### Fish
1. Enter fish shell
    ```
    fish
    ```
2. config colors (web GUI)
    ```
    # configure the color, to e.g. Dracula
    fish_config
    ```
3. install fisher plugin manager ([ref](https://github.com/jorgebucaran/fisher))
    ```
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    ```
4. install packages required by some plugins
    * fonts required for `tide` ([ref](https://github.com/IlanCosman/tide#fonts))
        * [MesloLGS NF Regular.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_regular.ttf?raw=true)
        * [MesloLGS NF Bold.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_bold.ttf?raw=true)
        * [MesloLGS NF Italic.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_italic.ttf?raw=true)
        * [MesloLGS NF Bold Italic.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_bold_italic.ttf?raw=true)
        * Also, set the terminal font to one of these
   * packages required by `PatrickF1/fzf` ([ref](https://github.com/PatrickF1/fzf.fish#installation))
        * In fish shell (not working on MacOS):
            ``` bash
            mkdir -p ~/.local/bin && \
            # fd
            sudo apt install fd-find -y && \
            ln -s (which fdfind) ~/.local/bin/fd &&\
            # bat
            sudo apt install bat -y && \
            ln -s /usr/bin/batcat ~/.local/bin/bat
            ```
4. install plugins with `fisher`
    ```
    fisher install jorgebucaran/fisher && \
    fisher install PatrickF1/fzf.fish && \
    fisher install IlanCosman/tide && \
    fisher install edc/bass    # using bash utilities in fish, check out https://github.com/edc/bass
    ```


### Additional Plugins
* https://github.com/ohmyzsh/ohmyzsh/tree/master
* https://github.com/ohmybash/oh-my-bash

### VSCode Extensions
https://www.ubuntupit.com/best-visual-studio-code-extensions-for-programmers/

### Useful Stuff

Anaconda:

```bash
conda init <>
```

```bash
conda config --set auto_activate_base false
```
