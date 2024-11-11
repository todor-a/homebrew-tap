class TidyJson < Formula
  desc "A cli for tidying up json files."
  homepage "https://github.com/todor-a/tidy-json"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.7/tidy-json-aarch64-apple-darwin.tar.gz"
      sha256 "a4716b829c3444116d21742ba3cf1637aec96c9568bfa02b2661055cadef67b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.7/tidy-json-x86_64-apple-darwin.tar.gz"
      sha256 "3e78af0f686ef995df554ecb440f71387bdc180edc860cd58576d4fca175ed9b"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.7/tidy-json-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32ee40862fc25c4bfecb5f42d436c464e57624a0706936a0993067ed59d8a0d2"
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
