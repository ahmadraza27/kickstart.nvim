return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  -- # this is for nvim tree
  --
  --
  --
  -- Existing plugins
  { 'nvim-tree/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  rocks = {
    enabled = false, -- Disable luarocks support
  },
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signs_staged = {
        add = { text = '+┃' },
        change = { text = '~┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.r
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  -- LSP Plugins
  {
    -- `lazydev` configures lua lsp for your neovim config, runtime and plugins
    -- used for completion, annotations and signatures of neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configurationcmd
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependantsrequire lse
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- Brief aside: **What is LSP?**lsp config
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Correctly checking for supported methods
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          if client then
            -- Handle document highlighting if supported
            if client.supports_method 'textDocument/documentHighlight' then
              local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
              vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(event2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                end,
              })
            end

            -- Handle inlay hints if supported
            if client.supports_method 'textDocument/inlayHint' then
              map('<leader>th', function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
              end, '[T]oggle Inlay [H]ints')
            end
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      -- if vim.g.have_nerd_font then
      --   local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
      --   local diagnostic_signs = {}
      --   for type, icon in pairs(signs) do
      --     diagnostic_signs[vim.diagnostic.severity[type]] = icon
      --   end
      --   vim.diagnostic.config { signs = { text = diagnostic_signs } }
      -- end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = { mason = false },
        --
        clangd = {

          cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
          format = {
            tabSize = 4,
            insertSpaces = true, -- Use spaces instead of tabs
          },
          init_options = {

            fallbackFlags = {
              '-std=c++20',
              '-I' .. vim.fn.getcwd() .. '/include',
              '-I' .. vim.fn.getcwd() .. '/src',
              '-I' .. vim.fn.getcwd() .. '/bin',
            },
          },
        },
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --
        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }
      -- local lspconfig = require('lspconfig')
      -- lspconfig.clangd.setup({
      --     cmd = { 'clangd', '--background-index', '--clang-tidy', '--log=verbose' },
      --     init_options = {
      --         fallbackFlags = {
      --             '-std=c++17',  -- C++ version flag
      --             '-I./include', -- Relative include directory, assuming 'include' is in the project root
      --             '-I./src',     -- Another relative include directory
      --         },
      --     },
      -- })
      -- Set up NvimTree

      -- INFO: this is for nvim tree
      -- require("nvim-tree").setup({
      -- 	view = {
      -- 		width = 30, -- Width of the tree window
      -- 		number = true, -- Enable absolute line numbers
      -- 		relativenumber = true, -- Enable relative line numbers
      -- 	},
      -- 	renderer = {
      -- 		highlight_opened_files = "all", -- Highlight opened files in the tree
      -- 		root_folder_modifier = ":~", -- Show ~ for the root directory
      -- 	},
      -- 	diagnostics = {
      -- 		enable = true, -- Show diagnostics in the tree
      -- 		icons = {
      -- 			hint = "",
      -- 			info = "",
      -- 			warning = "",
      -- 			error = "",
      -- 		},
      -- 	},
      -- })
      --

      -- require("nvim-tree").setup({
      --   view = {
      --     width = 30,                               -- Width of the tree window
      --     number = true,                            -- Enable absolute line numbers
      --     relativenumber = true,                    -- Enable relative line numbers
      --     side = "left",                            -- Place the tree on the left side
      --     -- mappings = {
      --     --   custom_only = false,                    -- Allow custom mappings
      --     --   list = {
      --     --     { key = { "<CR>", "o" }, action = "edit" }, -- Open file action
      --     --     { key = "u",             action = "dir_up" }, -- Navigate up a directory
      --     --   },
      --     -- },
      --   },
      --   renderer = {
      --     highlight_opened_files = "all", -- Highlight opened files in the tree
      --     root_folder_modifier = ":~", -- Show ~ for the root directory
      --     -- icons = {
      --     --   default = "", -- Default file icon
      --     --   symlink = "", -- Symlink file icon
      --     --   git = {
      --     --     unstaged = "✗", -- Unstaged files
      --     --     staged = "✓", -- Staged files
      --     --     untracked = "★", -- Untracked files
      --     --     ignored = "◌", -- Ignored files
      --     --   },
      --     --   folder = {
      --     --     arrow_open = "", -- Open folder arrow icon
      --     --     arrow_closed = "", -- Closed folder arrow icon
      --     --   },
      --     -- },
      --   },
      --   diagnostics = {
      --     enable = true, -- Show diagnostics in the tree
      --     icons = {
      --       hint = "", -- Hint icon
      --       info = "", -- Info icon
      --       warning = "", -- Warning icon
      --       error = "", -- Error icon
      --     },
      --   },
      --   -- git = {
      --   --   enable = true, -- Enable Git status in the file tree
      --   --   ignore = false, -- Show all files including gitignored ones
      --   -- },
      --   -- modified = {
      --   --   enable = true, -- Show file modified status
      --   --   show_on_dirs = true, -- Show modified status on directories as well
      --   -- },
      --   -- update_focused_file = {
      --   --   enable = true, -- Automatically update the focused file
      --   --   update_cwd = true, -- Update the working directory in the tree when the file is focused
      --   -- },
      --   -- filters = {
      --   --   dotfiles = false, -- Show dotfiles
      --   --   custom = {}, -- Add custom filters if needed
      --   -- },
      --   -- live_filter = {
      --   --   prefix = "Live Filter: ", -- Prefix for live filtering
      --   --   always_show = false, -- Show live filter at all times
      --   -- },
      -- })
      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          'rafamadriz/friendly-snippets', -- Predefined snippets for various languages
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline', -- Add completion for cmdline
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      luasnip.config.setup {
        history = true,
        updateevents = 'TextChanged,TextChangedI', -- Update snippet on text change
      }

      -- Configure nvim-cmp
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Expanding snippets
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert', -- More completion options
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },

        sources = {
          { name = 'nvim_lsp' }, -- LSP-based completions
          { name = 'luasnip' }, -- Snippets from LuaSnip
          { name = 'path' }, -- File path completion
          { name = 'cmdline' }, -- Cmdline completion (important for `:`, `/`, etc.)
        },
      }

      -- cmp.setup.cmdline(':', {
      --   sources = {
      --     { name = 'path' }, -- Path completion (e.g., file paths)
      --     { name = 'cmdline' }, -- Native cmdline completion
      --     { name = 'nvim_lsp' }, -- LSP-based completion
      --   },
      -- })
      --
      -- cmp.setup.cmdline('/', {
      --   sources = {
      --     { name = 'buffer' }, -- Buffer completion for `/` search
      --   },
      -- })
      -- Setup for command-line mode completion
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --color
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.color
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    transparent = true,
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      vim.cmd.colorscheme 'tokyonight-night'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' }, -- You may need this for file type icons
    config = function()
      require('bufferline').setup {
        options = {
          -- numbers = "ordinal",                                                                      -- Show buffer numbers as ordinals
          diagnostics = 'nvim_lsp', -- Enable LSP diagnostics
          offsets = { { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory' } }, -- Optional: Custom offset for NvimTree
          show_buffer_close_icons = false, -- Optional: Disable close icons
          separator_style = 'slant', -- Optional: Style of the separator
          enforce_regular_tabs = false, -- Optional: Keep tabs regular
        },
      }
    end,
  },

  {
    'famiu/bufdelete.nvim',
    config = function()
      vim.api.nvim_set_keymap('n', '<C-q>', ':Bdelete<CR>', { noremap = true, silent = true })
    end,
  },
  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Automatically update parsers
    opts = {
      ensure_installed = { 'bash', 'cpp', 'python', 'lua' }, -- List of languages to install
      highlight = {
        enable = true, -- Enable tree-sitter based highlighting
      },
      indent = {
        enable = true, -- Enable tree-sitter based indentation
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<TAB>',
          node_decremental = '<S-TAB>',
          scope_incremental = '<C-Space>',
        },
      },
    },
  },
  -- Flutter tools
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required dependency
      'stevearc/dressing.nvim', -- Optional dependency for better UI
      'mfussenegger/nvim-dap', -- Debugging protocol
      'rcarriga/nvim-dap-ui', -- Debugging UI
      'theHamsta/nvim-dap-virtual-text', -- Virtual text for debugging
    },
    config = function()
      require('flutter-tools').setup {
        ui = {
          border = 'rounded',
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          },
        },
        lsp = {
          color = { enabled = true },
          on_attach = function(client, bufnr)
            -- Key mappings for LSP
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
          end,
        },
        debugger = {
          enabled = true, -- Enable Flutter debugger
          run_via_dap = true, -- Use nvim-dap for debugging
        },
      }

      -- Debugging UI configuration
      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()
    end,
  },
  -- Tree-sitter context plugin
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
    opts = {
      enable = true, -- Enable the plugin
      max_lines = 5, -- Maximum number of lines to show for context
      trim_scope = 'outer', -- Trims the outermost context if max_lines is exceeded
      patterns = { -- Match patterns for context
        default = {
          'class',
          'function',
          'method',
          'for',
          'while',
          'if',
          'switch',
          'case',
        },
      },
      zindex = 20, -- Z-index of the context window
      mode = 'cursor', -- Line used to calculate context (cursor or topline)
      separator = nil, -- Separator between context and the rest of the buffer
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()

      -- Remap Ctrl+K to toggle comment for the current line
      vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { noremap = true, silent = true })
    end,
  },
  {
    'tyru/current-func-info.vim',
    config = function()
      -- Configuration to echo the current function name when pressing Ctrl+g followed by 'f'
      vim.api.nvim_set_keymap('n', '<C-g>f', ':echo cfi#format("%s", "")<CR>', { noremap = true, silent = true })

      -- Alternatively, to show the current function name on the statusline:
      vim.o.statusline = vim.o.statusline .. ' [%{cfi#format("%s", "")}]'
    end,
  },

  -- lazy.nvim configuration
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true, -- Enable Treesitter integration
        fast_wrap = {},
      }
    end,
  },

  { 'nvim-neotest/nvim-nio' },
  -- 1. DAP Core
  -- Install nvim-dap
  {
    'mfussenegger/nvim-dap',
    config = function()
      -- Set DAP log level to TRACE for debugging purposes
      require('dap').set_log_level 'TRACE'

      -- configuration for dart
      -- Dart debugger configuration
      require('dap').adapters.dart = {
        type = 'executable',
        command = 'dart',
        args = { 'debug_adapter' },
      }

      require('dap').configurations.dart = {
        {
          type = 'dart',
          request = 'launch',
          name = 'Launch Dart Program',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }

      -- Flutter-specific configuration
      require('dap').configurations.flutter = {
        {
          type = 'dart',
          request = 'launch',
          name = 'Launch Flutter App',
          program = '${workspaceFolder}/lib/main.dart',
          cwd = '${workspaceFolder}',
          toolArgs = { '-d', 'linux' }, -- Change `linux` to your device (e.g., `chrome`, `emulator`, etc.)
        },
      }
      -- 1. Configure the DAP adapter for Clang and LLDB
      require('dap').adapters.lldb = {
        type = 'executable',
        command = '/usr/bin/lldb', -- Ensure the correct path to lldb
        name = 'lldb',
      }

      -- 2. Configure the launch configuration for C++ with LLDB
      require('dap').configurations.cpp = {
        {
          name = 'Launch Program',
          type = 'lldb', -- Use lldb for C++ debugging
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}', -- Working directory
          stopAtEntry = false, -- Stop at entry point? (set to true to stop at main)
          args = {}, -- Program arguments
          setupCommands = {
            {
              text = '-enable-pretty-printing', -- Enable pretty printing
              description = 'Enable pretty printing',
              ignoreFailures = false,
            },
          },
          miDebuggerPath = '/usr/bin/lldb', -- Path to lldb
          externalConsole = false, -- Set to true for an external console
        },
      }

      -- Install nvim-dap-ui
      require('rcarriga/nvim-dap-ui').setup {
        controls = {
          -- element = "repl", -- Default is "console", change it to "repl" for a better experience
        },
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.25 },
              { id = 'watches', size = 0.25 },
              { id = 'breakpoints', size = 0.25 },
              -- { id = "stack",       size = 0.25 },
            },
            position = 'right',
            size = 40,
          },
        },
      }

      -- Automatically open the UI when debugging starts
      vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error', linehl = '', numhl = '' })

      -- Automatically open the UI when debugging starts
      require('dap').listeners.after['event_initialized']['dapui_config'] = function()
        require('dapui').open()
      end

      -- Automatically close the UI when debugging ends
      require('dap').listeners.before['event_terminated']['dapui_config'] = function()
        require('dapui').close()
      end
    end,
  },

  -- Install Telescope DAP Extension
  {
    'nvim-telescope/telescope-dap.nvim',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('telescope').load_extension 'dap'

      -- Keymaps for Telescope DAP integration
      vim.api.nvim_set_keymap('n', '<Leader>dd', ':Telescope dap list_breakpoints<CR>', { noremap = true, silent = true, desc = 'List Breakpoints' })
      vim.api.nvim_set_keymap('n', '<Leader>de', ':Telescope dap expressions<CR>', { noremap = true, silent = true, desc = 'Evaluate Expressions' })
      vim.api.nvim_set_keymap('n', '<Leader>dh', ':Telescope dap frames<CR>', { noremap = true, silent = true, desc = 'View Call Stack' })
    end,
  },

  -- Install Virtual Text for inline Debugging Information
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('nvim-dap-virtual-text').setup()
    end,
  },

  -- Install Language-specific DAP Adapters (For C++)
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'williamboman/mason.nvim', -- Ensure you have Mason installed
      'mfussenegger/nvim-dap',
    },
    config = function()
      -- Ensure DAP adapters are installed automatically for selected languages
      require('mason-nvim-dap').setup {
        ensure_installed = { 'cppdbg' }, -- C++ Debugger
      }
    end,
  },

  -- 6. C++ DAP Configuration
  -- {
  --   config = function()
  --     local dap = require('dap')
  --
  --     -- Configure gdb for C++
  --     dap.adapters.gdb = {
  --       type = 'executable',
  --       command = '/usr/bin/gdb', -- Make sure the path to gdb is correct
  --       name = "gdb",
  --     }
  --
  --     -- C++ launch configuration for gdb
  --     dap.configurations.cpp = {
  --       {
  --         name = "Launch Program",
  --         type = "gdb", -- Use "gdb" instead of "cppdbg"
  --         request = "launch",
  --         program = function()
  --           return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
  --         end,
  --         cwd = '${workspaceFolder}',
  --         stopAtEntry = false,
  --         args = {}, -- Add any arguments for your program here
  --         setupCommands = {
  --           {
  --             text = '-enable-pretty-printing',
  --             description = 'Enable pretty printing',
  --             ignoreFailures = false
  --           }
  --         },
  --         miDebuggerPath = '/usr/bin/gdb', -- Path to gdb
  --         externalConsole = false,       -- Set to true if you want an external console
  --       }
  --     }
  --   end
  -- },
  {
    'MunifTanjim/nui.nvim', -- Required for the modern UI
  },

  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- Enable hover documentation in Noice
        hover = {
          enabled = true,
          view = 'hover', -- Use the hover view for LSP documentation
          opts = {}, -- Pass additional options for hover handling
        },
        -- Signature help settings
        signature = {
          enabled = true,
          auto_open = {
            enabled = true,
            throttle = 30, -- Throttle time in milliseconds
          },
        },
        -- Enable LSP message handling
        message = {
          enabled = true, -- Enable message handling
          view = 'mini', -- Use a minimal view for messages
          opts = {}, -- Optional customization for messages
        },
      },
      -- Additional Noice settings for enhanced UI
      presets = {
        bottom_search = true, -- Use a command-line for search
        command_palette = true, -- Enable a command palette
        long_message_to_split = true, -- Send long messages to a split
        inc_rename = true, -- Enable incremental renaming
        lsp_doc_border = true, -- Add a border to hover documentation
      },
    },
    dependencies = {
      'MunifTanjim/nui.nvim', -- Dependency for Noice's UI
      'rcarriga/nvim-notify', -- Notification plugin (optional but recommended)
    },
  },

  -- Noice plugin for enhanced UI
  -- {
  --   'folke/noice.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     lsp = {
  --       -- Enable hover documentation in Noice
  --       hover = {
  --         enabled = true,
  --         view = 'hover', -- Use the hover view for LSP documentation
  --         opts = {}, -- Pass additional options for hover handling
  --       },
  --       -- Signature help settings
  --       signature = {
  --         enabled = true,
  --         auto_open = {
  --           enabled = true,
  --           throttle = 50, -- Throttle time in milliseconds
  --         },
  --       },
  --       -- Message settings
  --       message = {
  --         enabled = false,
  --       },
  --     },
  --     -- Additional Noice settings for enhanced UI
  --     presets = {
  --       bottom_search = true, -- Use a command-line for search
  --       command_palette = true, -- Enable a command palette
  --       long_message_to_split = true, -- Send long messages to a split
  --       inc_rename = true, -- Enable incremental renaming
  --       lsp_doc_border = true, -- Add a border to hover documentation
  --     },
  --   },
  --   dependencies = {
  --     'MunifTanjim/nui.nvim', -- Dependency for Noice's UI
  --     'rcarriga/nvim-notify', -- Notification plugin (optional but recommended)
  --   },
  -- },

  -- Lazy.nvim setup for neo-tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- Required for neo-tree
      'kyazdani42/nvim-web-devicons', -- Optional for file icons
    },
    config = function()
      -- Neo-tree configuration
      require('neo-tree').setup {
        filesystem = {
          filtered_items = {
            hide_dotfiles = false, -- Show dotfiles
            hide_gitignored = false, -- Show git-ignored files
          },
        },
        window = {
          width = 30, -- Width of the neo-tree window
        },
        git_status = {
          symbols = {
            added = '✚', -- Git added
            modified = '', -- Git modified
            deleted = '', -- Git deleted
            renamed = '➔', -- Git renamed
          },
        },
        event_handlers = {
          {
            event = 'file_opened',
            handler = function()
              vim.cmd 'set relativenumber'
            end,
          },
          {
            event = 'file_closed',
            handler = function()
              vim.cmd 'set norelativenumber'
            end,
          },
        },
      }
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'tokyonight', -- Choose your preferred theme
          section_separators = '',
          component_separators = '|',
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = {
            'filename',
            {
              function()
                local ts_utils = require 'nvim-treesitter.ts_utils'
                local node = ts_utils.get_node_at_cursor()
                while node do
                  local type = node:type()
                  if type == 'function_definition' or type == 'method_definition' or type == 'class_definition' then
                    return require('nvim-treesitter.query').get_node_text(node, 0) or ''
                  end
                  node = node:parent()
                end
                return ''
              end,
              icon = 'ƒ', -- Optional: Add a function icon
            },
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      }
    end,
  },

  {
    'Yggdroot/indentLine',
    config = function()
      vim.g.indentLine_char = '|' -- Character for indent lines
      vim.g.indentLine_fileTypeExclude = { 'help', 'dashboard', 'packer', 'NvimTree' }
      vim.g.indentLine_bufTypeExclude = { 'terminal', 'nofile' }
    end,
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}
