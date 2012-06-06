# encoding: utf-8
require 'spec_helper'

describe Guard::Bundler do
  subject { Guard::Bundler.new }

  describe 'options' do

    context 'notify' do

      it 'should be true by default' do
        subject.should be_notify
      end

      it 'should be set to false' do
        subject = Guard::Bundler.new([], {:notify => false})
        subject.options[:notify].should be_false
      end

    end

    context 'arbitrary cli switches' do

      it 'should be false by default' do
        subject.should_not be_cli
      end

      it 'should be set to true' do
        subject = Guard::Bundler.new([], {:cli => '--binstubs'})
        subject.options[:cli].should be_true
      end

    end

  end

  context 'start' do

    it 'should call `bundle check\' command' do
      subject.should_receive(:`).with('bundle check')
      subject.should_receive(:system).with('bundle install')
      subject.start
    end

    it 'should call `bundle install\' command' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(true)
      subject.start.should be_true
    end

    it 'should not call `bundle install\' command if update not needed' do
      subject.should_receive(:bundle_need_refresh?).and_return(false)
      subject.should_not_receive(:system).with('bundle install')
      subject.start.should be_true
    end

    it 'should return false if `bundle install\' command fail' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(false)
      subject.start.should be_false
    end

  end

  context 'reload' do

    it 'should call `bundle install\' command' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(true)
      subject.reload.should be_true
    end

    it 'should return false if `bundle install\' command fail' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(false)
      subject.reload.should be_false
    end

  end

  context 'run_all' do

    it 'should return true' do
      subject.run_all.should be_nil
    end

  end

  context 'run_on_changes' do

    it 'should call `bundle check\' command' do
      subject.should_receive(:`).with('bundle check')
      subject.should_receive(:system).with('bundle install')
      subject.run_on_changes
    end

    it 'should call `bundle install\' command if update needed' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(true)
      subject.run_on_changes.should be_true
    end

    it 'should not call `bundle install\' command if update not needed' do
      subject.should_receive(:bundle_need_refresh?).and_return(false)
      subject.should_not_receive(:system).with('bundle install')
      subject.run_on_changes.should be_true
    end

    it 'should return false if `bundle install\' command fail' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(false)
      subject.run_on_changes.should be_false
    end

  end

  it 'should call notifier after `bundle install\' command success' do
    subject.should_receive(:bundle_need_refresh?).and_return(true)
    subject.should_receive(:system).with('bundle install').and_return(true)
    Guard::Bundler::Notifier.should_receive(:notify).with(true, anything())
    subject.send(:refresh_bundle)
  end

  it 'should call notifier after `bundle install\' command fail' do
    subject.should_receive(:bundle_need_refresh?).and_return(true)
    subject.should_receive(:system).with('bundle install').and_return(false)
    Guard::Bundler::Notifier.should_receive(:notify).with(false, anything())
    subject.send(:refresh_bundle)
  end

  it 'should call notifier if bundle do not need refresh' do
    subject.should_receive(:bundle_need_refresh?).and_return(false)
    Guard::Bundler::Notifier.should_receive(:notify).with('up-to-date', anything())
    subject.send(:refresh_bundle)
  end

  it 'should not call notifier id notify option is set to false' do
    subject.should_receive(:bundle_need_refresh?).and_return(true)
    subject.stub(:notify?).and_return(false)
    subject.should_receive(:system).with('bundle install').and_return(true)
    Guard::Bundler::Notifier.should_not_receive(:notify)
    subject.send(:refresh_bundle)
  end

end
