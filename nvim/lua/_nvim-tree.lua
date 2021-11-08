-- Credit to https://stackoverflow.com/a/7615129
local function splitString (input, seperator)
  if seperator == nil then
    seperator = "%s"
  end

  local split = {}

  for str in string.gmatch(input, "([^"..seperator.."]+)") do
    table.insert(split, str)
  end

  return split
end

-- Custom function to open NvimTree
function OpenNvimTree ()
  local currentBuffer = vim.api.nvim_buf_get_name(0)
  print(currentBuffer)
  if currentBuffer == nil or currentBuffer == '' then
    vim.api.nvim_command('NvimTreeOpen')
  end

  local currentBufferArr = splitString(currentBuffer, '/')
  if currentBufferArr[#currentBufferArr] == 'NvimTree' then
    -- Switch to previous buffer
    vim.api.nvim_command('bprevious')
  else
    vim.api.nvim_command('NvimTreeFindFile')
  end
end

-- Shortcuts
vim.api.nvim_set_keymap('', 'ff', ':lua OpenNvimTree() <cr>', {})
vim.api.nvim_set_keymap('', 'fc', ':NvimTreeClose<cr>', {})

require('nvim-tree').setup({
  auto_close = true,
  view = {
    -- Width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
    width = 30,
    -- Height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
    height = 30,
    -- Hide the root path of the current folder on top of the tree 
    hide_root_folder = true,
    -- Side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- If true the tree will resize itself after opening a file
    auto_resize = true,
  }
})
