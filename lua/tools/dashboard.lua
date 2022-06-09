local home = os.getenv('HOME')
vim.g.dashboard_footer_icon = ' ⏰ '
vim.g.dashboard_preview_command = 'cat'
vim.g.dashboard_preview_pipeline = 'lolcat -F 0.3'
vim.g.dashboard_preview_file = home .. '/.config/nvim/static/neovim.cat'
vim.g.dashboard_preview_file_height = 12
vim.g.dashboard_preview_file_width = 80
vim.g.dashboard_default_executive = 'telescope'
vim.g.dashboard_custom_section = {
  find_history = {
    description = {'  Recently opened files                   SPC f h'},
    command =  'DashboardFindHistory'},
  find_file  = {
    description = {'  Find  File                              SPC f f'},
    command = 'Telescope find_files find_command=rg,--hidden,--files'},
  new_file = {
   description = {'  File Browser                            SPC f b'},
   command =  'Telescope file_browser'},
  find_word = {
   description = {'  Find  word                              SPC f w'},
   command = 'DashboardFindWord'},
}

vim.cmd([[
autocmd FileType dashboard set showtabline=0 laststatus=0
autocmd WinLeave <buffer> set showtabline=2 laststatus=2
]])
