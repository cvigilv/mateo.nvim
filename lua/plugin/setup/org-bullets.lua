require("org-bullets").setup {
  concealcursor = false,
  checkboxes = {
    cancelled = { "-", "OrgCancelled" },
    done = { "✓", "OrgDone" },
    todo = { "˟", "OrgTODO" },
  },
  symbols = {
    headlines = {"○", "◌", "◍", "◎", "●", "◐", "◑", "◒", "◓", "◔", "◕", "◖", "◗", "◙"},
  }
}
