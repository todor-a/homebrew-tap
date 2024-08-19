class TidyJson < Formula
  desc "A cli for tidying up json files."
  homepage "https://github.com/todor-a/tidy-json"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.3/tidy-json-aarch64-apple-darwin.tar.gz"
      sha256 "98ab12292661cd5f59e2ab5ab0f7cf077ca2229410a61dc262e3fc69b91666ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.3/tidy-json-x86_64-apple-darwin.tar.gz"
      sha256 "83a6f2f2aa23c2d48d32f62e911d6ebbb2a57fa315c3e3309d9f94833fb2d966"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/todor-a/tidy-json/releases/download/v0.2.3/tidy-json-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "afc572dac6ff23d133f336a5318d840374b778a44c7c7381908781e27aecbffb"
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
