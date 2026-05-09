local session_dir = vim.fn.expand("~/.local/nvim_sessions")

if vim.fn.isdirectory(session_dir) == 0 then
  vim.fn.mkdir(session_dir, "p")
end

local function get_session_path()
  local cwd = vim.fn.getcwd()
  local hash = vim.fn.sha256(cwd)
  return session_dir .. "/" .. hash .. ".vim"
end

local function save_session()
  local path = get_session_path()
  vim.cmd("mksession! " .. path)
  print("Session saved")
end

local function load_session()
  local path = get_session_path()
  if vim.fn.filereadable(path) == 1 then
    vim.cmd("source " .. path)
    print("Session loaded")
  else
    print("No session found for this directory")
  end
end

local function delete_session()
  local path = get_session_path()
  if vim.fn.filereadable(path) == 1 then
    os.remove(path)
    print("Session deleted")
  else
    print("No session to delete")
  end
end

vim.keymap.set("n", "<leader>ss", save_session, { noremap = true, desc = "Save session" })
vim.keymap.set("n", "<leader>sl", load_session, { noremap = true, desc = "Load session" })
vim.keymap.set("n", "<leader>sd", delete_session, { noremap = true, desc = "Delete session" })


local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
  return
end

wk.add({
  { '<leader>s', group = 'Session', mode = 'n' }
})
