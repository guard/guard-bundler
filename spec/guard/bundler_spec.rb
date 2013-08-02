# encoding: utf-8
require 'spec_helper'

describe Guard::Bundler do
  subject { described_class.new }

  context '#bundle_need_refresh?' do

    it 'should call `bundle check\' command and retrun false' do
      subject.should_receive(:`).with('bundle check')
      subject.send(:bundle_need_refresh?)
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

  context '#refresh_bundle' do

    it 'should call `bundle install\' command if need refresh' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(true)
      subject.send(:refresh_bundle).should be_true
    end

    it 'should not call `bundle install\' command if dont need refresh' do
      subject.should_receive(:bundle_need_refresh?).and_return(false)
      subject.should_not_receive(:system).with('bundle install')
      subject.send(:refresh_bundle).should be_true
    end

    it 'should return false if `bundle install\' command fail' do
      subject.should_receive(:bundle_need_refresh?).and_return(true)
      subject.should_receive(:system).with('bundle install').and_return(false)
      subject.send(:refresh_bundle).should be_false
    end

    it 'should call notifier after `bundle install\' command success' do
      subject.stub(:bundle_need_refresh?).and_return(true)
      subject.stub(:system).and_return(true)
      Guard::Bundler::Notifier.should_receive(:notify).with(true, anything())
      subject.send(:refresh_bundle)
    end

    it 'should call notifier after `bundle install\' command fail' do
      subject.stub(:bundle_need_refresh?).and_return(true)
      subject.stub(:system).and_return(false)
      Guard::Bundler::Notifier.should_receive(:notify).with(false, anything())
      subject.send(:refresh_bundle)
    end

    it 'should call notifier if bundle do not need refresh' do
      subject.stub(:bundle_need_refresh?).and_return(false)
      Guard::Bundler::Notifier.should_receive(:notify).with('up-to-date', anything())
      subject.send(:refresh_bundle)
    end

  end

  context '#start' do

    it 'should call #refresh_bundle' do
      subject.should_receive(:refresh_bundle).and_return(true)
      subject.start
    end

  end

  context '#reload' do

    it 'should call #refresh_bundle' do
      subject.should_receive(:refresh_bundle).and_return(true)
      subject.reload
    end

  end

  context '#run_all' do

    it 'should call #refresh_bundle' do
      subject.should_receive(:refresh_bundle).and_return(true)
      subject.run_all
    end

  end

  context '#run_on_additions' do

    it 'should call #refresh_bundle' do
      subject.should_receive(:refresh_bundle).and_return(true)
      subject.run_on_additions
    end

  end

  context '#run_on_modifications' do

    it 'should call #refresh_bundle' do
      subject.should_receive(:refresh_bundle).and_return(true)
      subject.run_on_modifications
    end

  end

end
