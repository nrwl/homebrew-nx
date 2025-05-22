#!/usr/bin/env ruby

require 'open-uri'
require 'digest'
require 'fileutils'

def calculate_sha256(url)
  content = URI.open(url).read
  Digest::SHA256.hexdigest(content)
end

def rename_current_formula
  current_file = 'Formula/nx.rb'
  return unless File.exist?(current_file)

  content = File.read(current_file)
  version_match = content.match(/url ".*nx-(\d+\.\d+\.\d+)\.tgz"/)
  return unless version_match

  current_version = version_match[1]
  new_file = "Formula/nx@#{current_version.split('.').first}.rb"
  
  # Update class name in content
  updated_content = content.gsub(/class Nx/, "class NxAT#{current_version.split('.').first}")
  
  # Write to new file and remove old file
  File.write(new_file, updated_content)
  File.delete(current_file)
  
  puts "Renamed #{current_file} to #{new_file}"
end

def create_new_formula(version)
  url = "https://registry.npmjs.org/nx/-/nx-#{version}.tgz"
  sha256 = calculate_sha256(url)
  
  template = <<~RUBY
    require "language/node"

    class Nx < Formula
      desc "Smart, Fast and Extensible Build System"
      homepage "https://nx.dev"
      url "#{url}"
      sha256 "#{sha256}"
      license "MIT"

      livecheck do
        url :stable
      end

      depends_on "node@22"

      def install
        system "npm", "install", *Language::Node.std_npm_install_args(libexec)
        bin.install_symlink Dir["\#{libexec}/bin/*"]
      end

      test do
        # Create a temporary directory for testing
        testdir = testpath/"test-project"
        testdir.mkdir
        testdir.cd do
          system bin/"nx", "--version"
        end
      end
    end
  RUBY

  File.write('Formula/nx.rb', template)
  puts "Created new Formula/nx.rb with version #{version}"
end

if ARGV.empty?
  puts "Usage: #{$0} <version>"
  puts "Example: #{$0} 21.0.4"
  exit 1
end

version = ARGV[0]
unless version.match?(/^\d+\.\d+\.\d+$/)
  puts "Error: Version must be in format X.Y.Z"
  exit 1
end

rename_current_formula
create_new_formula(version) 