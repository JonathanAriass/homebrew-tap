cask "ganesha" do
  arch arm: "arm64", intel: "x64"

  # version + sha256 are kept up to date automatically by .github/workflows/update-cask.yml,
  # which reads the latest release of JonathanAriass/Ganesha. The 64-zero hashes below are
  # placeholders until the first release is published.
  version "1.0.0"
  sha256 arm:   "655ca9cb04633aaeeba598d918b93fd1416b4e4f5573b54d70155bac92fc073a",
         intel: "ff8c1c436911237aa2733c8aef77152d7eded755365fe3c2a4a7d9d40a21f080"

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
