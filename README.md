# Collection of dotfiles for my personal use

# Want more?

* https://dotfiles.github.io/ has a large collection of dotfile repos
* https://github.com/tony/.dot-config started me with this idea
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ has a cool idea on how to integrate the versioned dotfiles into your home dir (used by the `install-dotfiles.sh` in here)

# TODO

* Improve installation script
  * Optional readonly checkout via anon http instead of ssh
  * Better checks for files that are already present
    * abort install before anything has been written, roll back checkout?
    * Properly save really all files that would be overwritten?
* Document installation command
