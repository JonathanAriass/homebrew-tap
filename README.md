# homebrew-tap

Homebrew tap for [**Ganesha**](https://github.com/JonathanAriass/Ganesha) — a cross-platform
database client for Postgres, MySQL, MariaDB and MongoDB.

## Install

```sh
brew install --cask jonathanariass/tap/ganesha
```

(That's shorthand for `brew tap jonathanariass/tap && brew install --cask ganesha`.)

Ganesha isn't notarized by Apple yet, so on first launch macOS will ask you to confirm:
right-click the app in **Applications → Open**, or run
`xattr -dr com.apple.quarantine "/Applications/Ganesha.app"`.

## How it stays current

`Casks/ganesha.rb` is updated automatically by `.github/workflows/update-cask.yml`, which reads
the latest release of the main repo and refreshes the version + checksums. It runs on a schedule
and can be triggered manually from the **Actions** tab.
