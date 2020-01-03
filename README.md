# ABES PODCAST WEBSITE

Source of [abespodcast.github.io](https://abespodcast.github.io)

Made with [Publish](https://github.com/johnsundell/publish) the [swift](https://swift.org) static site generator.

# Running Locally (Mac)

## Install Dependencies

- XCode
- Open terminal and type `swift` then run.
  - It should enter swift REPL.
  - If it doesn't, try installing xcode command line utilities.
  - type `:quit` to exit swift REPL.
- Publish.
  - \$ `git clone git@github.com:JohnSundell/Publish.git`
  - \$ `cd Publish`
  - \$ `make`

## Build

- Clone this repository.
- `cd` into abespodcast.github.io
- `publish run`
  - It will compile, then start the local development server at `localhost:8000`.

## Making Changes

- Double click on `Package.swift` to open it in XCode.
- Open `Sources/Abespodcast/main.swift`.

## Deploying

- `publish deploy`
