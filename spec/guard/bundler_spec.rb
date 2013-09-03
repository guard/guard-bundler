# encoding: utf-8
require 'spec_helper'

describe Guard::Bundler do
  subject { described_class.new }

  context '#bundle_check' do

    it 'should call `bundle check\' command' do
      subject.should_receive(:'`').with('bundle check')
      subject.send(:bundle_check)
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

  context '#bundle_install' do

    it 'should call `bundle install\' command' do
      subject.should_receive(:system).with('bundle install')
      subject.send(:bundle_install)
    end

  end

  context '#refresh_bundle' do

    it 'should call #bundle_install if #bundle_check fails' do
      subject.should_receive(:bundle_check).and_return(false)
      subject.should_receive(:bundle_install).and_return(:bundle_installed)
      subject.send(:refresh_bundle).should be_true
    end

    it 'should not call #bundle_install if #bundle_check succeeds' do
      subject.should_receive(:bundle_check).and_return(:bundle_already_up_to_date)
      subject.should_not_receive(:bundle_install)
      subject.send(:refresh_bundle).should be_true
    end

    it 'should return false if #bundle_install fails' do
      subject.should_receive(:bundle_check).and_return(false)
      subject.should_receive(:bundle_install).and_return(false)
      subject.send(:refresh_bundle).should be_false
    end

    it 'should call notifier after #bundle_install succeeds' do
      subject.stub(:bundle_check).and_return(false)
      subject.should_receive(:bundle_install).and_return(:bundle_installed)
      Guard::Bundler::Notifier.should_receive(:notify).with(true, anything())
      subject.send(:refresh_bundle)
    end

    it 'should call notifier after #bundle_install fails' do
      subject.stub(:bundle_check).and_return(false)
      subject.should_receive(:bundle_install).and_return(false)
      Guard::Bundler::Notifier.should_receive(:notify).with(false, anything())
      subject.send(:refresh_bundle)
    end

    it 'should call notifier if #bundle_check succeeds' do
      subject.stub(:bundle_check).and_return(:bundle_installed_using_local_gems)
      Guard::Bundler::Notifier.should_not_receive(:notify).with('up-to-date', anything())
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
