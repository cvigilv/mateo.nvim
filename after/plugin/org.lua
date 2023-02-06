require('orgmode').setup_ts_grammar()
require('orgmode').setup(
  {
    -- Sources
    org_agenda_files = {
      '/home/carlos/zk/inbox/agenda.org',
      '/home/carlos/zk/inbox/events.org',
      '/home/carlos/zk/inbox/recurring.org',
      '/home/carlos/zk/inbox/birthdays.org',
      '/home/carlos/zk/journaling/journal.org',
    },

    -- Quality-of-life
    org_agenda_templates = {
      i = {
        description = 'Ideas',
        template = '* %?\n%u',
        target = '~/zk/inbox/ideas.org',
      },
      c = {
        description = 'Code',
        template = '* %?\n%u\n%a',
        target = '~/zk/inbox/code.org',
      },
      t = 'Task',
      te = {
        description = 'Event',
        template = '** [#A] %?\nSCHEDULED: %t',
        target = '~/zk/inbox/agenda.org',
        headline = 'event'
      },
      to = {
        description = 'One-time task',
        template = '** %?\nSCHEDULED: %t',
        target = '~/zk/inbox/agenda.org',
        headline = 'one-time'
      },
      tr = {
        description = 'Recurrent task',
        template = '** %?\nSCHEDULED: %t',
        target = '~/zk/inbox/agenda.org',
        headline = 'recurring'
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
      'TODO(t)',
      'DOING(.)',
      'WAITING(w)',
      'DELEGATED(e)',
      '|',
      'DONE(d)',
      'CANCELED(x)'
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
