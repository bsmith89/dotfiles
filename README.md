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
+ Vim
	+ Thesaurus
	+ Figure out path completion for several filetypes.
	+ Automatically make virtualenv in .vim for neovim/jedi/etc. packages.
+ Git
	+ portable difflatex
+ Bash
    + Don't source .bashrc and .bashrc\_local more than once.

## NOTES

-   For fixing problems maping <C-H> in vim, see https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
-   To compile YCM plugin, I had to

    ```bash
    export EXTRA_CMAKE_ARGS='-DPYTHON_LIBRARY=$HOME/.linuxbrew/lib64/libpython2.7.so -DPYTHON_INCLUDE=$HOME/.linuxbrew/include/python2.7'
    ```

    before running the YCM install script: `$HOME/.linuxbrew/bin/python2 install.sh`.
