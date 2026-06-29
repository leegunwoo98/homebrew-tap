class Mdview < Formula
  desc "Markdown review in the browser with Approve / Request-changes buttons"
  homepage "https://github.com/claude-code-tools/mdview-review"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.0/mdview-darwin-arm64"
      sha256 "1f5db83fb074ec80b2c3c7dbf9a144f65e4f49fc492c12a53f5cdeef32836b0b"
    end
    on_intel do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.0/mdview-darwin-amd64"
      sha256 "0179efe2e8feea4eefa50be03a96a66498ed570956f15a111b8837019d2263fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.0/mdview-linux-arm64"
      sha256 "39981427b0a1aa41a13335e428aa446ff70f4d63b06cc74abb060572e913689b"
    end
    on_intel do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.0/mdview-linux-amd64"
      sha256 "3bc7ea75021bc03a20ef355a2499103c205461363582529f50f93659333b440c"
    end
  end

  def install
    # The release asset is the raw, per-platform binary; install it as `mdview`.
    bin.install Dir["mdview-*"].first => "mdview"
  end

  test do
    (testpath/"t.md").write("# hello\n")
    assert_match "mdview review", shell_output("#{bin}/mdview --print #{testpath}/t.md")
  end
end
