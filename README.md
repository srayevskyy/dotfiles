# Nat's dotfiles

## Synopsis

Applies my preferred environment to a workstation.

## Requirements

- [Arch Linux](https://www.archlinux.org/) or MacOS + [Homebrew](https://brew.sh/)
    - Should be easily forked & ported to other Linux distributions by just tweaking package names
- [Ansible](https://www.ansible.com/) >= 2.4.0.0

## Running (OSX, including installation of brew and ansible)

```
echo -e "\n" | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/versions && brew install git ansible
mkdir ~/src/ && cd ~/src/ && rm -rf ~/src/dotfiles/
git clone https://github.com/srayevskyy/dotfiles.git
cd ~/src/dotfiles/ansible
ansible-playbook -i inventory --ask-become-pass site.yml
```

## Running (Linux)

```
git clone https://github.com/nharward/dotfiles.git
cd dotfiles/ansible
ansible-playbook -i inventory --ask-become-pass site.yml
```
