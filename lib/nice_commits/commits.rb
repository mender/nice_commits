module NiceCommits
  class Commits
    def initialize(git, options)
      @git = git
      @since = options.since
      @count = options.count
    end

    def each(&block)
      log.each(&block)
    end

    private

    def log
      @git.log(@count).since(@since)
    end
  end
end