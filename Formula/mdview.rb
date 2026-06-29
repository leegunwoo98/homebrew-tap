class Mdview < Formula
  desc "Markdown review in the browser with Approve / Request-changes buttons"
  homepage "https://github.com/claude-code-tools/mdview-review"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.1/mdview-darwin-arm64"
      sha256 "c8df779989033fbd2873d5737f8af8e56359dc361cefe6cf25a9384019e743a8"
    end
    on_intel do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.1/mdview-darwin-amd64"
      sha256 "cfed4ffe0bf3d9ccb267f8367120435b1f1090e44fc1a91e6be6f279d58f0c1e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.1/mdview-linux-arm64"
      sha256 "885d9c85880a3a6f909e5a1a08bb30e4802766d5aaa3a93973b0cb006d8f4cf9"
    end
    on_intel do
      url "https://github.com/claude-code-tools/mdview-review/releases/download/v0.1.1/mdview-linux-amd64"
      sha256 "bd2e2f19fa1ce42bbf4f83ef2dc12472e5f46ee7ac93cbf020beefb219911996"
    end
  end

  def install
    # The release asset is the raw, per-platform binary; install it as `mdview`.
    bin.install Dir["mdview-*"].first => "mdview"
  end

  test do
    (testpath/"t.md").write("# hello\n")
    assert_match "mdview review", shell_output("#{bin}/mdview --print #{testpath}/t.md")
    assert_match "mdview", shell_output("#{bin}/mdview --version")
  end
end
