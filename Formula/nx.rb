require "language/node"

class Nx < Formula
  desc "Smart, Fast and Extensible Build System"
  homepage "https://nx.dev"
  url "https://registry.npmjs.org/nx/-/nx-21.0.4.tgz"
  sha256 "dd1bf64358661a2d14dd027f8b0c6d8eea051afff4ec8206407bdb9335991f9f"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node@22"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    testdir = testpath/"test-project"
    testdir.mkdir
    testdir.cd do
      system bin/"nx", "--version"
    end
  end
end
