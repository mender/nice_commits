require File.expand_path("../../spec_helper", __FILE__)

describe NiceCommits::MessageValidator do
	subject { NiceCommits::MessageValidator.new(message) }

  describe '#valid?' do
    context 'for merge message' do
      let(:message) { %q{Merge branch 'master' into develop} }
      it { expect(subject.valid?).to be true }
    end

    context 'for pull request message' do
      let(:message) { %q{Merge pull request #1111 from contributor/master} }
      it { expect(subject.valid?).to be true }
    end

    context 'for well formed message' do
      let(:message) { %q{refactor(subscriptions): fix feature envy in sender} }
      it { expect(subject.valid?).to be true }
    end

    context 'for well formed message with body' do
      let(:message) { <<-MESSAGE }
refactor(subscriptions): fix feature envy in sender

Long commit description
with list of changed files
- lib/sender.rb
- lib/strategy/mail.rb        
      MESSAGE
      it { expect(subject.valid?).to be true }
    end

    context 'for well formed message with blank lines in body' do
      let(:message) { <<-MESSAGE }
refactor(subscriptions): fix feature envy in sender

Long commit description with list of changed files:

- lib/sender.rb
- lib/strategy/mail.rb        
      MESSAGE
      it { expect(subject.valid?).to be true }
    end

    context 'for message with body without ending carriage return' do
      let(:message) { %Q{refactor(subscriptions): fix feature envy in sender\n\nCommit description\n\nissue} }
      it { expect(subject.valid?).to be true }
    end

    context 'for emty message' do
      let(:message) { '' }
      it { expect(subject.valid?).to be false }
    end

    context 'for message with glued body' do
      let(:message) { <<-MESSAGE }
refactor(subscriptions): fix feature envy in sender
Commit description
      MESSAGE
      it { expect(subject.valid?).to be false }
    end

    context 'for message without type' do
      let(:message) { '(all): fix a lot of issues' }
      it { expect(subject.valid?).to be false }
    end

    context 'for message without scope' do
      let(:message) { 'all: fix a lot of issues' }
      it { expect(subject.valid?).to be false }
    end

    context 'for not formed message' do
      let(:message) { 'fixes(all) fix a lot of issues' }
      it { expect(subject.valid?).to be false }
    end

    context 'for message without subject' do
      let(:message) { <<-MESSAGE }
refactor(all):

fix a lot of issues
      MESSAGE
      it { expect(subject.valid?).to be false }
    end

    context 'for message with short subject' do
      let(:message) { <<-MESSAGE }
refactor(all): fix

my commit is awesome
      MESSAGE
      it { expect(subject.valid?).to be false }
    end
  end
end