# encoding: utf-8
require 'spec_helper'

describe Guard::Bundler::Notifier do
  subject { Guard::Bundler::Notifier }

  it 'should call Guard::Notifier' do
    ::Guard::Notifier.should_receive(:notify).with(
      "Bundle has been updated\nin 10.1 seconds.",
      :title => 'Bundle update',
      :image => :success
    )
    subject.notify(true, 10.1)
  end

end
