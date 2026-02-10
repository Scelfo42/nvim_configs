-- lua/conf/terminal.lua
-- One reusable terminal buffer + toggleable splits.
-- - <leader>tt opens/toggles the terminal on the right (reuses same terminal)
-- - <leader>tb opens/toggles the terminal below (reuses same terminal)
-- - <Esc> in terminal hides/closes the terminal window but keeps the job running
-- - Terminal stays in the buffer list (so :bnext/:bprev can land on it)
-- - Whenever you enter a terminal buffer/window, it drops you into terminal input

local M = {}

local term_buf = nil

local function is_valid_term_buf(buf)
  return buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal"
end

local function term_win_for_buf(buf)
  local wins = vim.fn.win_findbuf(buf)
  if wins and #wins > 0 then
    return wins[1]
  end
  return nil
end

-- Create the terminal in the requested split direction and return the buffer id
local function create_terminal_buf(direction)
  if direction == "v" then
    vim.cmd("vsplit | terminal")
  else
    vim.cmd("split | terminal")
  end
  return vim.api.nvim_get_current_buf()
end

local function ensure_terminal_buf(direction)
  if is_valid_term_buf(term_buf) then
    return term_buf
  end
  term_buf = create_terminal_buf(direction)
  return term_buf
end

local function open_terminal(direction)
  local buf = ensure_terminal_buf(direction)

  -- If already visible, focus it and enter terminal input
  local win = term_win_for_buf(buf)
  if win then
    vim.api.nvim_set_current_win(win)
    vim.cmd("startinsert")
    return
  end

  -- Otherwise open a split and show the existing terminal buffer
  if direction == "v" then
    vim.cmd("vsplit")
  else
    vim.cmd("split")
  end

  vim.api.nvim_win_set_buf(0, buf)
  vim.cmd("startinsert")
end

local function toggle_terminal(direction)
  if is_valid_term_buf(term_buf) then
    local win = term_win_for_buf(term_buf)
    if win then
      -- Hide terminal window, keep terminal job/buffer alive
      vim.api.nvim_win_close(win, true)
      return
    end
  end
  open_terminal(direction)
end

function M.setup(opts)
  opts = opts or {}
  local map = opts.map or vim.keymap.set
  local silent = { silent = true }

  -- Toggle terminal splits (reuse same terminal buffer)
  map("n", "<leader>tt", function() toggle_terminal("v") end, silent) -- right
  map("n", "<leader>tb", function() toggle_terminal("h") end, silent) -- below

  -- Terminal buffer cosmetics + keep job alive when window closes
  vim.api.nvim_create_autocmd("TermOpen", {
    callback = function(args)
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.opt_local.signcolumn = "no"
      vim.opt_local.cursorline = false

      -- Keep terminal running when its window is closed
      vim.bo[args.buf].bufhidden = "hide"

      vim.cmd("startinsert")
    end,
  })

  -- If you enter a terminal buffer/window (e.g., via :bnext/:bprev or window jump),
  -- jump straight into terminal input.
  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    callback = function()
      if vim.bo.buftype == "terminal" then
        vim.cmd("startinsert")
      end
    end,
  })

  -- ESC in terminal: close/hide the terminal window but keep terminal running
  map("t", "<Esc>", function()
    if vim.bo.buftype ~= "terminal" then
      return
    end
    vim.cmd("stopinsert")
    pcall(vim.cmd, "hide")
    end, silent)
end

return M

