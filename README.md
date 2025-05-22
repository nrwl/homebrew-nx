# The Nx Homebrew Tap

This is a custom [Homebrew](https://brew.sh/) tap for Nx.

## Setup

```shell
brew tap nrwl/nx
brew install nx
nx --version
```

## New Major Version

Run the script:

```
./create_new_major.rb 22.0.0
```

This will create the new `nx.rb` file and rename the existing major version to `nx@<major>.rb`. You can then open a PR with this version and let CI verify it. To install the new version:

```shell
brew update
brew upgrade nx
```
