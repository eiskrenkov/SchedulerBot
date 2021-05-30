module CLI::DNS
  class << self
    def resolve(hostname)
      CLI.exec('dig', '+short', hostname)
    end
  end
end
