vim.api.nvim_create_user_command("Quartz", function(opts)
  local state = { cwd = nil, height = 15, cmd = { "npx", "quartz", "build", "--serve", "--verbose", "--bundleInfo" } }
  for _, arg in ipairs(opts.fargs) do
    local value = arg:match "cwd=([^%s]+)"
    if value then
      state.cwd = value
    else
      table.insert(state.cmd, arg)
    end
  end
  if state.cwd == nil then state.cwd = Util.root() end
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, state.height)
  vim.wo.winfixheight = true
  vim.fn.termopen(state.cmd, { persistent = true, cwd = state.cwd, height = state.height })
end, {
  desc = "quartz: start server",
  nargs = "*",
  complete = function(_, _, _)
    local candidates = {} ---@type string[]
    vim.list_extend(
      candidates,
      ---@param x string
      vim.tbl_map(function(x) return "cwd=" .. x end, { Util.root() })
    )
    return candidates
  end,
})
