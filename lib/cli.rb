module CLI
  autoload :IO, './lib/cli/io'
  autoload :Git, './lib/cli/git'
  autoload :DNS, './lib/cli/dns'
  autoload :Docker, './lib/cli/docker'

  class << self
    def exec(command, *options, status_code: false)
      full_command = "#{command} #{options.join(' ')}"

      CLI::IO.say('[CLI] Executing ', color: :pink, newline: false)
      CLI::IO.say(full_command, color: :blue)

      status_code ? system(full_command) : `#{full_command}`.strip
    end
  end
end
