# homebrew-tap

Homebrew tap for [**Ganesha**](https://github.com/JonathanAriass/Ganesha) — a cross-platform
database client for Postgres, MySQL, MariaDB and MongoDB.

## Install

```sh
brew tap jonathanariass/tap
brew trust jonathanariass/tap   # Homebrew 6.0+ requires trusting third-party taps (one-time)
brew install --cask ganesha
```

On Homebrew older than 6.0 the `brew trust` line isn't needed — `brew install --cask jonathanariass/tap/ganesha` works on its own.

Ganesha isn't signed or notarized by Apple yet, so macOS quarantines it and — on
Apple Silicon — may report it as **"Ganesha is damaged and can't be opened"**
("está dañado"). The cask tries to clear the quarantine flag on install; if macOS
still blocks it, run this once and reopen:

```sh
xattr -dr com.apple.quarantine "/Applications/Ganesha.app"
```

The right-click → **Open** trick does _not_ clear the "damaged" message — only the
command above does.

## How it stays current

`Casks/ganesha.rb` is updated automatically by `.github/workflows/update-cask.yml`, which reads
the latest release of the main repo and refreshes the version + checksums. It runs on a schedule
and can be triggered manually from the **Actions** tab.
