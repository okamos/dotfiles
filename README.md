# Dotfiles
OS X / Ubuntu dotfiles.

[![asciicast](https://asciinema.org/a/47577.png)](https://asciinema.org/a/47577)

##  How to install
The installation step requires the [XCode Command Line Tools](https://developer.apple.com/downloads)

```
$ java -v
$ xcode-select --install
```

Run the following commnad.

```
$ bash -c "$(curl -fsSL raw.github.com/okamos/dotfiles/master/setup.sh)"
# Overwrite dotfiles and deploy
$ bash -c "$(curl -fsSL raw.github.com/okamos/dotfiles/master/setup.sh)" -- -f -s deploy
```

## Initialize

```
$ ~/dotfiles/dotfiles initialize
```

## Deploy dotfiles

```
$ ~/dotfiles/dotfiles deploy
```

## TODO
* OS X settings
