class BrewMaintainer < Formula
  desc "Automated Homebrew maintenance tool (update, upgrade, cleanup with logs)"
  homepage "https://github.com/lucalorenzon/brew-maintainer"
  url "https://github.com/lucalorenzon/brew-maintainer/releases/download/v0.1.31/brew-maintainer"
  version "0.1.31"
  sha256 "5f9456545f48027881a8b970a1815063b6d28f06d513b2ccd40f9156e56a39fc"
  license "MIT"

  depends_on :macos # only macOS supported

  def install
    bin.install "brew-maintainer"
  end

  service do
    run [opt_bin/"brew-maintainer"]
    run_type :interval
    interval 21600  # 6 hours = 21600 seconds
    log_path var/"log/brew-maintainer.log"
    error_log_path var/"log/brew-maintainer.err.log"
    working_dir var
    environment_variables(
      HOME => ENV[“HOME"],
      PATH => std_service_path_env
    )
  end

  def caveats
    <<~DESC
      brew-maintainer will automatically run every 6 hours via macOS service.
      Logs are stored under:
        #{var}/log/brew-maintainer.log
      If a run requires user input, it will be skipped and noted in the log.
    DESC
  end
end
