class BrewMaintainer < Formula
  desc "Automated Homebrew updater with logs, retry handling, and scheduled runs"
  homepage "https://github.com/lucalorenzon/brew-maintainer"
  url "<REPLACED_BY_GITHUB_ACTION>"
  sha256 "<REPLACED_BY_GITHUB_ACTION>"
  license "MIT"

  depends_on "rust" => :build

  on_macos do
    if Hardware::CPU.intel?
      def install
        system "cargo", "install", *std_cargo_args
        (prefix/"brew-maintainer.plist").write plist
      end

      def plist
        <<~EOS
          <?xml version="1.0" encoding="UTF-8"?>
          <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
          <plist version="1.0">
          <dict>
            <key>Label</key>
            <string>com.lucalorenzon.brew-maintainer</string>
            <key>ProgramArguments</key>
            <array>
              <string>#{opt_bin}/brew-maintainer</string>
            </array>
            <key>StartInterval</key>
            <integer>21600</integer>
            <key>RunAtLoad</key>
            <true/>
            <key>StandardOutPath</key>
            <string>/usr/local/var/log/brew-maintainer.log</string>
            <key>StandardErrorPath</key>
            <string>/usr/local/var/log/brew-maintainer-error.log</string>
          </dict>
          </plist>
        EOS
      end

      def post_install
        system "mkdir", "-p", "/usr/local/var/log"
        system "launchctl", "load", "-w", "#{prefix}/brew-maintainer.plist"
      end
    else
      odie "Only x86_64 macOS is supported."
    end
  end

  test do
    system "#{bin}/brew-maintainer", "--help"
  end
end
