local pickers      = require "telescope.pickers"
local finders      = require "telescope.finders"
local conf         = require("telescope.config").values
local actions      = require "telescope.actions"
local action_state = require "telescope.actions.state"

local M           = {}
local project_dir = -1

M.find_dirs = function(opts)

	opts = opts or {}
	print(project_dir)

	if project_dir == -1 then
		print("ERROR: option 'project_dir' not set.")
		return
	end

	if 0 == vim.fn.executable "fd" then
		print("ERROR: 'fd' not found!")
		return
	end

	if 0 == vim.fn.executable "cdfd" then
		print("ERROR: 'cdfd' not found!")
		return
	end

	local find_command = { "cdfd", project_dir }

	pickers.new(opts, {
		prompt_title = "Change Working Directory",
		finder       = finders.new_oneshot_job(find_command, opts),
    previewer    = conf.file_previewer(opts),
		sorter       = conf.file_sorter(opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				-- print(vim.inspect(selection))
				-- vim.api.nvim_put({ selection[1] }, "", false, true)
				vim.api.nvim_set_current_dir(selection[1])
			end)
			return true
		end,
	}):find()
end

return require("telescope").register_extension({
	setup = function(opts)
		project_dir = opts.project_dir or -1
	end,
	exports = {
		find_dirs = M.find_dirs,
	},
})
