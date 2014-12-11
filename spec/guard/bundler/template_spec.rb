require "guard/compat/test/template"

require "guard/bundler"

# This is included by the template
require "guard/bundler/verify"

module Guard
  RSpec.describe Bundler do
    describe "template" do
      subject { Compat::Test::Template.new(described_class) }

      let(:helper) { instance_double(Bundler::Verify) }

      before do
        allow(Bundler::Verify).to receive(:new).and_return(helper)
        allow(helper).to receive(:uses_gemspec?).and_return(true)

        allow(helper).to receive(:real_path).with('Gemfile').
          and_return('Gemfile')

        allow(Dir).to receive(:[]).and_return(%w(guard-foo.gemspec))

        allow(helper).to receive(:real_path).with('guard-foo.gemspec').
          and_return('guard-foo.gemspec')
      end

      context "when gemspec is used" do
        before do
          allow(helper).to receive(:uses_gemspec?).with('Gemfile').
            and_return(true)
        end

        it "watches the gemspec" do
          expect(subject.changed('config/guard-foo.gemspec')).
            to eq(%w(config/guard-foo.gemspec))
        end
      end

      context "when gemspec is not used" do
        before do
          allow(helper).to receive(:uses_gemspec?).with('Gemfile').
            and_return(false)
        end

        it "does not watch the gemspec" do
          expect(subject.changed('guard-foo.gemspec')).to eq(%w())
        end
      end

      context "when Gemfile is not a symlink" do
        before do
          expect(helper).to receive(:real_path).with('Gemfile').
            and_return('Gemfile')
        end

        it "watches Gemfile" do
          expect(subject.changed('Gemfile')).to eq(%w(Gemfile))
        end
      end

      context "with a symlinked Gemfile" do
        before do
          expect(helper).to receive(:real_path).with('Gemfile').
            and_return('config/Gemfile')
        end

        it "watches the real Gemfile" do
          expect(subject.changed('config/Gemfile')).to eq(%w(config/Gemfile))
        end
      end
    end
  end
end
