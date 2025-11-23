class BrewMaintainer < Formula
  desc "Automated Homebrew maintenance tool (update, upgrade, cleanup with logs)"
  homepage "https://github.com/lucalorenzon/brew-maintainer"
  url "https://github.com/lucalorenzon/brew-maintainer/releases/download/v0.1.35/brew-maintainer"
  version "0.1.35"
  sha256 "75ad2ac7672d837bb854f1d3832a46ade1d3ca3b72733dff568c4f1739e1ad9a"
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
      "HOME" => ENV.fetch("HOME"),
      "PATH" => std_service_path_env
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
