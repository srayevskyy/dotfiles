# Nat's dotfiles

## Synopsis

Applies my preferred environment to a workstation.

## Requirements

- [Arch Linux](https://www.archlinux.org/) or MacOS + [Homebrew](https://brew.sh/)
    - Should be easily forked & ported to other Linux distributions by just tweaking package names
- [Ansible](https://www.ansible.com/) >= 2.4.0.0

## Pre-requisites (OSX)
- reboot in recovery mode
- start terminal (Utilities/Terminal)
- issue the following commands:
`sudo spctl --master-disable`
`sudo spctl kext-consent disable`
- reboot in normal mode
- run the command `sudo vusudo` 
- replace the line `%admin          ALL = (ALL) ALL` with `%admin          ALL = (ALL) NOPASSWD: ALL`

## Running (OSX, including installation of brew and ansible)

```
echo -e "\n" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/versions && brew install git ansible
git clone https://github.com/srayevskyy/dotfiles.git
cd dotfiles/ansible && ansible-playbook -i inventory --ask-become-pass site.yml
```

## Running (Linux)

```
git clone https://github.com/srayevskyy/dotfiles.git
cd dotfiles/ansible
ansible-playbook -i inventory --ask-become-pass site.yml
```
