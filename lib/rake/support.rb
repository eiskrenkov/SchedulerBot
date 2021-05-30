def say(message, color: :yellow)
  CLI::IO.say("[RAKE] #{message}", color: color)
end
