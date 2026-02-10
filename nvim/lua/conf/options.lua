local options = {
	
	backup = false,				-- keep backup file after overwriting a file
	splitbelow = true,			-- when split horizontally forces to create new window below
	splitright = true,			-- when split vertically forces to create new window on the right
	cmdheight = 2,				-- how much space the command line has
	mouse = "a",				-- enables mouse clicks
	tabstop = 4,				-- set tab clicks to 2 spaces
	shiftwidth = 4,				-- number of spaces to use with auto-indent
	numberwidth = 4,
	number = true,				-- set number of lines
	cursorline = false,
	clipboard = "unnamedplus",
	termguicolors = true,
	smartcase = true,
	smartindent = true,
	updatetime = 300,
	ignorecase = true,
	expandtab = true,			-- convert tab into spaces
	undofile = true,			-- enables persistent undo
    swapfile = false,
    writebackup = false,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

vim.opt.shortmess:append "c"

