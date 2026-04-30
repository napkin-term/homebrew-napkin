# homebrew-napkin

Homebrew tap for [napkin](https://github.com/johndockery/napkin) — a fast,
local-first terminal with first-class workspaces, structured scrollback,
and agent-awareness.

## Install

```sh
brew install --cask napkin-term/napkin/napkin
```

Or tap first, then install:

```sh
brew tap napkin-term/napkin
brew install --cask napkin
```

## What's in here

- `Casks/napkin.rb` — cask that installs the napkin macOS app. The
  `postflight` block removes the Gatekeeper quarantine attribute because
  the `.dmg` isn't codesigned or notarized yet; plan is to swap this out
  once the main repo has an Apple Developer cert wired into the release
  workflow.

## Updating

Every `v*` tag push on `johndockery/napkin` produces a release with
platform-specific `.dmg` artefacts. When the release is published:

1. Bump `version` in `Casks/napkin.rb`.
2. Replace `sha256 :no_check` with real per-arch checksums:
   ```sh
   shasum -a 256 napkin_<version>_aarch64.dmg napkin_<version>_x64.dmg
   ```
3. `brew style --fix Casks/napkin.rb` if you have Homebrew installed.
4. Commit, push, done — users get the new version on their next `brew update`.
