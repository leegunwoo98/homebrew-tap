class GhosttyTmuxAttach < Formula
  desc "Make Ghostty window-save-state restore actually re-attach to tmux sessions"
  homepage "https://github.com/leegunwoo98/ghostty-tmux-attach"
  url "https://github.com/leegunwoo98/ghostty-tmux-attach/archive/refs/tags/v0.1.0.tar.gz"
  # sha256 is bumped by the release workflow via `brew bump-formula-pr`
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/leegunwoo98/ghostty-tmux-attach.git", branch: "main"

  depends_on "tmux"
  depends_on "bash" => :recommended  # need bash 4+; macOS system bash is 3.2

  def install
    # Internal helpers in libexec/ (Homebrew convention for non-user-facing binaries)
    libexec.install "libexec/ghostty-tmux-attach-launch"
    libexec.install "libexec/ghostty-tmux-attach-shell"

    # install.sh + lib + shim + snippets in share/
    pkgshare.install "install.sh"
    pkgshare.install "lib"
    pkgshare.install "shim"
    pkgshare.install "snippets"

    # User-facing CLI in bin/
    bin.install "bin/ghostty-tmux-attach"

    # Patch the CLI dispatcher so it finds install.sh in pkgshare, not via the
    # relative-to-bin lookup that works in repo-dev.
    inreplace bin/"ghostty-tmux-attach" do |s|
      s.gsub! '"$BIN_DIR/../share/ghostty-tmux-attach/install.sh"',
              "\"#{pkgshare}/install.sh\""
    end
  end

  def caveats
    <<~EOS
      ghostty-tmux-attach is installed but not yet active.

      Run:
        ghostty-tmux-attach init

      to patch your Ghostty config (~/.config/ghostty/config) and tmux config
      (~/.tmux.conf). Per Homebrew norms, this formula does not touch user
      dotfiles automatically.

      For minimal mode (single shared 'main' session, no per-cwd allocation):
        ghostty-tmux-attach init --minimal

      To verify:
        ghostty-tmux-attach doctor

      Restart Ghostty for changes to take effect.
    EOS
  end

  test do
    # Smoke test: CLI is installed and reports version
    assert_match "ghostty-tmux-attach", shell_output("#{bin}/ghostty-tmux-attach --version")
    # Doctor runs without crashing (in a sandbox; some checks may fail but should not error)
    system bin/"ghostty-tmux-attach", "doctor"
  end
end
