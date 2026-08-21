class Lazybrew < Formula
  desc "Terminal UI for inspecting and uninstalling Homebrew packages"
  homepage "https://github.com/todor-a/lazybrew"
  url "https://github.com/todor-a/lazybrew/releases/download/v0.1.3/lazybrew-0.1.3.tar.gz"
  version "0.1.3"
  sha256 "e2d7347f0d81950afe8e7d7e0d7681ad7a9db4d400c53438f1bc6f77464e53ad"

  depends_on :macos
  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w -extldflags=-Wl,-adhoc_codesign"), "./cmd/lazybrew"
  end

  test do
    output = shell_output("#{bin}/lazybrew 2>&1", 1)
    assert_equal "lazybrew requires an interactive terminal\n", output
  end
end
