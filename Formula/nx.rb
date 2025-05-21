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
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    # Create a temporary directory for testing
    testdir = testpath/"test-project"
    testdir.mkdir
    testdir.cd do
      # Initialize a new nx workspace
      system bin/"nx", "--version"
      # Change into the workspace directory
    #   Dir.chdir("test-workspace") do
    #     # Verify nx is working by running a basic command
    #     assert_match "Nx", shell_output("#{bin}/nx --version")
    #   end
    end
  end
end
