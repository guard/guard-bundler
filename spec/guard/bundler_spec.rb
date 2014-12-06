# encoding: utf-8

require "guard/bundler"

RSpec.describe Guard::Bundler do
  subject { described_class.new }

  context '#bundle_check' do

    it 'should call `bundle check\' command' do
      expect(subject).to receive(:'`').with('bundle check')
      subject.send(:bundle_check)
    end

    context 'arbitrary cli switches' do

      it 'should be false by default' do
        expect(subject).not_to be_cli
      end

      it 'should be set to true' do
        subject = Guard::Bundler.new(cli: '--binstubs')
        expect(subject.options[:cli]).to be_truthy
      end

    end

  end

  context '#bundle_install' do

    it 'should call `bundle install\' command' do
      expect(subject).to receive(:system).with('bundle install')
      subject.send(:bundle_install)
    end

  end

  context '#refresh_bundle' do

    it 'should call #bundle_install if #bundle_check fails' do
      expect(subject).to receive(:bundle_check).and_return(false)
      expect(subject).to receive(:bundle_install).and_return(:bundle_installed)
      expect(subject.send(:refresh_bundle)).to be_truthy
    end

    it 'should not call #bundle_install if #bundle_check succeeds' do
      expect(subject).to receive(:bundle_check).and_return(:bundle_already_up_to_date)
      expect(subject).not_to receive(:bundle_install)
      expect(subject.send(:refresh_bundle)).to be_truthy
    end

    it 'should return false if #bundle_install fails' do
      expect(subject).to receive(:bundle_check).and_return(false)
      expect(subject).to receive(:bundle_install).and_return(false)
      expect(subject.send(:refresh_bundle)).to be_falsey
    end

    it 'should call notifier after #bundle_install succeeds' do
      allow(subject).to receive(:bundle_check).and_return(false)
      expect(subject).to receive(:bundle_install).and_return(:bundle_installed)
      expect(Guard::Bundler::Notifier).to receive(:notify).with(true, anything())
      subject.send(:refresh_bundle)
    end

    it 'should call notifier after #bundle_install fails' do
      allow(subject).to receive(:bundle_check).and_return(false)
      expect(subject).to receive(:bundle_install).and_return(false)
      expect(Guard::Bundler::Notifier).to receive(:notify).with(false, anything())
      subject.send(:refresh_bundle)
    end

    it 'should call notifier if #bundle_check succeeds' do
      allow(subject).to receive(:bundle_check).and_return(:bundle_installed_using_local_gems)
      expect(Guard::Bundler::Notifier).not_to receive(:notify).with('up-to-date', anything())
      subject.send(:refresh_bundle)
    end

  end

  context '#start' do

    it 'should call #refresh_bundle' do
      expect(subject).to receive(:refresh_bundle).and_return(true)
      subject.start
    end

  end

  context '#reload' do

    it 'should call #refresh_bundle' do
      expect(subject).to receive(:refresh_bundle).and_return(true)
      subject.reload
    end

  end

  context '#run_all' do

    it 'should call #refresh_bundle' do
      expect(subject).to receive(:refresh_bundle).and_return(true)
      subject.run_all
    end

  end

  context '#run_on_additions' do

    it 'should call #refresh_bundle' do
      expect(subject).to receive(:refresh_bundle).and_return(true)
      subject.run_on_additions
    end

  end

  context '#run_on_modifications' do

    it 'should call #refresh_bundle' do
      expect(subject).to receive(:refresh_bundle).and_return(true)
      subject.run_on_modifications
    end

  end

end
