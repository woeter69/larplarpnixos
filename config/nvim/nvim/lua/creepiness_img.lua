
local M = {}
M.enabled = true

-- Path to your images
local images = {
  [0] = "~/Pictures/creepiness/happy.jpg",
  [1] = "~/Pictures/creepiness/creepy1.jpg",
  [2] = "~/Pictures/creepiness/creepy2.jpg",
  [3] = "~/Pictures/creepiness/creepy3.jpg"
}

-- Determine image index based on error count
local function get_image_index(errors)
  if errors == 0 then return 0
  elseif errors < 5 then return 1
  elseif errors < 10 then return 2
  else return 3
  end
end

-- Function to show image using Kitty's inline image protocol
local float_win_id = nil
local function show_image(path)
  if not M.enabled then return end
  if vim.fn.exists('$KITTY_WINDOW_ID') == 0 then return end -- only kitty

  if float_win_id and vim.api.nvim_win_is_valid(float_win_id) then
    vim.api.nvim_win_close(float_win_id, true)
  end

  local buf = vim.api.nvim_create_buf(false, true)

  -- Kitty supports rendering images via "kitty +kitten icat"
  local cmd = string.format("kitty +kitten icat --silent --align left %s", path)
  vim.fn.jobstart(cmd, {detach = true})

  local width, height = 20, 10
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = 2,
    col = 2,
    style = 'minimal',
    focusable = false,
    border = 'none'
  }

  float_win_id = vim.api.nvim_open_win(buf, false, opts)
end

-- Update function based on diagnostics
function M.update()
  if not M.enabled then return end
  local errors = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
  local image = images[get_image_index(errors)]
  show_image(image)
end

-- Toggle plugin
function M.toggle()
  M.enabled = not M.enabled
  if not M.enabled and float_win_id and vim.api.nvim_win_is_valid(float_win_id) then
    vim.api.nvim_win_close(float_win_id, true)
  end
end

-- Autocmd to update when diagnostics change
vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = M.update
})

return M
