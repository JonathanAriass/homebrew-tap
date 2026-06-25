cask "ganesha" do
  arch arm: "arm64", intel: "x64"

  # version + sha256 are kept up to date automatically by .github/workflows/update-cask.yml,
  # which reads the latest release of JonathanAriass/Ganesha. The 64-zero hashes below are
  # placeholders until the first release is published.
  version "1.0.0"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/JonathanAriass/Ganesha/releases/download/v#{version}/Ganesha-#{version}-#{arch}.dmg",
      verified: "github.com/JonathanAriass/Ganesha/"
  name "Ganesha"
  desc "Cross-platform database client for Postgres, MySQL, MariaDB and MongoDB"
  homepage "https://github.com/JonathanAriass/Ganesha"

  app "Ganesha.app"

  caveats <<~EOS
    Ganesha is not yet notarized by Apple, so macOS quarantines it on download. On first launch:
      • right-click Ganesha in Applications and choose "Open" (once), or
      • run:  xattr -dr com.apple.quarantine "/Applications/Ganesha.app"
  EOS

  # The app keeps its data under "db-client" (app.getName() is intentionally NOT renamed to
  # Ganesha — renaming it would re-key the macOS Keychain entry and break saved passwords).
  zap trash: [
    "~/Library/Application Support/db-client",
    "~/Library/Preferences/com.jonathanariass.dbclient.plist",
    "~/Library/Saved Application State/com.jonathanariass.dbclient.savedState",
  ]
end
