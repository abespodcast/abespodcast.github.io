# ABES PODCAST WEBSITE

Source of [abespodcast.github.io](https://abespodcast.github.io)

Made with [Publish](https://github.com/johnsundell/publish) the [Swift](https://swift.org) static site generator.

# Running Locally (Mac)

## Install Dependencies

- Xcode
- Open `Terminal` and type `swift` then run.
  - It should enter swift REPL.
  - If it doesn't, try installing xcode command line utilities.
  - type `:quit` to exit swift REPL.
- Publish.
  - \$ `git clone git@github.com:JohnSundell/Publish.git ~/Publish`
  - \$ `cd ~/Publish`
  - \$ `make`

## Run locally

- Clone this repository.
- $`cd` into abespodcast.github.io
- $`publish run`
  - It will compile, then start the local development server at `localhost:8000`.

## Build
- $`swift run`

## Making Changes

- Double click on `Package.swift` to open it in Xcode.
- Open `Sources/Abespodcast/main.swift`.
- After making changes do `Run / Cmd+R`.
- Reload `localhost:8000` manually.
  - ( make sure `publsih run` is running in terminal )
- It should load with the changes in a second or so.

## Working with VSCode

- Open the folder in VSCode
- Open the integrated terminal
- $`swift build`
- $`swift run`
- [SwiftFormat Plugin](https://marketplace.visualstudio.com/items?itemName=vknabel.vscode-swiftformat) is recommended

## Deploying

Run command;

- $`publish deploy`

Or, make a change and commit to `source` branch (on github web ui for convenience). Github action will take care of the deployment.
TODO: Setup a web hook trigger for deployment when podcast feed is updated 

## Troubleshooting
- Install xcode command line tools: `xcode-select --install`.
- Fix if xcode command line tools are installed to wrong path: sudo `xcode-select --switch /Applications/Xcode.app/Contents/Developer`
