class BrewMaintainer < Formula
  desc "Automated Homebrew maintenance tool (update, upgrade, cleanup with logs)"
  homepage "https://github.com/lucalorenzon/brew-maintainer"
  version "v0.1.26"
  url "https://github.com/lucalorenzon/brew-maintainer/releases/download/v0.1.26/brew-maintainer"
  sha256 "5b63b458422e8f4b7bfc20ba7e691dd5359a5d1981e96c9e6a8d7a5337d70a61"
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
    environment_variables PATH: "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin"
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
