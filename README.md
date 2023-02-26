# WWDCCrawler

- Using WWDCCrawler, you can easily extract information about the Worldwide Developers Conference (WWDC) videos available on the Apple Developer website. This tool enables you to retrieve the titles of all videos from a specific year, along with their corresponding links.

### For those who doesn't has Xcode

1. Open Terminal on your Mac.

2. Run the following command to install Homebrew, which is a package manager for macOS:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Once Homebrew is installed, run the following command to install Swift:

```
brew install swift
```

This will download and install the latest version of the Swift toolchain on your Mac.

### Usage
follow these steps:

1. Open Terminal on your Mac.
Navigate to the directory where you have downloaded or cloned the WWDCCrawler project.

2. Build the script by running the following command:

```
swift build
```

3. Run the script by passing the year you are interested in as an argument. For example, to retrieve information about the WWDC videos from the year 2019, run the following command:
bash

```
.build/debug/WWDCCrawler 2019
```
4. The tool will then retrieve the information about the WWDC videos from the specified year and display it in the Terminal.

### License
This project is licensed under the MIT License - see the LICENSE file for details.
