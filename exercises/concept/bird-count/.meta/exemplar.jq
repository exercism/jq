{
  last_week: .[-2],
  yesterday: .[-1][-2],
  total: (last | add),
  busy_days: (last | map(select(. >= 5)) | length),
  has_day_without_birds: (last | any(. == 0))
}

