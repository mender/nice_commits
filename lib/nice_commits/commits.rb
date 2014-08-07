module NiceCommits
  class Commits
    def initialize(git, options)
      @git = git
      @since = options.since
    end

    def each(&block)
      log.each(&block)
    end

    private

    def log
      @git.log.since(@since)
    end
  end
end