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

### Fish
1. Enter fish shell
    ```
    fish
    ```
2. install fisher plugin manager ([ref](https://github.com/jorgebucaran/fisher))
    ```
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
    ```
3. install packages required by some plugins
    * fonts required for `tide` ([ref](https://github.com/IlanCosman/tide#fonts))
        * [MesloLGS NF Regular.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_regular.ttf?raw=true)
        * [MesloLGS NF Bold.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_bold.ttf?raw=true)
        * [MesloLGS NF Italic.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_italic.ttf?raw=true)
        * [MesloLGS NF Bold Italic.ttf](https://github.com/IlanCosman/tide/blob/assets/fonts/mesloLGS_NF_bold_italic.ttf?raw=true)
        * Also, set the terminal font to one of these

4. install plugins with `fisher`
    ```
    fisher install IlanCosman/tide@v6
    ```

5. Set configuration
    ```
    tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No
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