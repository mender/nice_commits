module NiceCommits
  class MessageValidator
    # Example:
    #
    # refactor(subscriptions): fix feature envy in sender
    #
    # Long commit description
    # with list of changed files
    # - lib/sender.rb
    # - lib/strategy/mail.rb
    #
    FORMAT = /\A
      ([a-z]+)                   # type of commit
      \(([^)\n:]+)\)             # scope of changes
      :[[:blank:]]+
      ([^\n]{5,})                # subject
      (?:\n\n([^\n]+(?:.*\n)+))? # body not necessary
    \Z/x
    MERGE = /\AMerge (?:branch|pull request)/

    def initialize(message)
      @message = message
    end

    def valid?
      merge? || well_formed?
    end

    private

    def merge?
      !!(@message =~ MERGE)
    end

    def well_formed?
      !!(@message =~ FORMAT)
    end
  end
end