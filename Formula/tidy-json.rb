class TidyJson < Formula
  desc "A cli for tidying up json files."
  homepage "https://github.com/todor-a/tidy-json"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.5/tidy-json-aarch64-apple-darwin.tar.gz"
      sha256 "c7ab4397dcc79c30bf79c76cc525b9239de461b6e3e5e2b61a9f002b9aabdb27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.5/tidy-json-x86_64-apple-darwin.tar.gz"
      sha256 "91899aa1a8d7cec8535dceddf5bd50ee7f3ebc68782e4ea09f06bb8b249d4e40"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.5/tidy-json-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e0662f5996ddaa985942b0f7b4df2b48d12a47190939a264156fcc73dfb351ef"
    end
  end
  license "MIT"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "tidy-json"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "tidy-json"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "tidy-json"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
