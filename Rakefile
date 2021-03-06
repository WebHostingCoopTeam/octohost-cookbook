#!/usr/bin/env rake
# encoding: utf-8
require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

# Style tests. RuboCop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any']
    }
  end

  desc 'Run extra Foodcritic rulesets'
  task :chef_extra do
    sh 'foodcritic -f any -I foodcritic/* .' if Dir.exist? 'foodcritic'
  end
end

desc 'Run all style checks'
task style: ['style:ruby', 'style:chef', 'style:chef_extra']

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end

desc 'Run all tests'
task test: [:cleanup_vendor, :style, :spec]
task default: :test

desc 'Run rubocop tests'
task :rubocop do
  sh 'bundle exec rubocop'
end

desc 'Cleanup Vendor directory'
task :cleanup_vendor do
  sh 'rm -rf vendor/cookbooks/*'
  sh 'rm -rf vendor'
  sh 'rm -rf cookbooks && rm -rf nodes'
end

task :berksinstall do
  sh 'berks vendor vendor/cookbooks'
end

desc "build Vagrant box"
task :build_vagrant_without_tests => [:cleanup_vendor, :cleanup_vagrant, :berksinstall, :vagrantup]

desc 'Syntax check and build Vagrant box'
task build_vagrant: [:cleanup_vendor, :cleanup_vagrant, :style, :berksinstall, :vagrantup]
task vagrant: :build_vagrant

task :vagrantup do
  sh 'vagrant up --provision'
end

task :cleanup_vagrant do
  sh 'vagrant destroy -f'
end

desc 'Syntax check and build all Packer targets'
task build: [:cleanup_vendor, :style, :packer]

task packer: [:cleanup_vendor, :packer_build]

task :packer_build do
  sh 'berks vendor vendor/cookbooks'
  sh 'packer build template.json'
end

desc 'Syntax check and build AMI'
task build_ami: [:cleanup_vendor, :style, :packer_ami]

task packer_ami: [:cleanup_vendor, :packer_build_ami]

task :packer_build_ami do
  sh 'rm -rf vendor'
  sh 'berks vendor vendor/cookbooks'
  sh 'packer build -only=amazon-ebs template.json'
end

desc "Syntax check and build QEMU"
task :build_qemu => [:cleanup_vendor, :packer_build_qemu]

task :packer_build_qemu do
  sh 'berks vendor vendor/cookbooks'
  sh 'packer build -only=qemu template.json'
end

desc 'Syntax check and build Azure image.'
task build_azure: [:cleanup_vendor, :packer_build_azure]

task :packer_build_azure do
  sh 'rm -rf vendor'
  sh 'berks vendor vendor/cookbooks'
  sh 'packer build -only=azure template.json'
end

desc 'Syntax check and build Droplet'
task build_droplet: [:cleanup_vendor, :style, :packer_droplet]

task packer_droplet: [:cleanup_vendor, :packer_build_droplet]

task :packer_build_droplet do
  sh 'berks vendor vendor/cookbooks'
  sh 'packer build -only=digitalocean template.json'
end

desc 'Syntax check and build Openstack Image'
task build_openstack: [:cleanup_vendor, :style, :packer_openstack]

task packer_openstack: [:cleanup_vendor, :packer_build_openstack]

task :packer_build_openstack do
  sh 'berks vendor vendor/cookbooks'
  sh 'packer build -only=openstack template.json'
end

desc 'Syntax check and build Google Compute Image'
task build_gce: [:cleanup_vendor, :style, :packer_gce]

task packer_gce: [:cleanup_vendor, :packer_build_gce]

task :packer_build_gce do
  sh 'berks vendor vendor/cookbooks'
  sh 'packer build -only=googlecompute template.json'
end

task :convert_gce do
  sh 'openssl pkcs12 -in google.p12 -nocerts -passin pass:notasecret -nodes -out google.pem'
end

desc 'Usage: rake knife_solo user={user} ip={ip.address.goes.here}'
task :knife_solo do
  sh 'rm -rf vendor && rm -rf nodes'
  sh 'mkdir vendor && berks vendor vendor/cookbooks'
  sh "mkdir nodes && echo '{\"run_list\":[\"octohost::default\"]}' > nodes/#{ENV['ip']}.json"
  sh "bundle exec knife solo bootstrap #{ENV['user']}@#{ENV['ip']}"
end
