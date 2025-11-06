class BrewMaintainer < Formula
  desc "Automated Homebrew maintenance tool (update, upgrade, cleanup with logs)"
  homepage "https://github.com/lucalorenzon/brew-maintainer"
  version "v0.1.22"
  url "https://github.com/lucalorenzon/brew-maintainer/archive/v0.1.22.tar.gz"
  sha256 "f289afedeb45252064a1c3bbdcbe78b567921df7eb457471853a17b151e7794a"
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
