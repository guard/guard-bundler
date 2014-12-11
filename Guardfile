guard :bundler do
  watch('Gemfile')
  watch(%r{^.+\.gemspec$})
end

guard :rspec, cmd: "bundle exec rspec" do
  require "ostruct"

  rspec = OpenStruct.new
  rspec.spec_dir = "spec"
  rspec.spec = ->(m) { "#{rspec.spec_dir}/#{m}_spec.rb" }
  rspec.spec_helper = "#{rspec.spec_dir}/spec_helper.rb"
  rspec.spec_files = %r{^#{rspec.spec_dir}/.+_spec\.rb$}
  rspec.lib_files = %r{^lib/(.+)\.rb$}

  watch(rspec.spec_files)
  watch(rspec.lib_files)   { |m| rspec.spec.(m[1]) }
  watch(rspec.spec_helper) { rspec.spec_dir }
end
