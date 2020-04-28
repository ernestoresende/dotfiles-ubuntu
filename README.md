# Why use this?

This is an attempt to mitigate the stress and manual work of setting up a new machine. By no means it is fully optimized, and some manual work will still be necessary, but this will make my life easier.

## The tools I use:

**Package Managers:**

- [NVM](https://github.com/nvm-sh/nvm) - Node Version Manager. Automatic setup for different Node versions.

**CLI Tools and Utilities:**

- [Hyper Terminal](https://hyper.is/#installation) - Default terminal application.
- [Dracula Theme for Hyper](https://draculatheme.com/hyper/) - Theme for Hyper terminal, same one I use on Visual Studio Code.
- [ZSH](http://www.zsh.org/) - Shell Interpreter, substitutes the default BASH shell.
- [Oh my ZSH](https://ohmyz.sh/) - Framework for ZSH.
- [Spaceship](https://github.com/pascaldevink/spaceship-zsh-theme) - Theme for Oh My ZSH.
- **zdharma/fast-syntax-highlighting** - Syntax highlighting for ZSH.
- **zsh-users/zsh-autosuggestions** - Auto suggestions for ZSH.
- **zsh-users/zsh-completions** - Auto completion for ZSH.

**Browsers**

- [Chrome](https://www.google.pt/intl/pt-PT/chrome/?brand=CHBD&gclid=Cj0KCQjw9tbzBRDVARIsAMBplx-3dl3XAE9QTtDsg2H1OSoF3g8Cwot1zV85De_AD628XPgsGhKdrKQaAoesEALw_wcB&gclsrc=aw.ds) - Default browser.
- [Opera](https://www.opera.com/) - Testing browser.
- [Firefox](https://www.mozilla.org/pt-BR/firefox/new/) - Testing browser.
- [Firefox Developer Edition](https://www.mozilla.org/en-US/firefox/developer/) - Very powerful developer tools and visual integration.
- [Min](https://minbrowser.github.io/min/) - Lightweight browser. I use it when I want to open something secondary like a stream, a Youtube video or a piece of documentation.

**Development Tools**

- [Visual Studio Code](https://code.visualstudio.com/) - Main IDE.

**Productivity Tools**

- [Barrier](https://github.com/debauchee/barrier) - KVM tool to share the mouse and keyboard of a server machine with one or several client machines. Very useful when I'm working from home, as I get to divide my usage between my desktop and my laptop.

# Setting everything up:

1. Download and execute the file located in scripts/fresh_install.sh. It will take care of the first essential applications, add missing PPA's and clean unused dependencies.
2. Execute the file in scripts/git_configure.sh to automatically synchronize the Git CLI to the Github account.
3. Proceed to the manual stages to configure all terminal shennanigans.

## Terminal Configurations with My ZSH, Dracula and Spaceship

1. Install ZSH if not already installed:

```
sudo apt install zsh
```

2. Set zsh to your default shell:

```
chsh -s $(which zsh)
sudo chsh -s $(which zsh)
```

3. Log out, and back in for the changes to take effect. Install Oh my ZSH:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

4. Download the Dracula theme for Hyper:

```
hyper install hyper-dracula
```

5. Download Fira Code from [https://github.com/tonsky/FiraCode/releases](https://github.com/tonsky/FiraCode/releases) and set them up in Hyper preferences.

6. Install Spaceship:

```
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

7. Navigate to the zsh configuration file and set the theme to spaceship:

```
gedit .zshrc

##When inside the file, locate ZSH_THEME:
ZSH_THEME="spaceship"
```

8. Still in the file, define personal preferences after on the end of the file:

```
    SPACESHIP_PROMPT_ORDER=(
      user          # Username section
      dir           # Current directory section
      host          # Hostname section
      git           # Git section (git_branch + git_status)
      hg            # Mercurial section (hg_branch  + hg_status)
      exec_time     # Execution time
      line_sep      # Line break
      vi_mode       # Vi-mode indicator
      jobs          # Background jobs indicator
      exit_code     # Exit code section
      char          # Prompt character
    )
    SPACESHIP_USER_SHOW=always
    SPACESHIP_PROMPT_ADD_NEWLINE=false
    SPACESHIP_CHAR_SYMBOL="❯"
    SPACESHIP_CHAR_SUFFIX=" "
```

9. Setup the plugins:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```

In the zsh configuration file, add that after the ### End of ZInit's installer chunk

```
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
```

10. All done... Enjoy the new and enhanced terminal experience.

## Converting regular fonts to web compressed fonts:

If conversion is needed to move fonts from otf/ttf formats to their web compressed counterparts, use the FontSquirrel converter:

[https://www.fontsquirrel.com/tools/webfont-generator](https://www.fontsquirrel.com/tools/webfont-generator)

It will generate webfonts compressed to woff and woff2, alongside with typography guidelines and rendering tests on a demo HTML file.

## Setting up the trackpad gestures on Debian based systems

- [lib-input-gestures](https://github.com/bulletmark/libinput-gestures)
- [gestures](https://gitlab.com/cunidev/gestures)
- [List of keycodes](https://gitlab.com/cunidev/gestures/-/wikis/xdotool-list-of-key-codes)

### Settting up

```
sudo gpasswd -a $USER input

sudo apt-get install wmctrl python3 python3-setuptools xdotool python3-gi libinput-tools python-gobject
```

Clone the libinput-gestures repo and navigate to it:

```
sudo make install
```

Clone gestures repo and navigate to it: 

```
sudo python3 setup.py install
```

Open gestures app and configure the gestures you want to use accordingly. The default command to replicate keyboard shortcuts is: ```xdotool key {keyCombinations}```.
