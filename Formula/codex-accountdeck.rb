class CodexAccountdeck < Formula
  desc "Terminal dashboard for Codex accounts, quotas, resets, and thread names"
  homepage "https://github.com/nerdworldDE/codex-accountdeck"
  url "https://github.com/nerdworldDE/codex-accountdeck/releases/download/v1.2.0/codex_accountdeck-1.2.0.tar.gz"
  sha256 "090f9277368d179d695ebd65b2b53ff3b7afccb320b28f3d8df82424670caa9e"
  license "MIT"

  depends_on "python@3.14"

  def install
    libexec.install "codex_hub.py", "hub_accounts.py", "codex_resets.py",
                    "codex_renamer.py", "codex_colors.py"
    (bin/"codex-accountdeck").write <<~EOS
      #!/bin/sh
      exec "#{Formula["python@3.14"].opt_bin}/python3.14" "#{libexec}/codex_hub.py" "$@"
    EOS
    (bin/"codex-accountdeck").chmod(0755)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codex-accountdeck --version")
    assert_match "usage:", shell_output("#{bin}/codex-accountdeck --help")
  end
end
