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
+ Git
	+ portable difflatex


## NOTES

For fixing problems maping <C-H> in vim, see https://github.com/neovim/neovim/issues/2048#issuecomment-78045837
