class TidyJson < Formula
  desc "A cli for tidying up json files."
  homepage "https://github.com/todor-a/tidy-json"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.6/tidy-json-aarch64-apple-darwin.tar.gz"
      sha256 "509120c8e14021ff0e3641238c280ff96e7469893da364109245caae808c787f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.6/tidy-json-x86_64-apple-darwin.tar.gz"
      sha256 "97a20a6152efeda13f8ed01dd026d02368d394f763ff9beacbbe898de2e82a1b"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.6/tidy-json-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5469c8634d494e1669547c3c26bf4b7475dce105a20db218bd2571912817be2f"
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
