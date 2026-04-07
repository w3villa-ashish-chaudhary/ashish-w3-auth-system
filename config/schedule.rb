every 30.minutes do
  runner "User.where('plan_expires_at < ?', Time.current).update_all(plan: nil, plan_expires_at: nil)"
end