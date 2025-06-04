local enabled = true

if not enabled then return {} end

---@type LazySpec
return {
  'zbirenbaum/copilot-cmp',
  dependencies = { 'zbirenbaum/copilot.lua' },
  config = function ()
    require 'copilot_cmp'.setup()
  end
}
