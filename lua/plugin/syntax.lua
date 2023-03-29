return {
  -- treesitter {{{
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'julia',
          'python',
          'org',
          'bash',
          'lua',
          'markdown',
          'markdown_inline',
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'markdown' },
        },
        incremental_selection = { enable = false },
        indent = { enable = false },
      })
    end
  }, -- }}}
  -- org {{{
  {
    'nvim-orgmode/orgmode',
    ft = 'org',
    keys = {',oa', ',oc'},
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      -- Treesitter configuration
      require('orgmode').setup_ts_grammar()
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'org' },
        },
        ensure_installed = { 'org' },
      }

      -- Orgmode configuration
      require('orgmode').setup(
        {
          -- Sources
          org_agenda_files = {
            '/home/carlos/agenda/agenda.org',
            '/home/carlos/agenda/refile.org',
            '/home/carlos/agenda/journal.org',
            '/home/carlos/agenda/calendar/*',
          },
          org_default_notes_file = '/home/carlos/agenda/refile.org',
          -- Quality-of-life
          org_agenda_templates = {
            c = {
              description = 'Capture',
              template = '* %?\n%u',
              target = '~/zk/agenda/refile.org',
            },
            a = {
              description = 'Agenda',
              template = '* %?\n%t',
              target = '~/zk/agenda/agenda.org',
            },
            j = {
              description = 'Journal',
              template = '** %?',
              target = '~/zk/agenda/journal.org',
            },
          },
          org_indent_mode = 'noindent',
          org_blank_before_new_entry = { heading = false, plain_list_item = false },
          org_hide_emphasis_markers = true,
          org_hide_leading_stars = true,
          -- Agenda
          org_agenda_skip_scheduled_if_done = true,
          org_agenda_skip_deadline_if_done = true,
          org_agenda_span = 'month',
          win_split_mode = 'auto',
          org_todo_keywords = {
            'TODO(t)', 'DOING(.)', 'WAITING(w)',
            '|',
            'DELEGATED(e)', 'DONE(d)', 'CANCELED(x)'
          },
          org_todo_keyword_faces = {
            TODO = ':foreground #ec5f67',
            DOING = ':foreground #ECBE7B',
            DONE = ':foreground #98be65',
            WAITING = ':foreground #008080',
            DELEGATED = ':foreground #464d72',
            CANCELED = ':foreground #464d72'
          },
          -- Notifications
          notifications = { enabled = true },
          -- Settings
          mappings = {
            org = {
              org_meta_return = "<S-CR>",
            },
          }
        }
      )

      -- Colors
      vim.cmd [[
          function! s:orgmode_colors() abort
          hi link OrgTSTimestampActive OrgTSComment
          hi link OrgTSTimestampInactive OrgTSComment
          " hi OrgTSBullet
          " hi OrgTSPropertyDrawer
          " hi OrgTSDrawer
          hi link OrgTSTag DiffChanged
          hi link OrgTSPlan OrgTSComment
          " hi OrgTSComment
          hi link OrgTSLatex DiffAdd
          " hi OrgTSDirective
          " hi OrgTSCheckbox
          " hi OrgTSCheckboxChecked
          " hi OrgTSCheckboxHalfChecked
          " hi OrgTSCheckboxUnchecked
          " hi OrgTSHeadlineLevel1
          " hi OrgTSHeadlineLevel2
          " hi OrgTSHeadlineLevel3
          " hi OrgTSHeadlineLevel4
          " hi OrgTSHeadlineLevel5
          " hi OrgTSHeadlineLevel6
          " hi OrgTSHeadlineLevel7
          " hi OrgTSHeadlineLevel8
          hi link OrgAgendaDeadline SpecialChar
          hi link OrgAgendaScheduled Constant
          hi link OrgAgendaScheduledPast SpecialChar
          endfunction
          autocmd ColorScheme * call s:orgmode_colors()
      ]]
    end
  }, -- }}}
  -- vimtex {{{
  {
    'lervag/vimtex',
    ft = 'latex',
    init = function()
      vim.g.vimtex_enabled               = 1
      vim.g.vimtex_complete_enabled      = 1
      vim.g.vimtex_complete_close_braces = 0
      vim.g.vimtex_parser_bib_backend    = 'bibtex'
      vim.g.vimtex_complete_bib          = {
        simple = true,
        menu_fmt = '@author_short (@year), "@title"',
        abbr_fmt = '@key',
        auth_len = 12
      }
      vim.g.vimtex_view_general_viewer   = 'okular'
      vim.g.vimtex_view_general_options  = '--unique file:@pdf#src:@line@tex'
      vim.g.vimtex_view_automatic        = 1
      vim.g.vimtex_quickfix_mode         = 0
    end
  }, -- }}}
}
