local function read_config()
  local full_path = vim.fn.expand("~/.notes.conf")
  local file = io.open(full_path, "r")
  local config = {}

  if file then
    local idx = 1

    for line in file:lines() do
      config[idx] = line
      idx = idx + 1
    end

    file:close()
  else
    print("Couldn't open the ~/.notes.conf file. Make sure it exists and it's not empty.")
  end

  return config
end

local config = read_config()

local function create_weekly_notes()
  local day_seconds = 24 * 60 * 60
  local current_time = os.time()
  local date = os.date("%w", current_time)
  local current_weekday = tonumber(date) -- 0 = Sunday, 1 = Monday...

  local days_since_monday = current_weekday == 0 and 6 or (current_weekday - 1)
  local monday_time = current_time - (days_since_monday * day_seconds)

  local year_week = os.date("%Y-W%V-%b-%d", monday_time)
  local notes_path = vim.fn.expand(config[1])
  local file_path = notes_path .. "/" .. year_week .. ".md"

  print(notes_path)
  print(vim.fn.isdirectory(notes_path))

  if vim.fn.isdirectory(notes_path) == 0 then
    vim.fn.mkdir(notes_path, "p")
  end

  vim.cmd('vsplit ' .. vim.fn.fnameescape(file_path))

  if vim.fn.filereadable(file_path) == 0 then
    local function get_day_str(label, day_offset)
      local target_time = monday_time + (day_offset * day_seconds)
      local target_date = os.date("%b %d", target_time)

      return "### " .. label .. " (" .. target_date .. ")"
    end

    local start_date = os.date("%b %d", monday_time)
    local end_date = os.date("%b %d", monday_time + (4 * day_seconds))

    local template = {
      "# 🗓 Week " .. os.date("%V", monday_time) .. ": " .. start_date .. " - " .. end_date,
      "",
      "## 🎯 Weekly Top Priorities",
      "- [ ]",
      "- [ ]",
      "",
      "---",
      "",
      "## 📅 Daily Execution",
      "",
      get_day_str("Monday", 0),
      "- [ ]",
      "",
      get_day_str("Tuesday", 1),
      "- [ ]",
      "",
      get_day_str("Wednesday", 2),
      "- [ ]",
      "",
      get_day_str("Thursday", 3),
      "- [ ]",
      "",
      get_day_str("Friday", 4),
      "- [ ]",
      "",
      "---",
      "## 📝 Scratchpad",
      "*(Dump thoughts, context, and ad-hoc requests here)*"
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
  end
end

vim.keymap.set("n", "<leader>nw", create_weekly_notes, {})
vim.keymap.set("n", "<leader>ti", 'o- [ ]', {})
