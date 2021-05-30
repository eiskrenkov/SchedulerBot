require './lib/core_ext/object'
require './lib/cli'
require './lib/configuration'
require './lib/rake/support'

require 'sshkit'
require 'sshkit/dsl'

namespace :app do
  namespace :deploy do
    Configuration.stages.to_h.each do |stage, configuration|
      next unless configuration.remote

      ip = CLI::DNS.resolve(configuration.remote.host)

      desc "Deploy application to #{stage} (#{configuration.remote.host} - #{ip})"
      task stage => "docker:push:#{stage}" do # : %w[docker:push]
        include SSHKit::DSL

        start_time = Time.now
        say("Starting #{stage} deployment - #{start_time}")

        on "#{configuration.remote.user}@#{configuration.remote.host}" do
          unless test("[[ -d #{configuration.remote.root} ]]")
            say("Root folder doesn't exists! Creating #{configuration.remote.root}")
            execute(:mkdir, configuration.remote.root)
          end

          within configuration.remote.root do
            unless test("[[ -f #{configuration.remote.root}/.env ]]")
              say("Couldn't find .env file within #{configuration.remote.root}!", color: :red)
              abort
            end

            say('Pulling latest Docker image...')
            execute(:docker, 'pull', CLI::Docker.image)

            say('Current images list:')
            say(capture(:docker, 'images'), color: :white)

            current_container_id = capture(:docker, 'ps', '--latest', '--format', '{{.ID}}')

            if current_container_id.present?
              say("Container with ID #{current_container_id} is already running, stopping it...")
              execute(:docker, 'stop', current_container_id)

              say('Removing old container...')
              execute(:docker, 'rm', current_container_id)
            end

            say('Starting the container...')
            say(capture(:docker, 'run', '--env-file', '.env', '-d', CLI::Docker.image), color: :white)
          end
        end
      end
    end
  end
end
