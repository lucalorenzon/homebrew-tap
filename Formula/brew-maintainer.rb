class BrewMaintainer < Formula
  desc "Automated Homebrew maintenance tool (update, upgrade, cleanup with logs)"
  homepage "https://github.com/lucalorenzon/brew-maintainer"
  version "v0.1.24"
  url "https://github.com/lucalorenzon/brew-maintainer/releases/download/v0.1.24/brew-maintainer"
  sha256 "b17858a702ccbc51de972232fba6f198624b34e8fee2b7b3659f56788ccfc18f"
  license "MIT"

  depends_on :macos # only macOS supported

  def install
    bin.install "brew-maintainer"
  end

  service do
    run [opt_bin/"brew-maintainer"]
    keep_alive true
    log_path var/"log/brew-maintainer.log"
    error_log_path var/"log/brew-maintainer.err.log"
    working_dir var
  end

  def caveats
    <<~EOS
      brew-maintainer will automatically run every 6 hours via macOS service.
      Logs are stored under:
        #{var}/log/brew-maintainer.log
      If a run requires user input, it will be skipped and noted in the log.
    EOS
  end
end
