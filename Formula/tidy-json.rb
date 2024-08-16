class TidyJson < Formula
  desc "A cli for tidying up json files."
  homepage "https://github.com/todor-a/tidy-json"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.2/tidy-json-aarch64-apple-darwin.tar.gz"
      sha256 "f9d4ffdb6a4bdbd3c82c1696409a655f0a70d5d9d3b73c0d51b1fea918eeb6ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.2/tidy-json-x86_64-apple-darwin.tar.gz"
      sha256 "1bb0ff516230c641325f43a23e12ca3d2c7dd1b55aa10faf72335cabfecf859a"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.2/tidy-json-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5036fef19050f47d65b2ce3a4ec45f0dd570cfbdd626f16e67404cd23bfbb400"
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
