require "guard/bundler/verify"

RSpec.describe Guard::Bundler::Verify do
  describe '#uses_gemspec?' do
    context "when gemspec is used" do
      before do
        allow(IO).to receive(:read).with('foo').and_return("\n\n  gemspec  \n")
      end

      it "detects used gemspec" do
        expect(subject.uses_gemspec?('foo')).to be_truthy
      end
    end

    context "when gemspec is not used" do
      before do
        allow(IO).to receive(:read).with('foo').and_return("gem 'rspec'\n")
      end

      it "does not detects gemspec usage" do
        expect(subject.uses_gemspec?('foo')).to be_falsey
      end
    end
  end

  describe '#real_path' do
    context "when Gemfile is not watched" do
      before do
        allow(Guard::Compat).to receive(:watched_directories).and_return(['/foo'])
      end

      it 'shows error' do
        expect(Guard::Compat::UI).to receive(:error).
          with(/Guard will not detect changes/)
        subject.real_path('Gemfile')
      end
    end

    context "when Gemfile is watched along with whole project" do
      before do
        allow(Guard::Compat).to receive(:watched_directories).
          and_return([Pathname.pwd])
      end

      it 'shows no error' do
        expect(Guard::Compat::UI).to_not receive(:error)
        subject.real_path('Gemfile')
      end

      it 'returns relative path to file' do
        expect(subject.real_path('Gemfile')).to eq('Gemfile')
      end
    end

    context "when subdir is watched" do
      before do
        allow(Guard::Compat).to receive(:watched_directories).
          and_return([Pathname.pwd + 'foo'])
      end

      context "when Gemfile is symlinked" do
        before do
          allow_any_instance_of(Pathname).to receive(:realpath).
            and_return(Pathname.pwd + 'foo/Gemfile')
        end

        it "returns the relative real path" do
          expect(subject.real_path('Gemfile')).to eq('foo/Gemfile')
        end

        it 'shows no error' do
          expect(Guard::Compat::UI).to_not receive(:error)
          subject.real_path('Gemfile')
        end
      end
    end
  end
end
