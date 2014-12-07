require "guard/bundler/notifier"

RSpec.describe Guard::Bundler::Notifier do
  subject { Guard::Bundler::Notifier }

  it 'should format success message' do
    message = subject.guard_message(true, 10.1)
    expect(message).to eq("Bundle has been installed\nin 10.1 seconds.")
  end

  it 'should format fail message' do
    message = subject.guard_message(false, 10.1)
    expect(message).to eq("Bundle can't be installed,\nplease check manually.")
  end

  it 'should select success image' do
    expect(subject.guard_image(true)).to eq(:success)
  end

  it 'should select failed image' do
    expect(subject.guard_image(false)).to eq(:failed)
  end

  it 'should call Guard::Notifier' do
    expect(Guard::Compat::UI).to receive(:notify).with(
      "Bundle has been installed\nin 10.1 seconds.",
      title: 'bundle install',
      image: :success
    )
    subject.notify(true, 10.1)
  end

end
