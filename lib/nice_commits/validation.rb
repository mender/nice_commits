module NiceCommits
  class Validation
    def initialize(options)
      @options = options
    end

    def start
      invalid_commits.each do |commit|
        notification = Notification.new(commit)
        notification.deliver
      end
    end

    private

    def commits
      Commits.new(git, @options)
    end

    def invalid_commits
      InvalidCommits.new(commits)
    end

    def git
      @git ||= Git.open(work_dir, :log => logger)
    end

    def work_dir
      @options.dir
    end

    def logger
      @options.logger
    end
  end
end