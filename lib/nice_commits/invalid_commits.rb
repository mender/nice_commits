module NiceCommits
  class InvalidCommits
    def initialize(commits)
      @commits = commits
    end

    def each(&block)
      @commits.each do |commit|
        validator = MessageValidator.new(commit.message)
        unless validator.valid?
          yield commit
        end
      end
    end
  end
end