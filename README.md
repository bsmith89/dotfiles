My attempt at a dotfiles system.
Based loosely on <https://github.com/sontek/dotfiles> and various projects
listed on <https://dotfiles.github.io/>

Stow configuration inspired by
<http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html>

Enjoy!

##Usage
Place dotfiles in home directory

    make install

Include platform specific files:

    make install PLATFORM=[osx/flux/etc.]

Restore original dotfiles in home directory

    make restore


##TODO
-   Vim
    - Thesaurus
    - Figure out path completion for several filetypes.
    - Automatically make virtualenv in .vim for neovim/jedi/etc. packages.
-   Git
    - portable difflatex
-   Bash
    -   Don't source .bashrc and .bashrc_local more than once.

## NOTES

-   I seem to have settled on some design principles:
    -   Branches are not for different platforms (because merging is hard),
    -   instead, everything in `home/` should be cross-platform (because somehow this is easier...?)
    -   and `platform/` is used for specific code.
    -   This project is not meant for bootstrapping installations, although
        it does do some of that when necessary for getting a new system configured.
        -   Perhaps I should make a `bootstrap` project to pair with it...?
