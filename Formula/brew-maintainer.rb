class BrewMaintainer < Formula
  desc "Automated Homebrew updater with logs, retry handling, and scheduled runs"
  homepage "https://github.com/<REPLACED_BY_GITHUB_ACTION>"
  version "<REPLACED_BY_GITHUB_ACTION>"
  url "<REPLACED_BY_GITHUB_ACTION>"
  sha256 "<REPLACED_BY_GITHUB_ACTION>"
  license "MIT"

  def install
    bin.install "brew-maintainer"
    (var/"log").mkpath
  end

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>com.<REPLACED_BY_GITHUB_ACTION>.brew-maintainer</string>

        <key>ProgramArguments</key>
        <array>
          <string>#{opt_bin}/brew-maintainer</string>
        </array>

        <!-- Run every 6 hours -->
        <key>StartInterval</key>
        <integer>21600</integer>

        <key>RunAtLoad</key>
        <true/>

        <key>StandardOutPath</key>
        <string>#{var}/log/brew-maintainer.log</string>

        <key>StandardErrorPath</key>
        <string>#{var}/log/brew-maintainer-error.log</string>
      </dict>
      </plist>
    EOS
  end

  test do
    system "#{bin}/brew-maintainer", "--help"
  end
end
