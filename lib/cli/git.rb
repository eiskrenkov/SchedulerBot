module CLI::Git
  class << self
    def uncommited_changes?
      !git('diff', '--exit-code', '--quiet', status_code: true)
    end

    def head_commit_sha
      git('rev-parse', 'HEAD').strip[0..8]
    end

    private

    def git(*command, status_code: false)
      CLI.exec(:git, *command, status_code: status_code)
    end
  end
end
