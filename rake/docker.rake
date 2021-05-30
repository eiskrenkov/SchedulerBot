require './lib/cli'
require './lib/rake/support'

namespace :docker do
  Configuration.stages.to_h.each do |stage, configuration|
    next unless configuration.dockerfile

    namespace :build do
      desc "Build #{stage} Docker image using #{configuration.dockerfile}"
      task stage do
        if !ENV['SKIP_GIT_CHECK'] && CLI::Git.uncommited_changes?
          CLI::IO.say('Repository has uncommitted changes. Please, commit them first', color: :red)
          abort
        end

        say('Building image...')

        if CLI::Docker.build(configuration.dockerfile)
          say('Image build succeeded!', color: :green)
        else
          say('Image build failed!', color: :red)
          abort
        end
      end
    end

    namespace :push do
      desc "Push #{stage} Docker image to GitHub Package Registry"
      task stage => "docker:build:#{stage}" do
        abort unless CLI::IO.ask_boolean("Do you really want to push #{CLI::Git.head_commit_sha} to GPR?")

        say('Pushing Docker image...')
        CLI::Docker.push
        say('Image pushed successfully!', color: :green)
      end
    end
  end
end
