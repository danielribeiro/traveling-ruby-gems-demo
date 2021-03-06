# For Bundler.with_clean_env
require 'bundler/setup'
require_relative "traveling_config"
TRAVELING_RUBY_VERSION = "20150715-2.1.6"

desc "Package your app"
task default: :package
task :package => ['package:osx']

namespace :package do
  desc "Package your app for OS X"
  task :osx => [:bundle_install, "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-osx.tar.gz"] do
    create_package("osx")
  end

  desc "Install gems to local directory"
  task :bundle_install do
    if RUBY_VERSION !~ /^2\.1\./
      abort "You can only 'bundle install' using Ruby 2.1, because that's what Traveling Ruby uses."
    end
    sh "rm -rf packaging/tmp"
    sh "mkdir -p packaging/tmp"
    sh "cp Gemfile Gemfile.lock packaging/tmp/"
    Bundler.with_clean_env do
      sh "cd packaging/tmp && env BUNDLE_IGNORE_CONFIG=1 bundle install --path ../vendor --without development"
    end
    sh "rm -rf packaging/tmp"
    sh "rm -rf packaging/vendor/*/*/cache/*"
  end
end

file "packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-osx.tar.gz" do
  download_runtime("osx")
end

def create_package(target)
  package_dir = PACKAGE_NAME
  vendor_dir = "#{package_dir}/vendor"
  sh "rm -rf #{package_dir}"
  sh "mkdir #{package_dir}"
  sh "mkdir -p #{package_dir}"
  PACKAGING_DIRS.each do |dir|
    sh "cp -rf #{dir} #{package_dir}/"
  end
  sh "mkdir #{package_dir}/ruby"
  sh "tar -xzf packaging/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}.tar.gz -C #{package_dir}/ruby"
  sh "cp traveling-ruby-deps/* #{package_dir}/"
  sh "cp -pR packaging/vendor #{package_dir}/"
  sh "cp Gemfile Gemfile.lock #{vendor_dir}/"
  sh "mkdir #{vendor_dir}/.bundle"
  sh "cp traveling-ruby-deps/bundler-config #{vendor_dir}/.bundle/config"
  # unless ENV['DIR_ONLY']
    # sh "cd #{package_dir} && tar -czf ../#{package_dir}.tar.gz ."
    # sh "rm -rf #{package_dir}"
  # end
end

def download_runtime(target)
  sh "cd packaging && curl -L -O --fail " +
    "http://d6r77u77i8pq3.cloudfront.net/releases/traveling-ruby-#{TRAVELING_RUBY_VERSION}-#{target}.tar.gz"
end
