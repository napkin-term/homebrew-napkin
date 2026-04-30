cask "napkin" do
  version "0.3.1"
  sha256 :no_check

  arch arm: "aarch64", intel: "x64"

  url "https://github.com/johndockery/napkin/releases/download/v#{version}/napkin_#{version}_#{arch}.dmg"

  name "napkin"
  desc "Terminal with first-class workspaces, structured scrollback, and agent-awareness"
  homepage "https://github.com/johndockery/napkin"

  app "napkin.app"

  on_arm do
    binary "#{appdir}/napkin.app/Contents/MacOS/napkin-aarch64-apple-darwin", target: "napkin"
    binary "#{appdir}/napkin.app/Contents/MacOS/napkind-aarch64-apple-darwin", target: "napkind"
  end

  on_intel do
    binary "#{appdir}/napkin.app/Contents/MacOS/napkin-x86_64-apple-darwin", target: "napkin"
    binary "#{appdir}/napkin.app/Contents/MacOS/napkind-x86_64-apple-darwin", target: "napkind"
  end

  livecheck do
    url :url
    strategy :github_latest
  end

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
