class CodexAccountdeck < Formula
  desc "Manage Codex accounts, quotas, and local thread search and resume"
  homepage "https://github.com/nerdworldDE/codex-accountdeck"
  url "https://github.com/nerdworldDE/codex-accountdeck/releases/download/v1.3.0/codex_accountdeck-1.3.0.tar.gz"
  sha256 "5ed651e49670733179d4341ac0406569bf5de5e56c2ac0d75d57eb520047e594"
  license "MIT"

  depends_on "python@3.14"

  def install
    libexec.install "codex_hub.py", "hub_accounts.py", "hub_threads.py",
                    "hub_resumer.py", "hub_demo.py", "codex_resets.py",
                    "codex_renamer.py", "codex_colors.py"
    (bin/"codex-accountdeck").write <<~EOS
      #!/bin/sh
      exec "#{Formula["python@3.14"].opt_bin}/python3.14" "#{libexec}/codex_hub.py" "$@"
    EOS
    (bin/"codex-accountdeck").chmod(0755)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/codex-accountdeck --version")
    help = shell_output("#{bin}/codex-accountdeck --help")
    assert_match "usage:", help
    assert_match "--threads", help
    assert_match "--demo", help
  end
end
