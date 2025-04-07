require "language/node"

class Nx < Formula
  desc "Smart, Fast and Extensible Build System"
  homepage "https://nx.dev"
  url "https://registry.npmjs.org/nx/-/nx-20.7.1.tgz"
  sha256 "81b1c743fff0d48d1b77f2b3722aee8334d01ecc8c72fcd611c55409bfd36fa3"
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
