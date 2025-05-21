require "language/node"

class NxAT20 < Formula
  desc "Smart, Fast and Extensible Build System"
  homepage "https://nx.dev"
  url "https://registry.npmjs.org/nx/-/nx-20.8.2.tgz"
  sha256 "39c7249bfbfe2816fe066ed4f1a62855fd51831ec1d7e805a0d78e47b4dadda4"
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
