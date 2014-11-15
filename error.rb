def error(type)
  
  input_list = ["I can't do that Dave.", "Huh?", "Try making sense for a change.", "What now?", "Try again."]
  needs_target_list = ["That command needs a target.", "Tell me what to interact with.", "Two words please."]
  no_target_list = ["That command doesn't need a target.", "Please use that command on it's own.", "One word please."]

  if type == "input"
    puts input_list.sample
  elsif type == "needs_target"
    puts needs_target_list.sample
  elsif type == "no_target"
    puts no_target_list.sample
  else
    exit(1)
  end
end
    