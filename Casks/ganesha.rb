cask "ganesha" do
  # Apple Silicon only. Intel (x86_64) was dropped: GitHub retired the macos-13 Intel
  # runner, and its replacement (macos-15-intel) can't package the app reliably
  # (hdiutil "Resource busy"). `depends_on arch` below gives Intel users a clean
  # "unsupported" message instead of a failed install.
  #
  # version + sha256 are refreshed automatically by .github/workflows/update-cask.yml,
  # which reads the latest release of JonathanAriass/Ganesha.
  version "1.0.5"
  sha256 "e91db7b9d14996eea338a172680341fbd749478dd91692301f48a7372cec6462"

  url "https://github.com/JonathanAriass/Ganesha/releases/download/v#{version}/Ganesha-#{version}-arm64.zip",
      verified: "github.com/JonathanAriass/Ganesha/"
  name "Ganesha"
  desc "Cross-platform database client for Postgres, MySQL, MariaDB and MongoDB"
  homepage "https://github.com/JonathanAriass/Ganesha"

  depends_on arch: :arm64

  app "Ganesha.app"

  # Put a `ganesha` command on the user's PATH (Homebrew symlinks this into
  # <brew-prefix>/bin). The launcher ships inside the bundle and opens the app, so
  # `ganesha` launches/focuses Ganesha from a terminal.
  binary "#{appdir}/Ganesha.app/Contents/Resources/ganesha"

  # Ganesha isn't signed/notarized yet, so a quarantined copy is reported as
  # "damaged" on Apple Silicon. Homebrew 6.0 removed --no-quarantine, so strip the
  # flag here on install. If this is blocked, the caveat below has the manual command.
  # The chmod keeps the launcher executable so the `ganesha` link always runs.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ganesha.app"]
    system_command "/bin/chmod",
                   args: ["+x", "#{appdir}/Ganesha.app/Contents/Resources/ganesha"]
  end

  caveats <<~EOS
    Ganesha isn't signed or notarized by Apple yet. macOS quarantines apps it
    downloads, and on Apple Silicon an unsigned quarantined app is reported as
    "Ganesha is damaged and can't be opened" ("Ganesha está dañado").

    This cask tries to clear the quarantine flag for you on install. If macOS
    still blocks it, run this once, then open the app again:

      xattr -dr com.apple.quarantine "/Applications/Ganesha.app"

    (The right-click -> Open trick does NOT clear the "damaged" variant — only the
    command above does.)
  EOS

  # The app keeps its data under "db-client" (app.getName() is intentionally NOT renamed to
  # Ganesha — renaming it would re-key the macOS Keychain entry and break saved passwords).
  zap trash: [
    "~/Library/Application Support/db-client",
    "~/Library/Preferences/com.jonathanariass.dbclient.plist",
    "~/Library/Saved Application State/com.jonathanariass.dbclient.savedState",
  ]
end
