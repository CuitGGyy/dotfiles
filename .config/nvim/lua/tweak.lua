--------------------------------------------------------------------------------
--
-- tweak.lua - 调整插件默认选项配置
--
-- 依赖 mini.deps 插件管理器及插件分组配置
--
-- Maintainer: cuitggyy (at) google.com
-- Last Modified: 2025/03/31 18:05:14
--
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 变量重命名与函数预定义
--------------------------------------------------------------------------------
local api, fn, cmd = vim.api, vim.fn, vim.cmd
local map = vim.keymap.set


-- 使用'mini.deps'可以安全的进行`2-阶段式`插件加载
-- `now()`启动时当即执行, `later()`启动后延迟加载
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later


--------------------------------------------------------------------------------
-- folke/tokyonight.nvim
--------------------------------------------------------------------------------
now(function()

	-- `东京之夜`色彩主题样式
	add({ source = 'folke/tokyonight.nvim', })

	-- 插件选项自定义配置
	require('tokyonight').setup({
		style = 'night',
		transparent = false,
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value for `:help nvim_set_hl`
			comments = { italic = false },
			keywords = { italic = false },
			functions = { italic = false },
			variables = { italic = false },
			-- Background styles. Can be 'dark', 'transparent' or 'normal'
			sidebars = 'transparent', -- style for sidebars, see below
			floats = 'transparent', -- style for floating windows
		},
		-- Adjusts the brightness of the colors of the **Day** style.
		-- Number between 0 and 1, from dull to vibrant colors
		day_brightness = 0.3,
		-- dims inactive windows
		dim_inactive = false,
		-- When `true`, section headers in the lualine theme will be bold
		lualine_bold = false,
		-- 默认高亮颜色
		on_highlights = function(highlights, colors) end,
		-- When set to true, the theme will be cached for better performance
		cache = true,
	})

end)


--------------------------------------------------------------------------------
-- catppuccin/nvim
--------------------------------------------------------------------------------
--[[
now(function()

	-- Catppuccin 系列色彩主题样式
	add({
		source = 'catppuccin/nvim',
		name = 'catppuccin',
	})

	-- 插件选项自定义配置
	require('catppuccin').setup({
		-- latte, frappe, macchiato, mocha
		flavour = 'auto',
		-- :h background
		background = {
			light = 'latte',
			dark = 'mocha',
		},
		-- disables setting the background color.
		transparent_background = false,
		-- shows the '~' characters after the end of buffers
		show_end_of_buffer = false,
		-- sets terminal colors (e.g. `g:terminal_color_0`)
		term_colors = false,
		dim_inactive = {
			-- dims the background color of inactive window
			enabled = false,
			shade = 'dark',
			-- percentage of the shade to apply to the inactive window
			percentage = 0.15,
		},
		-- Force no italic
		no_italic = false,
		-- Force no bold
		no_bold = false,
		-- Force no underline
		no_underline = false,
		-- Handles the styles of general hi groups (see `:h highlight-args`):
		styles = {
			-- Change the style of comments
			comments = { 'italic' },
			conditionals = { 'italic' },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
			-- Uncomment to turn off hard-coded styles
			-- miscs = {},
		},
		color_overrides = {},
		custom_highlights = {},
		default_integrations = true,
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = '',
			},
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})

	-- setup must be called before loading
	--vim.cmd.colorscheme "catppuccin"

end)
--]]


--------------------------------------------------------------------------------
-- navarasu/onedark.nvim
--------------------------------------------------------------------------------
now(function()

	-- 复刻 atom 色彩主题样式
	add({ source = 'navarasu/onedark.nvim', })

	-- 插件选项自定义配置
	require('onedark').setup({
		---- Main options ----
		-- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
		style = 'deep',
		-- Show/hide background
		transparent = false,
		-- Change terminal color as per the selected theme style
		term_colors = true,
		-- Show the end-of-buffer tildes. By default they are hidden
		ending_tildes = false,
		-- reverse item kind highlights in cmp menu
		cmp_itemkind_reverse = false,

		---- toggle theme style ----
		-- keybind to toggle theme style. Leave it nil to disable it,
		-- or set it to a string, for example "<leader>ts"
		toggle_style_key = nil,
		-- List of styles to toggle between
		toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'},

		---- Change code style ----
		-- Options are italic, bold, underline, none
		-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
		code_style = {
			comments = 'none',
			keywords = 'none',
			functions = 'none',
			strings = 'none',
			variables = 'none'
		},

		---- Lualine options ----
		lualine = {
			-- lualine center bar transparency
			transparent = false,
		},

		---- Custom Highlights ----
		colors = {}, -- Override default colors
		highlights = {}, -- Override highlight groups

		---- Plugins Config ----
		diagnostics = {
			-- darker colors for diagnostic
			darker = true,
			-- use undercurl instead of underline for diagnostics
			undercurl = true,
			-- use background color for virtual text
			background = true,
		},
	})

end)


--------------------------------------------------------------------------------
-- EdenEast/nightfox.nvim
--------------------------------------------------------------------------------
--[[
now(function()

	-- `暗夜之狐`色彩主题样式
	add({ source = 'EdenEast/nightfox.nvim', })

	-- 插件选项默认配置
	require('nightfox').setup({
		options = {
			-- Compiled file's destination location
			compile_path = fn.stdpath('cache') .. '/nightfox',
			-- Compiled file suffix
			compile_file_suffix = '_compiled',
			-- Disable setting background
			transparent = false,
			-- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
			terminal_colors = false,
			-- Non focused panes set to alternative background
			dim_inactive = false,
			-- Default enable value for modules
			module_default = true,
			colorblind = {
				-- Enable colorblind support
				enable = false,
				-- Only show simulated colorblind colors and not diff shifted
				simulate_only = false,
				severity = {
					-- Severity [0,1] for protan (red)
					protan = 0,
					-- Severity [0,1] for deutan (green)
					deutan = 0,
					-- Severity [0,1] for tritan (blue)
					tritan = 0,
				},
			},
			-- Style to be applied to different syntax groups
			styles = {
				-- Value is any valid attr-list value `:help attr-list`
				comments = 'NONE',
				conditionals = 'NONE',
				constants = 'NONE',
				functions = 'NONE',
				keywords = 'NONE',
				numbers = 'NONE',
				operators = 'NONE',
				strings = 'NONE',
				types = 'NONE',
				variables = 'NONE',
			},
			-- Inverse highlight for different types
			inverse = {
				match_paren = false,
				visual = false,
				search = false,
			},
			-- List of various plugins and additional options
			modules = {
				-- ...
			},
		},
		palettes = {},
		specs = {},
		groups = {},
	})

	-- require('nightfox').compile()

end)
--]]


--------------------------------------------------------------------------------
-- Mofiqul/vscode.nvim
--------------------------------------------------------------------------------
now(function()

	-- 复刻 vscode 色彩主题样式
	add({ source = 'Mofiqul/vscode.nvim', })

	-- 加载插件选项默认配置
	local colors = require('vscode.colors').get_colors()
	require('vscode').setup({
		-- Alternatively set style in setup
		style = 'dark',

		-- Enable transparent background
		transparent = false,

		-- Enable italic comment
		italic_comments = false,

		-- Underline `@markup.link.*` variants
		underline_links = false,

		-- Disable nvim-tree background color
		disable_nvimtree_bg = true,

		-- Apply theme colors to terminal
		terminal_colors = true,

		-- Override colors (see ./lua/vscode/colors.lua)
		color_overrides = {
			vscLineNumber = '#5a5a5a',
		},

		-- Override highlight groups (see ./lua/vscode/theme.lua)
		group_overrides = {
			-- this supports the same val table as vim.api.nvim_set_hl
			-- use colors from this colorscheme by requiring vscode.colors!
			Cursor = { fg = colors.vscCursorDark, bg = colors.vscCursorLight, },
		},
	})

	-- require('vscode').load()

end)


--------------------------------------------------------------------------------
-- 依据时间段自动启用不同的色彩主题样式
--------------------------------------------------------------------------------
-- 应尽早加载 colorscheme 使其他插件正确配色
if package.loaded['tokyonight'] and package.loaded['onedark'] then
	local hour = tonumber(os.date('%H'))
	-- 白天 9:00-18:00 高对比
	if hour > 8 and hour < 18 then
		cmd('colorscheme onedark')
	-- 晚上 18:00-9:00 低亮度
	else
		cmd('colorscheme tokyonight')
	end
else
	cmd('colorscheme vscode')
end


--------------------------------------------------------------------------------
-- nvim-tree/nvim-web-devicons
--------------------------------------------------------------------------------
if package.loaded['mini.icons'] == nil then
	-- 使用 nvim-web-devicons 插件
	now(function()
		-- nerdfont 字体图标库
		add({ source = 'nvim-tree/nvim-web-devicons', })
	end)
	-- 使用 MiniIcons 模拟 nvim-web-devicons 插件接口
	--MiniIcons.mock_nvim_web_devicons()
end


--------------------------------------------------------------------------------
-- nvim-lualine/lualine.nvim
--------------------------------------------------------------------------------
now(function()

	-- lua 版轻量级状态栏
	add({
		source = 'nvim-lualine/lualine.nvim',
		-- 使用 MiniIcons 模拟 nvim-web-devicons 模块代替
		--depends = { 'nvim-tree/nvim-web-devicons' },
	})

	-- 显示缓冲区索引编号及文件状态的回调函数
	local function bufnum(number, context)
		if vim.bo.readonly then
			return string.format('%d | RO', number)
		end
		return number
	end

	-- 插件选项自定义配置
	require('lualine').setup({
		options = {
			icons_enabled = true,
			theme = 'auto',
			--component_separators = { left = '', right = ''},
			--section_separators = { left = '', right = ''},
			component_separators = { left = '', right = ''},
			section_separators = { left = '', right = ''},
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			}
		},
		sections = {
			lualine_a = {
				{ 'mode', color = { term = 'none', gui = 'none', }, fmt = function(mode, context)
					if vim.o.paste then
						mode = string.format('%s | %s', mode, 'PASTE')
					end
					if vim.o.spell then
						mode = string.format('%s | %s', mode, 'SPELL')
					end
					return mode
				end, },
				{'selectioncount', padding = { left = 0, right = 1, }, fmt = function(select, context)
					if select ~= '' then
						return string.format('| %s', select)
					end
				end, },
			},
			lualine_b = {
				{ '%n', fmt = bufnum(number, context), },
				{ 'branch', padding = { left = 0, right = 1, }, },
				{ 'diff', padding = { left = 0, right = 1, }, },
				{ 'diagnostics', padding = { left = 0, right = 1, }, },
			},
			lualine_c = {
				{ 'filename', path = 1, symbols = {
					modified = '+', readonly = '-', unnamed = '[No Name]', newfile = '[New]',
				}, padding = { left = 1, right = 1, }, },
				{'searchcount', padding = { left = 0, right = 1, }, },
			},
			lualine_x = {
				{ 'filetype', padding = { left = 0, right = 1, }, },
			},
			lualine_y = {
				{ 'encoding', show_bomb = true, padding = { left = 1, right = 1, }, },
				{ 'fileformat', symbols = { unix = '', dos = '', mac = '', }, padding = { left = 0, right = 1, }, },
				--{ 'fileformat', symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' }, padding = { left = 0, right = 1, }, },
				{ 'filesize', padding = { left = 0, right = 1, }, },
			},
			lualine_z = {
				{ '%l:%c/%L %p%%', padding = { left = 1, right = 1, }, },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {
				{'%n', fmt = bufnum(number, context), },
				{ 'branch', padding = { left = 0, right = 1, }, },
				{ 'diff', padding = { left = 0, right = 1, }, },
				{ 'diagnostics', padding = { left = 0, right = 1, }, },
			},
			lualine_c = {
				{ 'filename', symbols = {
					modified = '+', readonly = '-', unnamed = '[No Name]', newfile = '[New]',
				}, padding = { left = 0, right = 1, }, },
				{'searchcount', padding = { left = 0, right = 1, }, },
			},
			lualine_x = {
				{ 'filetype', padding = { left = 0, right = 1, }, },
			},
			lualine_y = {
				{ '%{&fenc!=#""?&fenc:&enc} (%{&ff})', padding = { left = 0, right = 1, }, },
				{ 'filesize', padding = { left = 0, right = 1, }, },
			},
			lualine_z = {
				{ '%l:%c/%L %p%%', padding = { left = 0, right = 1, }, },
			},
		},
		-- 使用 autofn 内自己写的 tabline 样式配置
		tabline = {
			--[[
			lualine_a = {},
			lualine_b = {},
			lualine_c = { {
				'buffers',
				--color = { term = 'bold', gui = 'bold', },
				-- Automatically updates active buffer color to match color of other components (will be overidden if buffers_color is set)
				use_mode_colors = false,
				symbols = {
					modified = ' ●',      -- Text to show when the buffer is modified
					alternate_file = '#', -- Text to show to identify the alternate file
					directory =  '',     -- Text to show when the buffer is a directory
				},
			}, },
			lualine_x = {},
			lualine_y = {},
			lualine_z = { {
				'tabs',
				--color = { term = 'bold', gui = 'bold', },
				-- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
				use_mode_colors = false,
				-- Shows a symbol next to the tab name if the file has been modified.
				show_modified_status = false,
				symbols = {
					-- Text to show when the file is modified.
					modified = '[+]',
				},
			}, },
			--]]
		},
		winbar = {},
		inactive_winbar = {},
		extensions = { 'quickfix', 'fzf', },
	})

end)


--------------------------------------------------------------------------------
-- akinsho/bufferline.nvim
--------------------------------------------------------------------------------
now(function()

	-- 功能多样的标签页栏
	add({
		source = 'akinsho/bufferline.nvim',
		depends = {
		-- 使用 MiniIcons 模拟 nvim-web-devicons 模块代替
		--depends = { 'nvim-tree/nvim-web-devicons' },
		},
	})

	-- 通过tab标签页序列值获取buffer缓冲区编号
	local function bufnr_by_tabpage(num)
		local buflist = fn.tabpagebuflist(num)
		local winnr = fn.tabpagewinnr(num)
		local bufnr = buflist[winnr]
		return bufnr
	end

	-- 插件选项自定义配置
	bufferline = require('bufferline')
	bufferline.setup({
		options = {
			mode = 'tabs',
			themable = true, -- whether or not bufferline highlights can be overridden externally
			style_preset = {
				--bufferline.style_preset.minimal,
				bufferline.style_preset.no_italic,
			},
			numbers = function(opts)
				--return string.format('%s/%s', opts.raise(opts.id), opts.lower(opts.ordinal))
				--return string.format('%s·%s', opts.ordinal, opts.raise(opts.id))
				return string.format('%s·%s', opts.ordinal, opts.raise( bufnr_by_tabpage(opts.ordinal) ))
			end,
			buffer_close_icon = '',
			modified_icon = '●',
			close_icon = '',
			close_command = 'bdelete! %d',
			left_mouse_command = 'buffer %d',
			right_mouse_command = 'bdelete! %d',
			middle_mouse_command = nil,
			-- U+2590 ▐ Right half block, this character is right aligned so the
			-- background highlight doesn't appear in the middle
			-- alternatives:  right aligned => ▕ ▐ ,  left aligned => ▍
			indicator = { icon = '▎', style = 'icon' },
			left_trunc_marker = '',
			right_trunc_marker = '',
			separator_style = 'thin',
			name_formatter = nil,
			truncate_names = true,
			tab_size = 15,
			max_name_length = 15,
			color_icons = true,
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			get_element_icon = nil,
			show_close_icon = true,
			show_tab_indicators = true,
			show_duplicate_prefix = true,
			duplicates_across_groups = true,
			enforce_regular_tabs = false,
			always_show_bufferline = true,
			auto_toggle_bufferline = true,
			persist_buffer_sort = true,
			move_wraps_at_ends = false,
			max_prefix_length = 12,
			-- 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs'
			sort_by = 'tabs',
			diagnostics = false,
			diagnostics_indicator = nil,
			diagnostics_update_in_insert = true,
			diagnostics_update_on_event = true,
			offsets = {},
			groups = { items = {}, options = { toggle_hidden_on_enter = true } },
			hover = { enabled = false, reveal = {}, delay = 200 },
			debug = { logging = false },
			pick = {
				alphabet = 'abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890',
			},
		}
	})

end)


--------------------------------------------------------------------------------
-- nvimdev/dashboard-nvim
--------------------------------------------------------------------------------
now(function()

	-- 更有用的起始欢迎界面, 显示最近编辑过的文件
	add({
		source = 'nvimdev/dashboard-nvim',
		-- 使用 MiniIcons 模拟 nvim-web-devicons 模块代替
		--depends = { 'nvim-tree/nvim-web-devicons' },
	})

	-- 插件选项自定义配置
	require('dashboard').setup({
		-- theme is doom and hyper default is hyper
		theme = 'hyper',
		-- default is false disable move keymap for hyper
		disable_move = false,
		-- shortcut type 'letter' or 'number'
		shortcut_type = 'letter',
		-- default is false, shortcut 'letter' will be randomize, set to false to have ordered letter
		shuffle_letter = false,
		-- default is a-z, excluding j and k
		letter_list = 'abcdefghilmnopqrstuvwxyz',
		-- default is false,for open file in hyper mru. it will change to the root of vcs
		change_to_vcs_root = false,
		-- config used for theme
		config = {
			week_header = {
				enable = true,
				concat = nil,
				append = nil,
			},
			shortcut = {
				{ desc = ' TSUpdate', group = '@property', action = 'TSUpdate', key = 't' },
				{ desc = '󰊳 MasonUpdate', group = '@property', action = 'MasonUpdate', key = 'm' },
				{ desc = ' DepsUpdate', group = '@property', action = 'DepsUpdate', key = 'd' },
				{ desc = '󰿅 Quit', group = '@property', action = 'quit', key = 'q' },
			},
			-- show how many plugins neovim loaded
			packages = { enable = false, },
			project = {
				enable = true,
				limit = 10,
				icon = '',
				label = ' Project',
				action = '',
			},
			mru = {
				enable = true,
				limit = 10,
				icon = '',
				label = ' MRU',
				cwd_only = false,
			},
			-- footer
			footer = {},
		},
		hide = {
			statusline = false,
			tabline = true,
			winbar = false,
		},
		preview = {
			command = '',
			file_path = nil,
			file_height = 0,
			file_width = 0,
		},
	})

end)


--------------------------------------------------------------------------------
-- chentoast/marks.nvim
--------------------------------------------------------------------------------
now(function()

	-- 用于标记位置, 在侧边符号栏显示标记, 方便光标回跳
	add({ source = 'chentoast/marks.nvim', })

	---- 插件使用说明 ----
	--	mx              设置标记x
	--	m,              设置下一个可用的字母（小写）标记
	--	m;              切换当前行上的下一个可用标记
	--	dmx             删除标记x
	--	dm-             删除当前行上所有标记
	--	dm空格          删除当前缓冲区中所有标记
	--	m]              移动到下一个标记
	--	m[              移动到前一个标记
	--	m:              预览标记。这会让你选择要预览的特定标记；按<cr>预览下一个标记。
	--	m[0-9]          添加书签组[0-9]中的书签。
	--	dm[0-9]         删除书签组[0-9]中的所有书签。
	--	m}              移动到与光标下书签同类型的下一个书签。可跨缓冲区工作。
	--	m{              移动到与光标下书签同类型的前一个书签。可跨缓冲区工作。
	--	dm=             删除光标下的书签。
	--
	--	set_next				Set next available lowercase mark at cursor.
	--	toggle					Toggle next available mark at cursor.
	--	delete_line				Deletes all marks on current line.
	--	delete_buf				Deletes all marks in current buffer.
	--	next					Goes to next mark in buffer.
	--	prev					Goes to previous mark in buffer.
	--	preview					Previews mark (will wait for user input). press <cr> to just preview the next mark.
	--	set						Sets a letter mark (will wait for input).
	--	delete					Delete a letter mark (will wait for input).
	--
	--	set_bookmark[0-9]		Sets a bookmark from group[0-9].
	--	delete_bookmark[0-9]	Deletes all bookmarks from group[0-9].
	--	delete_bookmark			Deletes the bookmark under the cursor.
	--	next_bookmark			Moves to the next bookmark having the same type as the
	--							bookmark under the cursor.
	--	prev_bookmark			Moves to the previous bookmark having the same type as the
	--							bookmark under the cursor.
	--	next_bookmark[0-9]		Moves to the next bookmark of the same group type. Works by
	--							first going according to line number, and then according to buffer
	--							number.
	--	prev_bookmark[0-9]		Moves to the previous bookmark of the same group type. Works by
	--							first going according to line number, and then according to buffer
	--							number.
	--	annotate				Prompts the user for a virtual line annotation that is then placed
	--							above the bookmark. Requires neovim 0.6+ and is not mapped by default.
	--

	-- 插件选项自定义配置
	require('marks').setup({
		-- 是否映射键绑定，默认为true
		default_mappings = true,
		-- 要显示的内置标记，默认为空{}
		builtin_marks = { '.', '<', '>', '^' },
		-- 移动时是否循环回缓冲区开头/结尾，默认为true
		cyclic = true,
		-- 修改大写字母标记后是否强制写入shada文件，默认为false
		force_write_shada = false,
		-- 更新标志/重新计算标记位置的频率（毫秒）
		-- 值较高性能会更好但可能造成视觉延迟，
		-- 较低值可能导致性能损失。默认为150。
		refresh_interval = 250,
		-- 每种类型标记的标志优先级 - 内置标记、大写字母、小写字母和书签。
		-- 可以是包含所有或不包含任何键的表，也可以是一个单一数字，这种情况下
		-- 优先级适用于所有标记。
		-- 默认为10。
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
		-- 禁止特定文件类型的标记跟踪。默认为空{}
		excluded_filetypes = {},
		-- 允许你配置最多10个书签组，每组有自己的标志/虚拟文本。
		-- 书签可用于将位置分组并快速在多个缓冲区之间移动。
		-- 默认标志为 "!@#$%^&*()"（从0到9），默认virt_text为空。
		bookmark_1 = {
			sign = '⚑', -- •
			virt_text = '[⚑1]',
			-- 明确提示设置来自该组的书签时输入虚拟行注解。
			-- 默认为false。
			annotate = false,
		},
		bookmark_2 = {
			sign = '', -- 
			virt_text = '[2]',
			annotate = false,
		},
		bookmark_3 = {
			sign = '󰏿', -- 
			virt_text = '[󰏿3]',
			annotate = false,
		},
		bookmark_4 = {
			sign = '󰊕', -- ƒ
			virt_text = '[󰊕4]',
			annotate = false,
		},
		bookmark_5 = {
			sign = '󰀫', --  󰦮 
			virt_text = '[󰀫5]',
			annotate = false,
		},
		bookmark_6 = {
			sign = '', --   
			virt_text = '[ 6]',
			annotate = false,
		},
		bookmark_7 = {
			sign = '', -- 
			virt_text = '[ 7]',
			annotate = false,
		},
		bookmark_8 = {
			sign = '', --  
			virt_text = '[ 8]',
			annotate = false,
		},
		bookmark_9 = {
			sign = '', -- 󰆼
			virt_text = '[ 9]',
			annotate = false,
		},
		bookmark_0 = {
			sign = '', --   
			virt_text = '[ 0]',
			annotate = false,
		},
		mappings = {
			toggle = '`<space>',
			delete_buf = '`<backspace>',
			next = '`]',
			prev = '`[',
			preview = false, -- 传false禁用此默认映射
			next_bookmark1 = ']1',
			prev_bookmark1 = '[1',
			next_bookmark2 = ']2',
			prev_bookmark2 = '[2',
			next_bookmark3 = ']3',
			prev_bookmark3 = '[3',
			next_bookmark4 = ']4',
			prev_bookmark4 = '[4',
			next_bookmark5 = ']5',
			prev_bookmark5 = '[5',
			next_bookmark6 = ']6',
			prev_bookmark6 = '[6',
			next_bookmark7 = ']7',
			prev_bookmark7 = '[7',
			next_bookmark8 = ']8',
			prev_bookmark8 = '[8',
			next_bookmark9 = ']9',
			prev_bookmark9 = '[9',
			next_bookmark0 = ']0',
			prev_bookmark0 = '[0',
			-- Prompts the user for a virtual line annotation that is then placed
			-- above the bookmark. Requires neovim 0.6+ and is not mapped by default.
			--annotate = '`?',
		}
	})

	---- marks.nvim also defines the following commands:
	-- :MarksToggleSigns[ buffer] Toggle signs globally. Also accepts an optional buffer number to toggle signs for that buffer only.
	-- :MarksListBuf Fill the location list with all marks in the current buffer.
	-- :MarksListGlobal Fill the location list with all global marks in open buffers.
	-- :MarksListAll Fill the location list with all marks in all open buffers.
	-- :BookmarksList group_number Fill the location list with all bookmarks of group "group_number".
	-- :BookmarksListAll Fill the location list with all bookmarks, across all groups.
	--
	-- There are also corresponding commands for those who prefer the quickfix list:
	-- :MarksQFListBuf
	-- :MarksQFListGlobal
	-- :MarksQFListAll
	-- :BookmarksQFList group_number
	-- :BookmarksQFListAll

	-- 侧边标记栏是否显示书签符号的开关按键映射
	map({'n', 'v'}, '<tab>M', '<cmd>MarksToggleSigns<cr>', { remap = false, silent = true, })
	map({'n', 'v'}, '<tab>m', ':BookmarksQFList ', { remap = false, silent = false, })
	map({'n', 'v'}, '<tab>L', '<cmd>BookmarksQFListAll<cr>', { remap = false, silent = true, })

end)


--------------------------------------------------------------------------------
-- ggandor/leap.nvim
--------------------------------------------------------------------------------
later(function()

	-- 双字符全屏双向搜索光标跳跃
	add({ source = 'ggandor/leap.nvim', })

	-- 插件选项自定义配置
	--require('leap').create_default_mappings()
	require('leap')

	--[[
	-- default_mappings
	map({'n', 'x', 'o'}, 's', '<Plug>(leap-forward)')
	map({'n', 'x', 'o'}, 'S', '<Plug>(leap-backward)')
	map({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
	--]]

	--Bidirectional s for Normal and Visual mode:
	map({'n', 'x'}, 's', '<Plug>(leap)')
	map('n', 'S', '<Plug>(leap-from-window)')
	map('o', 's', '<Plug>(leap-forward)')
	map('o', 'S', '<Plug>(leap-backward)')

	--[[
	-- Jump to anywhere in Normal mode with one key:
	map('n', 's', '<Plug>(leap-anywhere)')
	map('x', 's', '<Plug>(leap)')
	map('o', 's', '<Plug>(leap-forward)')
	map('o', 'S', '<Plug>(leap-backward)')
	--]]

	-- Define equivalence classes for brackets and quotes, in addition to
	-- the default whitespace group:
	require('leap').opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`', }

	-- Use the traversal keys to repeat the previous motion without
	-- explicitly invoking Leap:
	--require('leap.user').set_repeat_keys('<space>', '<backspace>')

	-- Define a preview filter (skip the middle of alphanumeric words):
	require('leap').opts.preview_filter = function(ch0, ch1, ch2)
		return not (
			ch1:match('%s') or
			ch0:match('%w') and ch1:match('%w') and ch2:match('%w')
		)
	end

	--[[
	-- Incremental treesitter node selection
	map({'n', 'x', 'o'}, 'ga',
		function ()
			require('leap.treesitter').select()
		end
	)
	-- Linewise
	map({'n', 'x', 'o'}, 'gA', 'V<cmd>lua require("leap.treesitter").select()<cr>')
	--]]

	-- Disable auto-jumping to the first match
	require('leap').opts.safe_labels = {}

	--Disable previewing labels
	--require('leap').opts.preview_filter = function () return false end

	-- Greying out the search area
	-- if Comment is saturated.
	--api.nvim_set_hl(0, 'LeapBackdrop', { link = 'Comment' })
	-- Or just set to grey directly, e.g. { fg = '#777777' },
	--api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#777777' })
	-- highlight label keyword
	--api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#ee0000' })

	-- Make the text invisible, and uses the colorscheme background color.
	local secondary_hl = api.nvim_get_hl(0, { name = 'LeapLabelSecondary' } )
	api.nvim_set_hl(0, 'LeapLabelSecondary', {
		fg = secondary_hl.bg,
		bg = secondary_hl.bg,
	})

	-- 在使用 vscode 色彩主题样式插件时突出显示
	if package.loaded['vscode'] then
		api.nvim_set_hl(0, 'LeapBackdrop', { fg = '#777777' })
		api.nvim_set_hl(0, 'LeapLabelPrimary', { fg = '#ee0000' })
	end

end)


--------------------------------------------------------------------------------
-- numToStr/Comment.nvim
--------------------------------------------------------------------------------
now(function()

	-- 代码注释, 支持 treesitter
	add({ source = 'numToStr/Comment.nvim', })

	-- 插件选项自定义配置
	require('Comment').setup({
		---Add a space b/w comment and the line
		padding = false,
		---Whether the cursor should stay at its position
		sticky = true,
		---Lines to be ignored while (un)comment
		ignore = nil,
		-- ignores empty lines
		--ignore = '^$',
		-- only ignore empty lines for lua files
		--ignore = function()
		--	if vim.bo.filetype == 'lua' then
		--		return '^$'
		--	end
		--end,
		---LHS of toggle mappings in NORMAL mode
		toggler = {
			---Line-comment toggle keymap, default `gcc`
			line = 'gcc',
			---Block-comment toggle keymap, default `gbc`
			block = 'gbc',
		},
		---LHS of operator-pending mappings in NORMAL and VISUAL mode
		opleader = {
			---Line-comment keymap
			line = 'gc',
			---Block-comment keymap
			block = 'gb',
		},
		---LHS of extra mappings
		extra = {
			---Add comment on the line above, default `gcO`
			above = 'gcO',
			---Add comment on the line below, default `gco`
			below = 'gco',
			---Add comment at the end of line, default `gcA`
			eol = 'gcA',
		},
		---Enable keybindings
		---NOTE: If given `false` then the plugin won't create any mappings
		mappings = {
			---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
			basic = true,
			---Extra mapping; `gco`, `gcO`, `gcA`
			extra = true,
		},
		---Function to call before (un)comment
		pre_hook = nil,
		---Function to call after (un)comment
		post_hook = nil,
	})

	-- 自定义文件类型的注释
	local ft = require('Comment.ft')

	-- 1. Using set function
	-- Set only line comment
	--ft.set('yaml', '#%s')
	-- Or set both line and block commentstring
	--ft.set('javascript', {'//%s', '/*%s*/'})

	-- 2. Metatable magic
	--ft.javascript = {'//%s', '/*%s*/'}
	--ft.yaml = '#%s'

	-- 3. Multiple filetypes
	--ft({'go', 'rust'}, ft.get('c'))
	--ft({'toml', 'graphql'}, '#%s')

	ft({'gitconfig', 'gitcommit'}, '#%s')

end)


--------------------------------------------------------------------------------
-- ojroques/nvim-osc52
--------------------------------------------------------------------------------
-- nvim 0.10.x 以后的版本已经内嵌支持 ANSI OSC52 控制序列码
--later(function()
--
--	-- 使 nvim 支持 ANSI OSC52 控制序列码, 实现跨 ssh 复制文本
--	add({
--		source = 'ojroques/nvim-osc52',
--	})
--
--	require('osc52').setup {
--		max_length = 0,           -- Maximum length of selection (0 for no limit)
--		silent = false,           -- Disable message on successful copy
--		trim = false,             -- Trim surrounding whitespaces before copy
--		tmux_passthrough = false, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
--	}
--
--	-- to automatically copy text that was yanked into register +
--	function copy()
--		if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
--			require('osc52').copy_register('+')
--		end
--	end
--	vim.api.nvim_create_autocmd('TextYankPost', {callback = copy})
--
--	-- use the plugin as your clipboard provider, see :h provider-clipboard for more details.
--	local function copy(lines, _)
--		require('osc52').copy(table.concat(lines, '\n'))
--	end
--	local function paste()
--		return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
--	end
--	vim.g.clipboard = {
--		name = 'osc52',
--		copy = {['+'] = copy, ['*'] = copy},
--		paste = {['+'] = paste, ['*'] = paste},
--	}
--	-- Now the '+' register will copy to system clipboard using OSC52
--	map('n', '<leader>c', '"+y')
--	map('n', '<leader>cc', '"+yy')
--
--end)


--------------------------------------------------------------------------------
-- akinsho/toggleterm.nvim
--------------------------------------------------------------------------------
now(function()

	-- 终端会话管理器
	add({
		source = 'akinsho/toggleterm.nvim',
	})

	-- 插件选项自定义配置
	require('toggleterm').setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == 'horizontal' then
				return 15
			elseif term.direction == 'vertical' then
				return math.floor(vim.o.columns * 0.45)
			end
		end,

		open_mapping = { '<m-`>', },
		-- on_open = function(terminal)
		-- 	local win = teminal:window
		-- 	vim.api.nvim_win_set_option(win, 'localdir', vim.fn.getcwd())
		-- end,
		-- on_close = function(terminal)
		-- 	--local win = terminal:window
		-- 	vim.api.nvim_win_set_option(win, 'localdir', '')
		-- end,
		-- on_exit = function(terminal, exitcode)
		-- 	print('Exited with code: ' .. exitcode)
		-- end,

		-- hide the number column in toggleterm buffers
		hide_numbers = true,
		-- when neovim changes it current directory the terminal will change it's own when next it's opened
		autochdir = false,
		-- highlights which map to a highlight group name and a table of it's values
		-- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
		highlights = {
			--Normal = { guibg = '<VALUE-HERE>'},
			NormalFloat = { link = 'Normal', },
			--FloatBorder = { guifg = '<VALUE_HERE>', guibg = 'VALUE-HERE', },
		},

		-- NOTE: this option takes priority over highlights specified
		-- so if you specify Normal highlights you should set this to false
		shade_terminals = true,
		--shade_filetypes = { 'none', 'fzf', }
		-- the percentage by which to lighten dark terminal background, default: -30
		shading_factor = -30,
		-- the ratio of shading factor for light/dark terminal background, default: -3
		shading_ratio = -3,

		start_in_insert = true,
		-- whether or not the open mapping applies in insert mode
		insert_mappings = true,
		-- whether or not the open mapping applies in the opened terminals
		terminal_mappings = true,

		-- if set to true (default) the previous terminal mode will be remembered
		persist_mode = true,
		persist_size = true,

		-- `vertical`,`horizontal`,`tab`,`float`
		direction = 'float',
		-- close the terminal window when the process exits
		close_on_exit = true,
		-- use only environmental variables from `env`, passed to jobstart()
		clear_env = false,

		-- Change the default shell. Can be a string or a function returning a string
		shell = vim.o.shell,
		-- automatically scroll to the bottom on terminal output
		auto_scroll = true,

			-- This field is only relevant if direction is set to 'float'
		float_opts = {
			-- The border key is *almost* the same as 'nvim_open_win'
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			-- 'single' | 'double' | 'shadow' | 'curved' | 'rounded' | 'solid' | 'none'
			-- other options supported by win open
			border = 'none',
			-- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
			width = math.floor(vim.o.columns),
			height = math.floor(vim.o.lines * 0.45),
			row = 1,
			col = 1,
			anchor = 'NW',
			winblend = 10,
			zindex = 50,
			--title_pos = 'left' | 'center' | 'right', position of the title of the floating window
			--relative = 'editor',
			close_on_esc = true,
		},
		winbar = {
			enabled = false,
			name_formatter = function(term) -- term: Terminal
				return term.name
			end
		},
		responsiveness = {
			-- breakpoint in terms of `vim.o.columns` at which terminals will start to stack on top of each other
			-- instead of next to each other
			-- default = 0 which means the feature is turned off
			horizontal_breakpoint = 0,
		},
	})

	-- if you want mappings for all term use `term://* lua ...` instead
	-- if you only want mappings for toggle term use `term://*toggleterm#* lua ...` instead

	--[[
	local terminal = require('toggleterm.terminal').Terminal
	local leftabove = terminal:new({
		cmd = 'zsh',
		hidden = true,
		direction = 'horizontal'
	})
	function leftabove_toggle()
		leftabove:toggle()
	end
	map({'','!'}, '<m-`>', cmd('lua leftabove_toggle()'), { remap = false, silent = true, })
	--]]

end)


--------------------------------------------------------------------------------
-- nvim-telescope/telescope.nvim
--------------------------------------------------------------------------------
now(function()

	-- fzf, fuzzyfind 模糊搜索
	add({
		source = 'nvim-telescope/telescope.nvim',
		checkout = '0.1.x',
		depends = { 'nvim-lua/plenary.nvim' },
	})

	-- 不预览二进制文件
	local previewers = require('telescope.previewers')
	local job = require('plenary.job')
	local ignore_binary_maker = function(filepath, bufnr, opts)
		filepath = fn.expand(filepath)
		job:new({
			command = 'file',
			args = { '--mime-type', '-b', filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], '/')[1]
				if mime_type == 'text' then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'BINARY' })
					end)
				end
			end
		}):sync()
	end

	-- 插件选项自定义配置
	local actions = require('telescope.actions')
	local sorters = require('telescope.sorters')
	local action_layout = require('telescope.actions.layout')
	require('telescope').setup({
		defaults = {
			--entry_prefix = ' ',
			prompt_prefix = '󰭎 ',
			selection_caret = '► ',
			--initial_mode = 'insert',
			winblend = 10,
			-- 使用 mini.fuzzy 优化排序
			generic_sorter = require('mini.fuzzy').get_telescope_sorter,
			sorting_strategy = 'descending',
			layout_strategy = 'vertical',
			-- 使用 ripgrep 过滤器
			vimgrep_arguments = {
				'rg',
				'--color=never',
				'--no-heading',
				'--with-filename',
				'--line-number',
				'--column',
				'--smart-case',
				'--trim', -- add this value
			},
			-- 忽略二进制文件
			buffer_previewer_maker = ignore_binary_maker,
			preview = {
				-- 预览限制文件尺寸
				filesize_limit = 0.256, -- MB
			},

			---- Default Mappings
			-- Mappings     	Action
			-- <C-n>/<Down> 	Next item
			-- <C-p>/<Up>   	Previous item
			-- j/k          	Next/previous (in normal mode)
			-- H/M/L        	Select High/Middle/Low (in normal mode)
			-- gg/G         	Select the first/last item (in normal mode)
			-- <CR>         	Confirm selection
			-- <C-x>        	Go to file selection as a split
			-- <C-v>        	Go to file selection as a vsplit
			-- <C-t>        	Go to a file in a new tab
			-- <C-u>        	Scroll up in preview window
			-- <C-d>        	Scroll down in preview window
			-- <C-f>        	Scroll left in preview window
			-- <C-k>        	Scroll right in preview window
			-- <M-f>        	Scroll left in results window
			-- <M-k>        	Scroll right in results window
			-- <C-/>        	Show mappings for picker actions (insert mode)
			-- ?            	Show mappings for picker actions (normal mode)
			-- <C-c>        	Close telescope (insert mode)
			-- <Esc>        	Close telescope (in normal mode)
			-- <Tab>        	Toggle selection and move to next selection
			-- <S-Tab>      	Toggle selection and move to prev selection
			-- <C-q>        	Send all items not filtered to quickfixlist (qflist)
			-- <M-q>        	Send all selected items to qflist
			-- <C-r><C-w>   	Insert cword in original window into prompt (insert mode)
			-- <C-r><C-a>   	Insert cWORD in original window into prompt (insert mode)
			-- <C-r><C-f>   	Insert cfile in original window into prompt (insert mode)
			-- <C-r><C-l>   	Insert cline in original window into prompt (insert mode)
			----
			-- 空值按键映射均会被默认按键映射覆盖
			-- 去除对应功能, 释放键位映射, 减少按键冲突
			mappings = {
				i = {
					-- 默认按键重新映射功能, `false`表示停用功能解除映射释放键位
					['<c-n>'] = false,
					['<c-p>'] = false,

					['<c-c>'] = actions.close,

					['<down>'] = actions.move_selection_next,
					['<up>'] = actions.move_selection_previous,

					['<cr>'] = actions.select_tab,
					['<c-x>'] = false,
					['<c-v>'] = false,
					['<c-t>'] = false,

					['<c-u>'] = false,
					['<c-d>'] = false,

					['<pageup>'] = actions.results_scrolling_up,
					['<pagedown>'] = actions.results_scrolling_down,

					['<tab>'] = actions.toggle_selection + actions.move_selection_worse,
					['<s-tab>'] = actions.toggle_selection + actions.move_selection_better,
					['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
					['<m-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
					['<c-l>'] = actions.complete_tag,
					['<c-/>'] = actions.which_key,
					['<c-_>'] = actions.which_key, -- keys from pressing <C-/>
					['<c-w>'] = { '<c-s-w>', type = 'command' },

					-- disable c-j because we dont want to allow new lines #2123
					['<c-j>'] = false,

					-- 默认功能重新映射按键
					['<m-pageup>'] = actions.preview_scrolling_up,
					['<m-pagedown>'] = actions.preview_scrolling_down,

					-- 添加其他按键映射
					--['<esc>'] = actions.close,
					['<m-p>'] = action_layout.toggle_preview,
					-- Mapping <C-s>/<C-a> to cycle previewer for git commits to show full message
					--['c-n'] = actions.cycle_history_next,
					--['c-p'] = actions.cycle_history_prev,
				},
				n = {
					-- 重新映射默认按键
					['<esc>'] = actions.close,
					['<cr>'] = actions.select_tab,
					['<c-x>'] = false,
					['<c-v>'] = false,
					['<c-t>'] = false,

					['<tab>'] = actions.toggle_selection + actions.move_selection_worse,
					['<s-tab>'] = actions.toggle_selection + actions.move_selection_better,
					['<c-q>'] = actions.send_to_qflist + actions.open_qflist,
					['<m-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

					['j'] = false,
					['k'] = false,
					['H'] = false,
					['M'] = false,
					['L'] = false,

					['<down>'] = actions.move_selection_next,
					['<up>'] = actions.move_selection_previous,
					['gg'] = actions.move_to_top,
					['G'] = actions.move_to_bottom,

					['<c-u>'] = false,
					['<c-d>'] = false,

					['<pageup>'] = actions.results_scrolling_up,
					['<pagedown>'] = actions.results_scrolling_down,

					['?'] = actions.which_key,

					-- 默认功能重新映射按键
					['sp'] = actions.select_horizontal,
					['vs'] = actions.select_vertical,

					['<m-pageup>'] = actions.preview_scrolling_up,
					['<m-pagedown>'] = actions.preview_scrolling_down,

					-- 添加其他按键映射
					['<m-p>'] = action_layout.toggle_preview,
					['<space>'] = actions.toggle_selection,
					['T'] = actions.toggle_all,
					['S'] = actions.select_all,
					['D'] = actions.drop_all,
					['q'] = actions.send_selected_to_qflist + actions.open_qflist,
					['Q'] = actions.send_to_qflist + actions.open_qflist,
				},
			},
		},
		pickers = {
			find_files = {
				-- Remove `./` from `fd` results
				--find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
				-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
				--find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
				-- `dropdown`,`cursor`,`ivy`
				theme = nil,
			},
		},
	})

	-- 判断项目 git 目录树
	local function is_git_tree()
		fn.system('git rev-parse --is-inside-work-tree')
		return vim.v.shell_error == 0
	end
	-- 获取项目 git 目录树根路径
	local function get_git_root()
		local dot_git_path = fn.finddir('.git', '.;')
		return fn.fnamemodify(dot_git_path, ':h')
	end

	---- 按键映射绑定 ----
	local builtin = require('telescope.builtin')

	-- file pickers --
	-- 基于git工作树根路径, 但不包括隐藏及忽略的查找
	map('', '<leader>ff', function()
		local opts = {}
		if is_git_tree() then
			opts.cwd = get_git_root()
		end
		-- 若是git目录树则基于项目根路径查找, 否则基于当前路径查找
		builtin.find_files(opts)
	end, { desc = 'Lists files in your current working directory, respects .gitignore' })
	-- 基于文件当前路径, 且包括隐藏及忽略的查找
	map('', '<leader>fF', function()
		local opts = { hidden = true, no_ignore = true, }
		--if is_git_tree() then
		--	opts.cwd = get_git_root()
		--end
		-- 若是git工作树则基于项目根路径查找, 否则基于当前路径查找
		builtin.find_files(opts)
	end, { desc = 'Lists files in your current working directory, respects .gitignore' })
	-- 基于git工作树根路径, 但不包括隐藏及忽略的过滤
	map('', '<leader>fg', function()
		local opts = {}
		if is_git_tree() then
			opts.cwd = get_git_root()
		end
		-- 若是git工作树则基于项目根路径过滤, 否则基于当前路径过滤
		builtin.live_grep(opts)
	end, { desc = 'Search for a string in your current working directory and get results live as you type, respects .gitignore. (Requires ripgrep)' })
	-- 基于当前文件路径, 且包括隐藏及忽略的过滤
	map('', '<leader>fG', function()
		local default_word = fn.expand('<cword>')
		vim.ui.input({ prompt = 'Search: ', default = default_word }, function(input)
			if input and input ~= '' then
				local opts = { search = input, additional_args = { '--hidden', '--no-ignore', }, }
				--if is_git_tree() then
				--	opts.cwd = get_git_root()
				--end
				-- 若是git目录树则基于项目根路径搜索, 否则基于当前路径搜索
				builtin.grep_string(opts)
			end
		end)
	end, { desc = 'Searches for the string under your cursor or selection in your current working directory' })

	-- vim pickers --
	map('', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = 'Live fuzzy search inside of the currently open buffer' })
	map('', '<leader>fH', builtin.help_tags, { desc = 'Lists available help tags and opens a new window with the relevant help info on <cr>' })
	map('', '<leader>fm', builtin.marks, { desc = 'Lists vim marks and their value' })
	map('', '<leader>fM', builtin.man_pages, { desc = 'Lists manpage entries, opens them in a help window on <cr>' })
	map('', '<leader>fq', builtin.quickfix, { desc = 'Lists items in the quickfix list' })
	map('', '<leader>fQ', builtin.quickfixhistory, { desc = 'Lists all quickfix lists in your history and open them with builtin.quickfix or quickfix window' })
	map('', '<leader>fl', builtin.loclist, { desc = 'Lists items from the current window location list' })
	map('', '<leader>fj', builtin.jumplist, { desc = 'Lists Jump List entries' })

	-- lsp pickers --
	map('', '<leader>fd', function()
		builtin.diagnostics({ bufnr = 0 })
	end, { desc = 'Lists Diagnostics for current buffer.' })
	map('', '<leader>fD', builtin.diagnostics, { desc = 'Lists Diagnostics for all open buffers.' })

	-- treesitter picker --
	map('', '<leader>ft', builtin.treesitter, { desc = 'Lists Function names, variables, from Treesitter!' })

	-- git pickers --
	map('', '<leader>fC', function()
		local opts = {}
		if is_git_tree() then
			builtin.git_commits(opts)
		else
			vim.notify('Not a git work tree', vim.log.levels.ERROR)
		end
	end, { desc = 'Lists git commits with diff preview, checkout action <cr>, reset mixed <C-r>m, reset soft <C-r>s and reset hard <C-r>h' })
	map('', '<leader>fc', function()
		local opts = {}
		if is_git_tree() then
			builtin.git_bcommits(opts)
		else
			vim.notify('Not a git work tree', vim.log.levels.ERROR)
		end
	end, { desc = 'Lists buffer git commits with diff preview and checks them out on <cr>' })
	map('', '<leader>fs', function()
		local opts = {}
		if is_git_tree() then
			builtin.git_status(opts)
		else
			vim.notify('Not a git work tree', vim.log.levels.ERROR)
		end
	end, { desc = 'Lists current changes per file with diff preview and add action. (Multi-selection still WIP)' })
	map('', '<leader>fS', function()
		local opts = {}
		if is_git_tree() then
			builtin.git_stash(opts)
		else
			vim.notify('Not a git work tree', vim.log.levels.ERROR)
		end
	end, { desc = 'Lists stash items in current repository with ability to apply them on <cr>' })

end)


--------------------------------------------------------------------------------
-- kevinhwang91/nvim-bqf
--------------------------------------------------------------------------------
later(function()

	-- 功能强大的 quickfix 列表窗口
	add({
		source = 'kevinhwang91/nvim-bqf',
	})

	-- 插件选项自定义配置
	require('bqf').setup({
		auto_enable = true,
		magic_window = true,
		-- Resize quickfix window height automatically.
		-- Shrink higher height to size of list in quickfix window, otherwise extend height
		-- to size of list or to default height (10), default `false`
		auto_resize_height = true,
		preview = {
			auto_preview = true,
			border = 'single',
			show_title = true,
			show_scroll_bar = true,
			delay_syntax = 50,
			-- The height of preview window for horizontal layout,
			-- large value (like 999) perform preview window as a "full" mode
			win_height = 15,
			-- The height of preview window for vertical layout
			win_vheight = 15,
			winblend = 12,
			wrap = false,
			buf_label = true,
			should_preview_cb = function(bufnr, qwinid)
				local ret = true
				local bufname = api.nvim_buf_get_name(bufnr)
				local fsize = fn.getfsize(bufname)
				if fsize > 256 * 1024 then
					-- skip file size greater than 256k
					ret = false
				elseif bufname:match('^fugitive://') then
					-- skip fugitive buffer
					ret = false
				end
				return ret
			end,
		},

		----			Function Table: Action and Default Key
		-- Function    	Action                                                   	Def Key
		-- open        	open the item under the cursor                           	<CR>
		-- openc       	open the item, and close quickfix window                 	o
		-- drop        	use drop to open the item, and close quickfix window     	O
		-- tabdrop     	use tab drop to open the item, and close quickfix window
		-- tab         	open the item in a new tab                               	t
		-- tabb        	open the item in a new tab, but stay in quickfix window  	T
		-- tabc        	open the item in a new tab, and close quickfix window    	<C-t>
		-- split       	open the item in horizontal split                        	<C-x>
		-- vsplit      	open the item in vertical split                          	<C-v>
		-- prevfile    	go to previous file under the cursor in quickfix window  	<C-p>
		-- nextfile    	go to next file under the cursor in quickfix window      	<C-n>
		-- prevhist    	cycle to previous quickfix list in quickfix window       	<
		-- nexthist    	cycle to next quickfix list in quickfix window           	>
		-- lastleave   	go to last selected item in quickfix window              	'"
		-- stoggleup   	toggle sign and move cursor up                           	<S-Tab>
		-- stoggledown 	toggle sign and move cursor down                         	<Tab>
		-- stogglevm   	toggle multiple signs in visual mode                     	<Tab>
		-- stogglebuf  	toggle signs for same buffers under the cursor           	'<Tab>
		-- sclear      	clear the signs in current quickfix list                 	z<Tab>
		-- pscrollup   	scroll up half-page in preview window                    	<C-b>
		-- pscrolldown 	scroll down half-page in preview window                  	<C-f>
		-- pscrollorig 	scroll back to original position in preview window       	zo
		-- ptogglemode 	toggle preview window between normal and max size        	zp
		-- ptoggleitem 	toggle preview for a quickfix list item                  	p
		-- ptoggleauto 	toggle auto-preview when cursor moves                    	P
		-- filter      	create new list for signed items                         	zn
		-- filterr     	create new list for non-signed items                     	zN
		-- fzffilter   	enter fzf mode                                           	zf
		----

		func_map = {
			open = '<cr>',
			openc = 'o',
			drop = 'O',
			tabdrop = '',
			tab = 't',
			tabb ='T',
			tabc = '',
			split = 'sp',
			vsplit = 'vs',
			prevfile = '[f',
			nextfile = ']f',
			prevhist = '<',
			nexthist = '>',
			lastleave = '\'"',
			stoggleup = '<backspace>',
			stoggledown = '<space>',
			stogglevm = '<space>',
			stogglebuf = '\'<space>',
			sclear = '\'<backspace>',
			pscrollup = '',
			pscrolldown = '',
			pscrollrig = '',
			ptogglemode = 'P',
			ptoggleitem = 'p',
			ptoggleauto = '',
			filter = '\'f',
			filterr = '\'F',
			fzffilter = '',
		},

		-- 去除 fzf 过滤器功能, 释放键位映射, 减少按键冲突
		filter = {
			fzf = {
				[''] = 'tabedit', -- default ['ctrl-t']
				[''] = 'vssplit', -- default ['ctrl-v']
				[''] = 'split', -- default ['ctrl-x']
				[''] = 'signtoggle', -- defualt ['ctrl-q']
				[''] = 'closeall', -- default ['ctrl-c']
			},
			extra_opts = {'--bind', 'ctrl-p:toggle-all'}
		}
	})

end)


--------------------------------------------------------------------------------
-- stevearc/quicker.nvim
--------------------------------------------------------------------------------
--[[
later(function()

	-- 简洁实用的 quickfix 窗口
	add({
		source = 'stevearc/quicker.nvim',
	})

	-- 插件选项自定义配置
	require('quicker').setup({
		-- Local options to set for quickfix
		opts = {
			buflisted = false,
			number = true,
			relativenumber = true,
			signcolumn = 'auto',
			winfixheight = true,
			wrap = false,
		},
		-- Set to false to disable the default options in `opts`
		use_default_opts = true,
		-- Keymaps to set for the quickfix buffer
		keys = {
			{ '>', function()
				require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
			end, desc = 'Expand quickfix context', },
			{ '<', function()
					require('quicker').collapse()
			end, desc = 'Collapse quickfix context', },
		},
		-- Callback function to run any custom logic or keymaps for the quickfix buffer
		on_qf = function(bufnr) end,
		edit = {
			-- Enable editing the quickfix like a normal buffer
			enabled = true,
			-- Set to true to write buffers after applying edits.
			-- Set to 'unmodified' to only write unmodified buffers.
			autosave = 'unmodified',
		},
		-- Keep the cursor to the right of the filename and lnum columns
		constrain_cursor = true,
		highlight = {
			-- Use treesitter highlighting
			treesitter = true,
			-- Use LSP semantic token highlighting
			lsp = true,
			-- Load the referenced buffers to apply more accurate highlights (may be slow)
			load_buffers = false,
		},
		follow = {
			-- When quickfix window is open, scroll to closest item to the cursor
			enabled = false,
		},
		-- Map of quickfix item type to icon
		type_icons = {
			E = '󰅚 ',
			W = '󰀪 ',
			I = ' ',
			N = ' ',
			H = ' ',
		},
		-- Border characters
		borders = {
			--[[
			vert = '┃',
			-- Strong headers separate results from different files
			strong_header = '━',
			strong_cross = '╋',
			strong_end = '┫',
			-- Soft headers separate results within the same file
			soft_header = '╌',
			soft_cross = '╂',
			soft_end = '┨',
			] ]--
			vert = '│',
			strong_header = '─',
			strong_cross = '┼',
			strong_end = '┤',
			soft_header = '─',
			soft_cross = '┼',
			soft_end = '┤',
		},
		-- How to trim the leading whitespace from results. Can be 'all', 'common', or false
		trim_leading_whitespace = 'common',
		-- Maximum width of the filename column
		max_filename_width = function()
			return math.floor(math.min(95, vim.o.columns / 2))
		end,
		-- How far the header should extend to the right
		header_length = function(type, start_col)
			return vim.o.columns - start_col
		end,
	})

	map('', '<tab>q', function()
		require('quicker').toggle({ min_height = 5, max_height = 15 })
	end, { desc = 'Toggle quickfix', })
	map('', '<tab>l', function()
		require('quicker').toggle({ loclist = true, min_height = 5, max_height = 15 })
	end, { desc = 'Toggle loclist', })

end)
--]]


--------------------------------------------------------------------------------
-- nvim-treesitter/nvim-treesitter
-- JoosepAlviste/nvim-ts-context-commentstring
--------------------------------------------------------------------------------
later(function()

	-- 代码语法解析树生成器
	add({
		source = 'nvim-treesitter/nvim-treesitter',
		-- Use 'master' while monitoring updates in 'main'
		--checkout = 'master',
		--monitor = 'main',
		-- Perform action after every checkout
		hooks = { post_checkout = function() cmd('TSUpdate') end },
	})

	-- Possible to immediately execute code which depends on the added plugin
	require('nvim-treesitter.configs').setup({
		-- A list of parser names, or 'all' (the listed parsers MUST always be installed)
		ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = false,

		-- List of parsers to ignore installing (or "all")
		ignore_install = { 'all' },

		---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
		-- parser_install_dir = '/some/path/to/store/parsers', -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

		-- 语法高亮
		highlight = {
			enable = true,

			-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
			-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
			-- the name of the parser)
			-- list of language that will be disabled
			--disable = { 'c', 'rust' },
			-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
			disable = function(lang, buf)
				local max_filesize = 256 * 1024 -- 256 KB
				local ok, stats = pcall(vim.loop.fs_stat, api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},

		-- 增量选择
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = '<space>', -- set to `false` to disable one of the mappings
				node_incremental = '<space>',
				scope_incremental = '<enter>',
				node_decremental = '<backspace>',
			},
		},

		-- 文本对象
		textobjects = {
			enable = false,
		},

		-- 自动缩进
		-- Indentation based on treesitter for the = operator.
		-- NOTE: This is an experimental feature.
		indent = {
			enable = false,
		},
	})

	-- 对比差异时关闭 treesitter 折叠表达式方法
	if not vim.opt.diff then
		-- 代码折叠方法
		vim.opt.foldmethod = 'expr'
		-- 代码折叠表达式
		vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	end

	-- 始终使用 mini.comment 自定义注释`字符串`
	-- always use buffer 'commentstring' even in case of present active tree-sitter parser.
	--require('mini.comment').setup({
	--	options = {
	--		custom_commentstring = function() return vim.bo.commentstring end,
	--	},
	--})

	-- the .h/.hpp filetype will use the c/cpp parser and queries.
	--vim.treesitter.language.register('c', '.h')
	--vim.treesitter.language.register('cpp', '.hpp')

	---- 多语言代码混合编程需要 ----

	-- 基于代码语法解析树上下文的代码注释字符串生成器
	add({
		source = 'JoosepAlviste/nvim-ts-context-commentstring',
	})

	-- 禁用内置注释, 启用解析树上下文代码注释字符串
	require('ts_context_commentstring').setup {
		enable_autocmd = false,
	}
	-- 使用 mini.comment 注释器
	--require('mini.comment').setup {
	--	options = {
	--		custom_commentstring = function()
	--			return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
	--		end,
	--	},
	--}
	-- 使用 Comment.nvim 注释器
	require('Comment').setup({
		pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
	})

end)


--------------------------------------------------------------------------------
-- williamboman/mason.nvim
--------------------------------------------------------------------------------
later(function()

	-- LSP, DAP, linter, formatter 代码语言服务管理器
	add({
		source = 'williamboman/mason.nvim',
		depends = {
			'williamboman/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',
		},
		-- Perform action after every checkout
		hooks = { post_checkout = function() cmd('MasonUpdate') end },
	})

	require('mason').setup({
		---@since 1.0.0
		-- The directory in which to install packages.
		--install_root_dir = path.concat { vim.fn.stdpath 'data', 'mason' },

		---@since 1.0.0
		-- Where Mason should put its bin location in your PATH. Can be one of:
		-- - "prepend" (default, Mason's bin location is put first in PATH)
		-- - "append" (Mason's bin location is put at the end of PATH)
		-- - "skip" (doesn't modify PATH)
		---@type '"prepend"' | '"append"' | '"skip"'
		PATH = 'prepend',

		---@since 1.0.0
		-- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
		-- debugging issues with package installations.
		log_level = vim.log.levels.INFO,

		---@since 1.0.0
		-- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
		-- packages that are requested to be installed will be put in a queue.
		max_concurrent_installers = 4,

		---@since 1.0.0
		-- [Advanced setting]
		-- The registries to source packages from. Accepts multiple entries. Should a package with the same name exist in
		-- multiple registries, the registry listed first will be used.
		registries = {
			'github:mason-org/mason-registry',
		},

		---@since 1.0.0
		-- The provider implementations to use for resolving supplementary package metadata (e.g., all available versions).
		-- Accepts multiple entries, where later entries will be used as fallback should prior providers fail.
		-- Builtin providers are:
		--   - mason.providers.registry-api  - uses the https://api.mason-registry.dev API
		--   - mason.providers.client        - uses only client-side tooling to resolve metadata
		providers = {
			'mason.providers.registry-api',
			'mason.providers.client',
		},

		github = {
			---@since 1.0.0
			-- The template URL to use when downloading assets from GitHub.
			-- The placeholders are the following (in order):
			-- 1. The repository (e.g. "rust-lang/rust-analyzer")
			-- 2. The release version (e.g. "v0.3.0")
			-- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
			download_url_template = 'https://github.com/%s/releases/download/%s/%s',
		},

		pip = {
			---@since 1.0.0
			-- Whether to upgrade pip to the latest version in the virtual environment before installing packages.
			upgrade_pip = false,

			---@since 1.0.0
			-- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
			-- and is not recommended.
			--
			-- Example: { '--proxy', 'https://proxyserver' }
			install_args = {},
		},

		ui = {
			---@since 1.0.0
			-- Whether to automatically check for new versions when opening the :Mason window.
			check_outdated_packages_on_open = true,

			---@since 1.0.0
			-- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
			border = 'none',

			---@since 1.11.0
			-- The backdrop opacity. 0 is fully opaque, 100 is fully transparent.
			backdrop = 60,

			---@since 1.0.0
			-- Width of the window. Accepts:
			-- - Integer greater than 1 for fixed width.
			-- - Float in the range of 0-1 for a percentage of screen width.
			width = 0.8,

			---@since 1.0.0
			-- Height of the window. Accepts:
			-- - Integer greater than 1 for fixed height.
			-- - Float in the range of 0-1 for a percentage of screen height.
			height = 0.9,

			icons = {
				---@since 1.0.0
				-- The list icon to use for installed packages.
				--package_installed = '◍',
				package_installed = '✓',
				---@since 1.0.0
				-- The list icon to use for packages that are installing, or queued for installation.
				--package_pending = '◍',
				package_pending = '➜',
				---@since 1.0.0
				-- The list icon to use for packages that are not installed.
				--package_uninstalled = '◍',
				package_uninstalled = '✗',
			},

			keymaps = {
				---@since 1.0.0
				-- Keymap to expand a package
				toggle_package_expand = '<cr>',
				---@since 1.0.0
				-- Keymap to install the package under the current cursor position
				install_package = 'i',
				---@since 1.0.0
				-- Keymap to reinstall/update the package under the current cursor position
				update_package = 'u',
				---@since 1.0.0
				-- Keymap to check for new version for the package under the current cursor position
				check_package_version = 'c',
				---@since 1.0.0
				-- Keymap to update all installed packages
				update_all_packages = 'U',
				---@since 1.0.0
				-- Keymap to check which installed packages are outdated
				check_outdated_packages = 'C',
				---@since 1.0.0
				-- Keymap to uninstall a package
				uninstall_package = 'X',
				---@since 1.0.0
				-- Keymap to cancel a package installation
				cancel_installation = '<C-c>',
				---@since 1.0.0
				-- Keymap to apply language filter
				apply_language_filter = '<C-f>',
				---@since 1.1.0
				-- Keymap to toggle viewing package installation log
				toggle_package_install_log = '<CR>',
				---@since 1.8.0
				-- Keymap to toggle the help view
				toggle_help = 'g?',
			},
		},
	})

	require('mason-lspconfig').setup({
		-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
		-- This setting has no relation with the `automatic_installation` setting.
		---@type string[]
		ensure_installed = {},

		-- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
		-- This setting has no relation with the `ensure_installed` setting.
		-- Can either be:
		--   - false: Servers are not automatically installed.
		--   - true: All servers set up via lspconfig are automatically installed.
		--   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
		--       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
		---@type boolean
		automatic_installation = false,

		-- See `:h mason-lspconfig.setup_handlers()`
		---@type table<string, fun(server_name: string)>?
		handlers = nil,
	})

end)


--------------------------------------------------------------------------------
-- j-hui/fidget.nvim
--------------------------------------------------------------------------------

later(function()

	-- 有历史记录且简洁的消息通知管理器
	-- Extensible UI for Neovim notifications and LSP progress messages
	add({
		source = 'j-hui/fidget.nvim',
	})

	-- 插件选项自定义配置
	require('fidget').setup({

		-- Options related to LSP progress subsystem
		progress = {
			poll_rate = 0,                -- How and when to poll for progress messages
			suppress_on_insert = false,   -- Suppress new messages while in insert mode
			ignore_done_already = false,  -- Ignore new tasks that are already complete
			ignore_empty_message = false, -- Ignore new tasks that don't contain a message
			clear_on_detach =             -- Clear notification group when LSP server detaches
			function(client_id)
				local client = vim.lsp.get_client_by_id(client_id)
				return client and client.name or nil
			end,
			notification_group =          -- How to get a progress message's notification group key
			function(msg) return msg.lsp_client.name end,
			ignore = {},                  -- List of LSP servers to ignore

			-- Options related to how LSP progress messages are displayed as notifications
			display = {
				render_limit = 16,          -- How many LSP messages to show at once
				done_ttl = 3,               -- How long a message should persist after completion
				done_icon = '✔',            -- Icon shown when all LSP progress tasks are complete
				done_style = 'Constant',    -- Highlight group for completed LSP tasks
				progress_ttl = math.huge,   -- How long a message should persist when in progress
				progress_icon =             -- Icon shown when LSP progress tasks are in progress
				{ 'dots' },
				progress_style =            -- Highlight group for in-progress LSP tasks
				'WarningMsg',
				group_style = 'Title',      -- Highlight group for group name (LSP server name)
				icon_style = 'Question',    -- Highlight group for group icons
				priority = 30,              -- Ordering priority for LSP notification group
				skip_history = true,        -- Whether progress notifications should be omitted from history
				format_message =            -- How to format a progress message
				require('fidget.progress.display').default_format_message,
				format_annote =             -- How to format a progress annotation
				function(msg) return msg.title end,
				format_group_name =         -- How to format a progress notification group's name
				function(group) return tostring(group) end,
				overrides = {               -- Override options from the default notification config
					rust_analyzer = { name = 'rust-analyzer' },
				},
			},

			-- Options related to Neovim's built-in LSP client
			lsp = {
				progress_ringbuf_size = 0,  -- Configure the nvim's LSP progress ring buffer size
				log_handler = false,        -- Log `$/progress` handler invocations (for debugging)
			},
		},

		-- Options related to notification subsystem
		notification = {
			poll_rate = 10,               -- How frequently to update and render notifications
			filter = vim.log.levels.INFO, -- Minimum notifications level
			history_size = 128,           -- Number of removed messages to retain in history
			override_vim_notify = false,  -- Automatically override vim.notify() with Fidget
			configs =                     -- How to configure notification groups when instantiated
			{ default = require('fidget.notification').default_config },
			redirect =                    -- Conditionally redirect notifications to another backend
			function(msg, level, opts)
				if opts and opts.on_open then
					return require('fidget.integration.nvim-notify').delegate(msg, level, opts)
				end
			end,

			-- Options related to how notifications are rendered as text
			view = {
				stack_upwards = true,       -- Display notification items from bottom to top
				icon_separator = ' ',       -- Separator between group name and icon
				group_separator = '---',    -- Separator between notification groups
				group_separator_hl =        -- Highlight group used for group separator
				'Comment',
				render_message =            -- How to render notification messages
				function(msg, cnt)
					return cnt == 1 and msg or string.format('(%dx) %s', cnt, msg)
				end,
			},

			-- Options related to the notification window and buffer
			window = {
				normal_hl = 'Comment',      -- Base highlight group in the notification window
				winblend = 100,             -- Background color opacity in the notification window
				border = 'none',            -- Border around the notification window
				zindex = 45,                -- Stacking priority of the notification window
				max_width = 0,              -- Maximum width of the notification window
				max_height = 0,             -- Maximum height of the notification window
				x_padding = 1,              -- Padding from right edge of window boundary
				y_padding = 0,              -- Padding from bottom edge of window boundary
				align = 'bottom',           -- How to align the notification window
				relative = 'editor',        -- What the notification window position is relative to
			},
		},

		-- Options related to integrating with other plugins
		integration = {
			['nvim-tree'] = {
				enable = true,              -- Integrate with nvim-tree/nvim-tree.lua (if installed)
			},
			['xcodebuild-nvim'] = {
				enable = true,              -- Integrate with wojciech-kulik/xcodebuild.nvim (if installed)
			},
		},

		-- Options related to logging
		logger = {
			level = vim.log.levels.WARN,  -- Minimum logging level
			max_size = 10000,             -- Maximum log file size, in KB
			float_precision = 0.01,       -- Limit the number of decimals displayed for floats
			path =                        -- Where Fidget writes its logs to
			string.format('%s/fidget.nvim.log', vim.fn.stdpath('cache')),
		},
	})

	require('telescope').load_extension('fidget')
	-- After load extension, we can open the Fidget picker using the command
	-- :Telescope fidget, or via the Lua API
	map('', '<leader>fh', require('telescope').extensions.fidget.fidget, { desc = 'Lists notifications from Fidget!' })

	-- 作为默认消息通知管理器
	vim.notify = require('fidget').notify

end)


--------------------------------------------------------------------------------
-- rcarriga/nvim-notify
--------------------------------------------------------------------------------
--[[
later(function()

	-- 有历史记录且被广泛支持的消息通知管理器
	-- A fancy, configurable, notification manager for NeoVim
	add({
		source = 'rcarriga/nvim-notify',
	})

	-- 插件选项自定义配置
	require('notify').setup({
		level = vim.log.levels.INFO,
		timeout = 3000,
		max_width = nil,
		max_height = nil,
		stages = 'fade_in_slide_out',
		render = 'default',
		background_colour = 'NotifyBackground',
		on_open = nil,
		on_close = nil,
		minimum_width = 30,
		fps = 30,
		top_down = true,
		merge_duplicates = true,
		time_formats = {
			notification_history = '%FT%T',
			notification = '%T',
		},
		icons = {
			ERROR = '',
			WARN = '',
			INFO = '',
			DEBUG = '',
			TRACE = '✎',
		},
	})

	-- 作为默认消息通知管理器
	vim.notify = require('notify')

end)
--]]


--------------------------------------------------------------------------------
-- MunifTanjim/nui.nvim
--------------------------------------------------------------------------------
--[[
later(function()

	-- 用户接口组件库
	-- UI Component Library for Neovim.
	add({
		source = 'MunifTanjim/nui.nvim',
	})

end)
--]]


--------------------------------------------------------------------------------
-- folke/noice.nvim
--------------------------------------------------------------------------------
--[[
later(function()

	-- 深度魔改 neovim 操作界面
	-- replaces the UI for messages, cmdline and the popupmenu
	add({
		source = 'folke/noice.nvim',
		depends = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		},
	})

	-- 插件选项自定义配置
	require('noice').setup({
		cmdline = {
			-- enables the Noice cmdline UI
			enabled = true,
			-- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
			view = 'cmdline_popup',
			-- global options for the cmdline. See section on views
			opts = {},
			---@type table<string, CmdlineFormat>
			format = {
				-- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
				-- view: (default is cmdline view)
				-- opts: any options passed to the view
				-- icon_hl_group: optional hl_group for the icon
				-- title: set to anything or empty string to hide
				cmdline = { pattern = '^:', icon = '', lang = 'vim', title = ' CMDLINE ' },
				search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
				search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
				filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
				lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
				help = { pattern = '^:%s*he?l?p?%s+', icon = '󰋖' },
				-- Used by input()
				input = { view = 'cmdline_input', icon = '󰥻 ' },
				-- to disable a format, set to `false`
				-- lua = false,
			},
		},
		messages = {
			-- NOTE: If you enable messages, then the cmdline is enabled automatically.
			-- This is a current Neovim limitation.
			-- enables the Noice messages UI
			enabled = true,
			-- default view for messages
			view = 'notify',
			-- view for errors
			view_error = 'notify',
			-- view for warnings
			view_warn = 'notify',
			-- view for :messages
			view_history = 'messages',
			-- view for search count messages. Set to `false` to disable
			view_search = 'virtualtext',
		},
		popupmenu = {
			-- enables the Noice popupmenu UI
			enabled = true,
			---@type 'nui'|'cmp'
			-- backend to use to show regular cmdline completions
			backend = 'nui',
			---@type NoicePopupmenuItemKind|false
			-- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
			-- set to `false` to disable icons
			kind_icons = {},
			-- Display the Cmdline and Popupmenu Together
			relative = 'editor', -- "'cursor'"|"'editor'"|"'win'"
			position = {
				row = 'auto', -- Popup will show up below the cmdline automatically
				col = 'auto',
			},
			size = {
				width = '75%', -- Making this as wide as the cmdline_popup
				height = 'auto',
			},
			border = {
				style = 'single',
				padding = { 0, 1 },
			},
			win_options = {
				--winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
				winhightlight = {
					Normal = 'NoicePopupmenu', -- Normal | NoicePopupmenu
					FloatBorder = 'NoicePopupmenuBorder', -- DiagnosticInfo | NoicePopupmenuBorder
					CursorLine = 'NoicePopupmenuSelected',
					PmenuMatch = 'NoicePopupmenuMatch',
				},
			},
		},
		-- default options for require('noice').redirect
		-- see the section on Command Redirection
		---@type NoiceRouteConfig
		redirect = {
			view = 'popup',
			filter = { event = 'msg_show' },
		},
		-- You can add any custom commands below that will be available with `:Noice command`
		---@type table<string, NoiceCommand>
		commands = {
			history = {
				-- options for the message history that you get with `:Noice`
				view = 'split',
				opts = { enter = true, format = 'details' },
				filter = {
					any = {
						{ event = 'notify' },
						{ error = true },
						{ warning = true },
						{ event = 'msg_show', kind = { '' } },
						{ event = 'lsp', kind = 'message' },
					},
				},
			},
			-- :Noice last
			last = {
				view = 'popup',
				opts = { enter = true, format = 'details' },
				filter = {
					any = {
						{ event = 'notify' },
						{ error = true },
						{ warning = true },
						{ event = 'msg_show', kind = { '' } },
						{ event = 'lsp', kind = 'message' },
					},
				},
				filter_opts = { count = 1 },
			},
			-- :Noice errors
			errors = {
				-- options for the message history that you get with `:Noice`
				view = 'popup',
				opts = { enter = true, format = 'details' },
				filter = { error = true },
				filter_opts = { reverse = true },
			},
			all = {
				-- options for the message history that you get with `:Noice`
				view = 'split',
				opts = { enter = true, format = 'details' },
				filter = {},
			},
		},
		notify = {
			-- Noice can be used as `vim.notify` so you can route any notification like other messages
			-- Notification messages have their level and other properties set.
			-- event is always "notify" and kind can be any log level as a string
			-- The default routes will forward notifications to nvim-notify
			-- Benefit of using Noice for this is the routing and consistent history view
			enabled = false,
			view = 'notify',
		},
		lsp = {
			progress = {
				enabled = true,
				-- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
				-- See the section on formatting for more details on how to customize.
				--- @type NoiceFormat|string
				format = 'lsp_progress',
				--- @type NoiceFormat|string
				format_done = 'lsp_progress_done',
				throttle = 1000 / 30, -- frequency to update lsp progress message
				view = 'mini',
			},
			override = {
				-- override the default lsp markdown formatter with Noice
				['vim.lsp.util.convert_input_to_markdown_lines'] = false,
				-- override the lsp markdown formatter with Noice
				['vim.lsp.util.stylize_markdown'] = false,
				-- override cmp documentation with Noice (needs the other options to work)
				['cmp.entry.get_documentation'] = false,
			},
			hover = {
				enabled = true,
				-- set to true to not show a message if hover is not available
				silent = false,
				-- when nil, use defaults from documentation
				view = nil,
				---@type NoiceViewOptions
				-- merged with defaults from documentation
				opts = {},
			},
			signature = {
				enabled = true,
				auto_open = {
					enabled = true,
					-- Automatically show signature help when typing a trigger character from the LSP
					trigger = true,
					-- Will open signature help when jumping to Luasnip insert nodes
					luasnip = true,
					-- Debounce lsp signature help request by 50ms
					throttle = 50,
				},
				-- when nil, use defaults from documentation
				view = nil,
				---@type NoiceViewOptions
				-- merged with defaults from documentation
				opts = {},
			},
			message = {
				-- Messages shown by lsp servers
				enabled = true,
				view = 'notify',
				opts = {},
			},
			-- defaults for hover and signature help
			documentation = {
				view = 'hover',
				---@type NoiceViewOptions
				opts = {
					lang = 'markdown',
					replace = true,
					render = 'plain',
					format = { '{message}' },
					win_options = { concealcursor = 'n', conceallevel = 3 },
				},
			},
		},
		markdown = {
			hover = {
				-- vim help links
				['|(%S-)|'] = vim.cmd.help,
				-- markdown links
				['%[.-%]%((%S-)%)'] = require('noice.util').open,
			},
			highlights = {
				['|%S-|'] = '@text.reference',
				['@%S+'] = '@parameter',
				['^%s*(Parameters:)'] = '@text.title',
				['^%s*(Return:)'] = '@text.title',
				['^%s*(See also:)'] = '@text.title',
				['{%S-}'] = '@parameter',
			},
		},
		health = {
			-- Disable if you don't want health checks to run
			checker = true,
		},
		---@type NoicePresets
		presets = {
			-- you can enable a preset by setting it to true, or a table that will override the preset config
			-- you can also add custom presets that you can enable/disable with enabled=true
			-- use a classic bottom cmdline for search
			bottom_search = true,
			-- position the cmdline and popupmenu together
			command_palette = true,
			-- long messages will be sent to a split
			long_message_to_split = true,
			-- enables an input dialog for inc-rename.nvim
			inc_rename = false,
			-- add a border to hover docs and signature help
			lsp_doc_border = false,
		},
		-- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
		throttle = 1000 / 30,
		---@type NoiceConfigViews
		---@see section on views
		views = {
			cmdline_popup = {
				backend = 'popup',
				relative = 'editor',
				zindex = 200,
				position = {
					row = '50%',
					col = '50%',
				},
				size = {
					width = '75%',
					height = 'auto',
				},
				border = {
					style = 'single',
					padding = { 0, 1 },
				},
				win_options = {
					--winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
					winhighlight = {
						Normal = 'NoiceCmdlinePopup',
						FloatTitle = 'NoiceCmdlinePopupTitle',
						FloatBorder = 'NoiceCmdlinePopupBorder',
						IncSearch = '',
						CurSearch = '',
						Search = '',
					},
					winbar = '',
					foldenable = false,
					cursorline = false,
				},
			},
		},
		---@type NoiceRouteConfig[]
		---@see section on routes
		routes = {
			-- only show @recording messages as notify messages
			--{ filter = { event = 'msg_showmode', }, view = 'notify', },

			-- Avoid written messages
			{ filter = { event = 'msg_show', any = {
				{ find = '%d+L, %d+B' },
				{ find = '; after #%d+' },
				{ find = '; before #%d+' },
				{ find = '%d fewer lines' },
				{ find = '%d more lines' },
			}, }, opts = { skip = true }, },

			-- skip search_count messages instead of showing them as virtual text
			--{ filter = { event = 'msg_show', kind = 'search_count' }, opts = { skip = true }, },

			-- reroute long notifications to splits
			{ filter = { event = 'notify', min_height = 15 }, view = 'split', },

			-- always route any messages with more than 15 lines to the split view
			--{ filter = { event = 'msg_show', min_height = 15 }, view = 'split', },
		},
		---@type table<string, NoiceFilter>
		---@see section on statusline components
		status = {},
		---@type NoiceFormatOptions
		---@see section on formatting
		format = {
			-- level = {
			-- 	icons = {
			-- 		error = '✖',
			-- 		warn = '▼',
			-- 		info = '●',
			-- 	},
			-- },
		},
		-- inc_rename = {
		-- 	cmdline = {
		-- 		format = {
		-- 			IncRename = { icon = '⟳' },
		-- 		},
		-- 	},
		-- },
	})

	require('telescope').load_extension('noice')

end)
--]]


