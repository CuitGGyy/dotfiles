---------------------------------------------------------------------------------
--
-- deps.lua - mini.deps 插件管理器及插件库装配
--
-- 使用 tweak.lua 调整非`mini.nvim`集成的 nvim 插件默认配置
--
-- Maintainer: cuitggyy (at) google.com
-- Last Modified: 2025/03/24 01:59:26
--
--------------------------------------------------------------------------------


-- 设定配置基础路径
local nvim_config = vim.fn.stdpath('config')

-- 设定插件工作路径
local pack_deps = vim.fs.joinpath(nvim_config, 'pack', 'deps', 'opt')
vim.opt.runtimepath:prepend(pack_deps)

-- 设定`mini.nvim`安装路径
local mini_path = vim.fs.joinpath(pack_deps, 'mini.nvim')

-- 自动下载安装`mini.nvim`
if not (vim.uv or vim.loop).fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local mini_repo = 'https://github.com/echasnovski/mini.nvim'
	local git_clone = {
		'git', 'clone', '--filter=blob:none',
		-- Uncomment next line to use 'stable' branch
		-- '--branch', 'stable',
		mini_repo, mini_path
	}
	local out = vim.fn.system(git_clone)
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ 'Failed to clone mini.nvim:\n', 'ErrorMsg' },
			{ out, 'WarningMsg' },
			{ '\nPress any key to exit...' },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- 添加`mini.nvim`运行路径
vim.opt.runtimepath:prepend(mini_path)

-- 配置`mini.nvim`插件管理器`mini.deps`
-- WARN: 由其管理的插件安装路径前缀被硬编码`pack/deps/opt`
-- 为此其`config.path.package`路径被设定为`nvim_config`
require('mini.deps').setup({
	path = { package = nvim_config }
})

-- 使用'mini.deps'可以安全的进行`2-阶段式`插件加载
-- `now()`启动时当即执行, `later()`启动后延迟加载
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- 添加 mini.nvim 自己
now(function()

	add({ source = 'echasnovski/mini.nvim', })

end)

---- 启用 mini.nvim 插件库独立模块

-- 自动对齐
later(function() require('mini.align').setup({

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		start = 'ga',
		start_with_preview = 'gA',
	},

	-- Modifiers changing alignment steps and/or options
	modifiers = {
		---- Main option modifiers ----
		-- Tweak `j` modifier to cycle through available "justify_side" option
		-- values (like in 'junegunn/vim-easy-align'):
		--['j'] = function(_, opts)
		--	local next_option = ({
		--		left = 'center', center = 'right', right = 'none', none = 'left',
		--	})[opts.justify_side]
		--	opts.justify_side = next_option or 'left'
		--end,

		---- Modifiers adding pre-steps ----
		-- Modifier function used for default 'i' modifier:
		--['i'] = function(steps, _)
		--	table.insert(steps.pre_split, MiniAlign.gen_step.ignore_split())
		--end,
		-- Tweak 't' modifier to use highest indentation instead of keeping it:
		--['t'] = function(steps, _)
		--	local trim_high = MiniAlign.gen_step.trim('both', 'high')
		--	table.insert(steps.pre_justify, trim_high)
		--end,
		-- Use 'T' modifier to remove both whitespace and indent
		--['T'] = function(steps, _)
		--	table.insert(steps.pre_justify, align.gen_step.trim('both', 'remove'))
		--end,

		---- Delete some last pre-step ----
		--['<BS>'] = --<function: delete some last pre-step>,

		---- Special configurations for common splits ----
		--['='] = --<function: enhanced setup for '='>,
		--[','] = --<function: enhanced setup for ','>,
		--['|'] = --<function: enhanced setup for '|'>,
		--[' '] = --<function: enhanced setup for ' '>,
	},

	-- Default options controlling alignment process
	options = {
		split_pattern = '',
		justify_side = 'left',
		merge_delimiter = '',
	},

	-- Default steps performing alignment (if `nil`, default is used)
	steps = {
		pre_split = {},
		split = nil,
		pre_justify = {},
		-- Align by default only first pair of columns:
		--pre_justify = { align.gen_step.filter('n == 1'), },
		justify = nil,
		pre_merge = {},
		merge = nil,
	},

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,

}) end)

--[[
-- 代码注释
now(function() require('mini.comment').setup({

	-- Options which control module behavior
	options = {
		-- Function to compute custom 'commentstring' (optional); default `nil`
		-- Its output should be a valid 'commentstring' (string containing `%s`).
		custom_commentstring = nil,

		-- Whether to ignore blank lines when commenting; default `false`
		ignore_blank_line = false,

		-- Whether to ignore blank lines in actions and textobject; default `false`
		start_of_line = false,

		-- Whether to force single space inner padding for comment parts; default `true`
		pad_comment_parts = false,
	},

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Toggle comment (like `gcip` - comment inner paragraph) for both
		-- Normal and Visual modes; default `gc`
		comment = 'gc',

		-- Toggle comment on current line; default `gcc`
		comment_line = 'gc',

		-- Toggle comment on visual selection; default `gc`
		comment_visual = 'gc',

		-- Define 'comment' textobject (like `dgc` - delete whole comment block)
		-- Works also in Visual mode if mapping differs from `comment_visual`; default `gc`
		textobject = 'gc',
	},

	-- Hook functions to be executed at certain stage of commenting
	hooks = {
		-- Before successful commenting. Does nothing by default.
		pre = function() end,
		-- After successful commenting. Does nothing by default.
		post = function() end,
	},

}) end)
--]]

--[[
--提示补全
later(function() require('mini.completion').setup({

	-- Delay (debounce type, in ms) between certain Neovim event and action.
	-- This can be used to (virtually) disable certain automatic actions by
	-- setting very high delay time (like 10^7).
	delay = { completion = 100, info = 100, signature = 50 },

	-- Configuration for action windows:
	-- - `height` and `width` are maximum dimensions.
	-- - `border` defines border (as in `nvim_open_win()`).
	window = {
		info = { height = 25, width = 80, border = 'single' },
		signature = { height = 25, width = 80, border = 'single' },
	},

	-- Way of how module does LSP completion
	lsp_completion = {
		-- `source_func` should be one of 'completefunc' or 'omnifunc'.
		source_func = 'completefunc',

		-- `auto_setup` should be boolean indicating if LSP completion is set up
		-- on every `BufEnter` event.
		auto_setup = true,

		-- A function which takes LSP 'textDocument/completion' response items
		-- and word to complete. Output should be a table of the same nature as
		-- input items. Common use case is custom filter/sort.
		-- Default: `default_process_items`
		process_items = nil,

		-- A function which takes a snippet as string and inserts it at cursor.
		-- Default: `default_snippet_insert` which tries to use 'mini.snippets'
		-- and falls back to `vim.snippet.expand` (on Neovim>=0.10).
		snippet_insert = nil,
	},

	-- Fallback action as function/string. Executed in Insert mode.
	-- To use built-in completion (`:h ins-completion`), set its mapping as
	-- string. Example: set '<C-x><C-l>' for 'whole lines' completion.
	fallback_action = '<C-n>',

	-- Module mappings. Use `''` (empty string) to disable one. Some of them
	-- might conflict with system mappings.
	mappings = {
		-- Force two-step/fallback completions
		force_twostep = '<C-Space>',
		force_fallback = '<A-Space>',

		-- Scroll info/signature window down/up. When overriding, check for
		-- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
		-- for 'completefunc'/'omnifunc' source function; or `<C-n>`/`<C-p>`).
		scroll_down = '<C-f>',
		scroll_up = '<C-b>',
	},

	-- Whether to set Vim's settings for better experience (modifies
	-- `shortmess` and `completeopt`)
	set_vim_settings = true,

}) end)
--]]

-- 行块移动
now(function() require('mini.move').setup({

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
		left = '<s-left>',
		right = '<s-right>',
		down = '<s-down>',
		up = '<s-up>',

		-- Move current line in Normal mode
		line_left = '<s-left>',
		line_right = '<s-right>',
		line_down = '<s-down>',
		line_up = '<s-up>',
	},

	-- Options which control moving behavior
	options = {
		-- Automatically reindent selection during linewise vertical move
		reindent_linewise = true,
	},

}) end)

-- 自动括号
now(function() require('mini.pairs').setup({

	-- In which modes mappings from this `config` should be created
	modes = { insert = true, command = false, terminal = false },

	-- Global mappings. Each right hand side should be a pair information, a
	-- table with at least these fields (see more in |MiniPairs.map|):
	-- - <action> - one of 'open', 'close', 'closeopen'.
	-- - <pair> - two character string for pair to be used.
	-- By default pair is not inserted after `\`, quotes are not recognized by
	-- `<CR>`, `'` does not insert pair after a letter.
	-- Only parts of tables can be tweaked (others will use these defaults).
	mappings = {
		['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
		['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
		['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

		[')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
		[']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
		['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

		['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
		["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
		['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
	},

}) end)

-- 语法展开合并
now(function() require('mini.splitjoin').setup({

	-- Module mappings. Use `''` (empty string) to disable one.
	-- Created for both Normal and Visual modes.
	mappings = {
		toggle = 'gS',
		split = '',
		join = '',
	},

	-- Detection options: where split/join should be done
	detect = {
		-- Array of Lua patterns to detect region with arguments.
		-- Default: { '%b()', '%b[]', '%b{}' }
		brackets = nil,

		-- String Lua pattern defining argument separator
		separator = ',',

		-- Array of Lua patterns for sub-regions to exclude separators from.
		-- Enables correct detection in presence of nested brackets and quotes.
		-- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
		exclude_regions = nil,
	},

	-- Split options
	split = {
		hooks_pre = {},
		hooks_post = {},
	},

	-- Join options
	join = {
		hooks_pre = {},
		hooks_post = {},
	},

}) end)

-- textobject 环绕增删改查
now(function() require('mini.surround').setup({

	-- Add custom surroundings to be used on top of builtin ones. For more
	-- information with examples, see `:h MiniSurround.config`.
	custom_surroundings = nil,

	-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
	highlight_duration = 500,

	-- Module mappings. Use `''` (empty string) to disable one.
	mappings = {
		add = 'ys', -- Add surrounding in Normal and Visual modes
		delete = 'ds', -- Delete surrounding
		find = '', -- Find surrounding (to the right)
		find_left = '', -- Find surrounding (to the left)
		highlight = 'hs', -- Highlight surrounding
		replace = 'cs', -- Replace surrounding
		update_n_lines = 'ns', -- Update `n_lines`

		suffix_last = 'l', -- Suffix to search with "prev" method
		suffix_next = 'n', -- Suffix to search with "next" method
	},

	-- Number of lines within which surrounding is searched
	n_lines = 20,

	-- Whether to respect selection type:
	-- - Place surroundings on separate lines in linewise mode.
	-- - Place surroundings on each line in blockwise mode.
	respect_selection_type = false,

	-- How to search for surrounding (first inside current line, then inside
	-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
	-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
	-- see `:h MiniSurround.config`.
	search_method = 'cover',

	-- Whether to disable showing non-error feedback
	-- This also affects (purely informational) helper messages shown after
	-- idle time if user input is required.
	silent = false,

}) end)

---- General workflow ----

-- 方括号操作扩展
now(function() require('mini.bracketed').setup({

	-- First-level elements are tables describing behavior of a target:
	--
	-- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
	--   For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
	--   Supply empty string `''` to not create mappings.
	--
	-- - <options> - table overriding target options.
	--
	-- See `:h MiniBracketed.config` for more info.

	-- 后缀绑定为''的功能极易误操作, 所以去除对应功能, 释放键位映射, 减少按键冲突
	buffer = { suffix = '', options = {} },
	comment = { suffix = 'c', options = {} },
	conflict = { suffix = 'x', options = {} },
	diagnostic = { suffix = 'd', options = {} },
	file = { suffix = '', options = {} },
	indent = { suffix = 'i', options = {} },
	jump = { suffix = 'j', options = {} },
	location = { suffix = 'l', options = {} },
	oldfile = { suffix = '', options = {} },
	quickfix = { suffix = 'q', options = {} },
	treesitter = { suffix = 't', options = {} },
	undo = { suffix = '', options = {} },
	window = { suffix = '', options = {} },
	yank = { suffix = '', options = {} },

}) end)

-- 文件管理器
now(function()

	-- 插件选项自定义配置
	require('mini.files').setup({

		-- Customization of shown content
		content = {
			-- Predicate for which file system entries to show
			filter = nil,
			-- What prefix to show to the left of file system entry
			prefix = nil,
			-- In which order to show file system entries
			sort = nil,
		},

		--[[
		| Action      | Keys | Description                                    |
		|-------------|------|------------------------------------------------|
		| Close       |  q   | Close explorer                                 |
		|-------------|------|------------------------------------------------|
		| Go in       |  l   | Expand entry (show directory or open file)     |
		|-------------|------|------------------------------------------------|
		| Go in plus  |  L   | Expand entry plus extra action                 |
		|-------------|------|------------------------------------------------|
		| Go out      |  h   | Focus on parent directory                      |
		|-------------|------|------------------------------------------------|
		| Go out plus |  H   | Focus on parent directory plus extra action    |
		|-------------|------|------------------------------------------------|
		| Go to mark  |  '   | Jump to bookmark (waits for single key id)     |
		|-------------|------|------------------------------------------------|
		| Set mark    |  m   | Set bookmark (waits for single key id)         |
		|-------------|------|------------------------------------------------|
		| Reset       | <BS> | Reset current explorer                         |
		|-------------|------|------------------------------------------------|
		| Reveal cwd  |  @   | Reset current current working directory        |
		|-------------|------|------------------------------------------------|
		| Show help   |  g?  | Show help window                               |
		|-------------|------|------------------------------------------------|
		| Synchronize |  =   | Synchronize user edits and/or external changes |
		|-------------|------|------------------------------------------------|
		| Trim left   |  <   | Trim left part of branch                       |
		|-------------|------|------------------------------------------------|
		| Trim right  |  >   | Trim right part of branch                      |
		|-------------|------|------------------------------------------------|
	--]]

		-- Module mappings created only inside explorer.
		-- Use `''` (empty string) to not create one.
		mappings = {
			close = 'q',
			go_in = '<right>',
			go_in_plus = '<s-right>',
			go_out = '<left>',
			go_out_plus = '<s-left>',
			mark_goto = "'",
			mark_set = 'm',
			reset = '<backspace>',
			reveal_cwd = '-',
			show_help = 'g?',
			synchronize = '=',
			trim_left = '<',
			trim_right = '>',
		},

		-- General options
		options = {
			-- Whether to delete permanently or move into module-specific trash, default `true`
			permanent_delete = true,
			-- Whether to use for editing directories
			use_as_default_explorer = true,
		},

		-- Customization of explorer windows
		windows = {
			-- Maximum number of windows to show side by side
			max_number = math.huge,
			-- Whether to show preview of file/directory under cursor, default `false`
			preview = false,
			-- Width of focused window
			width_focus = 50,
			-- Width of non-focused window
			width_nofocus = 15,
			-- Width of preview window
			width_preview = 25,
		},
	})

	-- 增加是否`.`隐藏文件选项
	local show_dotfiles = true
	local filter_show = function(fs_entry) return true end
	local filter_hide = function(fs_entry)
		return not vim.startswith(fs_entry.name, '.')
	end

	local toggle_dotfiles = function()
		show_dotfiles = not show_dotfiles
		local new_filter = show_dotfiles and filter_show or filter_hide
		MiniFiles.refresh({ content = { filter = new_filter } })
	end
	-- 映射`g.`按键作为切换开关
	vim.api.nvim_create_autocmd('User', {
		pattern = 'MiniFilesBufferCreate',
		callback = function(args)
			local buf_id = args.data.buf_id
			-- Tweak left-hand side of mapping to your liking
			vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
		end,
	})

end)


---- Appearance ----

-- 自定义高亮模式
now(function()

	local hipatterns = require('mini.hipatterns')

	hipatterns.setup({
		-- Delays (in ms) defining asynchronous highlighting process
		delay = {
			-- How much to wait for update after every text change
			text_change = 200,
			-- How much to wait for update after window scroll
			scroll = 50,
		},
	})

	hipatterns.setup({
		-- Table with highlighters (see |MiniHipatterns.config| for more details).
		-- Nothing is defined by default. Add manually for visible effect.
		highlighters = {
			--[[
			-- Highlight standalone 'FIXME:', 'HACK:', 'TODO:', 'NOTE:'
			fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
			bug = { pattern = '%f[%w]()BUG()%f[%W]', group = 'MiniHipatternsFixme' },
			hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
			warn = { pattern = '%f[%w]()WARN()%f[%W]', group = 'MiniHipatternsHack' },
			todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
			xxx = { pattern = '%f[%w]()XXX()%f[%W]', group = 'MiniHipatternsTodo' },
			note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
			--]]
			--
			fixme = { pattern = '%f[%w]()FIXME()%f[:]', group = 'MiniHipatternsFixme' },
			bug = { pattern = '%f[%w]()BUG()%f[:]', group = 'MiniHipatternsFixme' },
			hack = { pattern = '%f[%w]()HACK()%f[:]', group = 'MiniHipatternsHack' },
			warn = { pattern = '%f[%w]()WARN()%f[:]', group = 'MiniHipatternsHack' },
			todo = { pattern = '%f[%w]()TODO()%f[:]', group = 'MiniHipatternsTodo' },
			xxx = { pattern = '%f[%w]()XXX()%f[:]', group = 'MiniHipatternsTodo' },
			note = { pattern = '%f[%w]()NOTE()%f[:]', group = 'MiniHipatternsNote' },
			notice = { pattern = '%f[%w]()NOTICE()%f[:]', group = 'MiniHipatternsNote' },

			-- Highlight hex color strings (`#rrggbb`) using that color
			hex_color = hipatterns.gen_highlighter.hex_color(),
		},
	})

end)

-- nerdfont 字体图标库
now(function()

	require('mini.icons').setup({
		-- Icon style: 'glyph' or 'ascii'
		style = 'glyph',

		-- Customize per category. See `:h MiniIcons.config` for details.
		default = {},
		directory = {},
		extension = {
			['.sh'] = { glyph = '', hl = 'MiniIconsGreen', },
			['.md'] = { glyph = '󰍔', hl = 'MiniIconsGrey', },
		},
		file = {},
		filetype = {},
		lsp = {},
		os = {},

		-- Control which extensions will be considered during "file" resolution
		use_file_extension = function(ext, file) return true end,
	})

	-- 使用 MiniIcons 模拟 nvim-web-devicons 插件接口
	-- 若已安装并加载 nvim-web-devicons 插件,
	-- 将下面`mock`代码放置于 nvim-web-devicons 初始化之后,
	-- MiniIcons 模块才会真正起作用
	MiniIcons.mock_nvim_web_devicons()

end)

--[[
-- 通知提示
later(function()

	require('mini.notify').setup({
		-- Content management
		content = {
			-- Function which formats the notification message
			-- By default prepends message with notification time
			--format = nil,
			format = function(notify)
				if notify.data.source == 'lsp_progress' then
					return notify.msg
				end
				return MiniNotify.default_format(notify)
			end,

			-- Function which orders notification array from most to least important
			-- By default orders first by level and then by update timestamp
			--sort = nil,
			sort = function(notify_array)
				table.sort(notify_array, function(a, b)
					return a.ts_update > b.ts_update
				end)
				return notify_array
			end,
		},

		-- Notifications about LSP progress
		lsp_progress = {
			-- Whether to enable showing
			enable = true,
			-- Notification level
			level = 'INFO',
			-- Duration (in ms) of how long last message should be shown
			duration_last = 1000,
		},

		-- Window options
		window = {
			-- Floating window config
			config = {
				border = 'single',
			},
			--config = function()
			--	local has_statusline = vim.o.laststatus > 0
			--	local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
			--	return { border = 'none', anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
			--end,
			-- Maximum window width as share (between 0 and 1) of available columns
			max_width_share = 0.382,
			-- Value of 'winblend' option
			winblend = 25,
		},
	})

	-- 通知提示显示时限及配色样式
	local opts = {
		ERROR = { duration = 7000, hl_group = 'DiagnosticError', },
		WARN = { duration = 5000, hl_group = 'DiagnosticWarn', },
		INFO = { duration = 3000, hl_group = 'DiagnosticInfo', },
		DEBUG = { duration = 0, hl_group = 'DiagnosticHint', },
		TRACE = { duration = 0, hl_group = 'DiagnosticOk', },
		OFF = { duration = 0, hl_group = 'MiniNotifyNormal', },
	}
	-- Change duration for errors to show them longer
	vim.notify = require('mini.notify').make_notify()

	-- Get map of used notifications with keys being notification identifiers.
	-- Can be used to get only active notification objects.
	--vim.tbl_filter(
	--	function(notify) return notify.ts_remove == nil end,
	--	require('mini.notify').get_all()
	--)

end)
--]]

--[[
-- 行尾空格
later(function()

	require('mini.trailspace').setup({
		-- Highlight only in normal buffers (ones with empty 'buftype'). This is
		-- useful to not show trailing whitespace where it usually doesn't matter.
		only_in_normal_buffers = true,
	})

	-- HACK: We need to disable the mini.trailspace and enable when a new buffer is
	-- created to avoid interference with the dashboard snacks.nvim. See:
	-- https://github.com/echasnovski/mini.nvim/issues/1395
	vim.g.minitrailspace_disable = true
	vim.api.nvim_create_autocmd('BufNew', {
		callback = function()
			vim.g.minitrailspace_disable = false
		end
	})

end)
--]]

---- Other ----

-- 模糊匹配优化
now(function() require('mini.fuzzy').setup({

	-- Maximum allowed value of match features (width and first match). All
	-- feature values greater than cutoff can be considered "equally bad".
	cutoff = 100,

}) end)


