module NiceCommits
  class Notification
    def initialize(commit)
      @commit = commit
    end

    def deliver
      puts red(to_s)
    end

    def to_s
      "(WARNING) Invalid git commit message\nSHA: %s\n%s\n" % [@commit.sha, @commit.message]
    end

    def red(string)
      "\033[31m%s\033[0m" % string
    end
  end
end