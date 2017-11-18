# Nat's dotfiles

## Synopsis

Applies my preferred environment to a workstation.

## Requirements

- [Ansible](https://www.ansible.com/) >= 2.4.0.0
- [Arch Linux](https://www.archlinux.org/) or MacOS + [Homebrew](https://brew.sh/)
    - Should be easily forked & ported to other Linux distributions by just tweaking package names

## Running

    $ git clone https://github.com/nharward/dotfiles.git
    $ cd dotfiles/ansible
    $ ansible-playbook -i inventory --ask-become-pass site.yml
