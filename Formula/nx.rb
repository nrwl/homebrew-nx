require "language/node"

class Nx < Formula
  desc "Smart, Fast and Extensible Build System"
  homepage "https://nx.dev"
  url "https://registry.npmjs.org/nx/-/nx-20.6.3.tgz"
  sha256 "19984c09576d2485b42673be23eba1172fbada89937dc102d5000307ca098351"
  license "MIT"

  livecheck do
    url :stable
  end

  depends_on "node"

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
