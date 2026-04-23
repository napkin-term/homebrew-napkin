cask "napkin" do
  version "0.3.0"
  sha256 :no_check

  url "https://github.com/johndockery/napkin/releases/download/v#{version}/napkin_#{version}_aarch64.dmg"

  name "napkin"
  desc "Terminal with first-class workspaces, structured scrollback, and agent-awareness"
  homepage "https://github.com/johndockery/napkin"

  depends_on arch: :arm64

  app "napkin.app"

  binary "#{appdir}/napkin.app/Contents/MacOS/napkin"
  binary "#{appdir}/napkin.app/Contents/MacOS/napkind"

  # The .dmg isn't codesigned or notarized yet. macOS Gatekeeper will quarantine
  # the app on first install; strip the attribute so Launch Services opens it.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/napkin.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/dev.napkin.app",
    "~/Library/Preferences/dev.napkin.app.plist",
    "~/Library/Saved Application State/dev.napkin.app.savedState",
    "~/.local/share/napkin",
    "~/.config/napkin",
  ]
end
