# FFPopup

FFPopup is a lightweight library for presenting custom views as a popup.

## Features

- Support several popup show types
	- [x] None
	- [x] Fade In
	- [x] Grow In
	- [x] Shrink In
	- [x] Slide In from top, bottom, left, right
	- [x] Bounce In
	- [x] Bounce In from top, bottom, left, right
	- [ ] Custom

- Support several popup dismiss types
	- [x] None
	- [x] Fade Out
	- [x] Grow Out
	- [x] Shrink Out
	- [x] Slide Out to top, bottom, left, right
	- [x] Bounce Out
	- [x] Bounce Out to top, bottom, left, right
	- [ ] Custom

- Layout the popup in the horizontal direction
	- [x] Left
	- [x] Left of center
	- [x] Center
	- [x] Right of center
	- [x] Right
	- [ ] Custom

- Layout the popup in the vertical direction
	- [x] Top
	- [x] Above center
	- [x] Center
	- [x] Below center
	- [x] Bottom
	- [ ] Custom

- Controled whether to allow interaction with the underlying view
	- [x] Allow interaction with underlying view
	- [x] Don't allow interaction with underlying view
	- [x] Don't allow interaction with underlying view, dim background
	- [ ] Don't allow interaction with underlying view, blur background
	- [ ] Custom

## Requirements

- iOS 8.0+ / macOS 10.13.6+
- Xcode 10.1 (10B61) +

## Example

To run the `Example` project, clone the Repo, and start `Example` in Xcode.

```bash
$ git clone https://github.com/JonyFang/FFPopup.git
$ cd FFPopup/Example
$ open FFPopup_Example.xcworkspace
```

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager, which automates and simplifies the process of using 3rd-party libraries like `FFPopup` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```bash
pod 'FFPopup'
```

If you want to use the latest features of FFPopup use normal external source dependencies.

```bash
pod 'FFPopup', :git => 'https://github.com/JonyFang/FFPopup.git'
```

This pulls from the master branch directly.

Second, install `FFPopup` into your project:

```bash
pod install
```

### Manually

Alternatively you can directly add the `FFPopup.h` and `FFPopup.m` source files to your project.

- Download the [latest code version]() or add the repository as a git submodule to your git-tracked project.
- Open your project in Xcode, then drag and drop `FFPopup.h` and `FFPopup.m` onto your project (use the `"Product Navigator view"`). Make sure to select `Copy items` when asked if you extracted the code archive outside of your project.
- Include `FFPopup` wherever you need it with `#import "FFPopup.h"`.

## Swift

Even though `FFPopup` is written in Objective-C, it can be used in Swift with no hassle. If you use [CocoaPods](http://cocoapods.org/) add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```bash
use_frameworks!
```

If you added `FFPopup` manually, just add a [bridging header](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html) file to your project with the `FFPopup` header included.

## Usage

## Customization

## Live Demo

## Backers

## Sponsors

## Contributors

## Donations

## License