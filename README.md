![FFPopup](/Resources/ffpopup-logo.png)

<p align="center">
    <a href="https://travis-ci.org/JonyFang/FFPopup">
        <img src="https://travis-ci.org/JonyFang/FFPopup.svg?branch=master" alt="CI Status">
    </a>
    <a href="https://codecov.io/gh/JonyFang/FFPopup">
    	<img src="https://codecov.io/gh/JonyFang/FFPopup/branch/master/graph/badge.svg" alt="Codecov Status">
	</a>
	<a href="http://cocoapods.org/pods/FFPopup">
        <img src="https://img.shields.io/cocoapods/v/FFPopup.svg" alt="Cocoapods Version">
    </a>
    <a href="https://github.com/Carthage/Carthage">
        <img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat" alt="Carthage compatible">
    </a>
    <a href="http://cocoapods.org/pods/FFPopup">
        <img src="https://img.shields.io/cocoapods/p/FFPopup.svg" alt="Platform">
    </a>
    <a href="LICENSE">
        <img src="https://img.shields.io/cocoapods/l/FFPopup.svg" alt="MIT License">
    </a>
    <a href="https://github.com/jonyfang/FFPopup/issues">
        <img src="https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat" alt="FFPopup Issues">
    </a>
    <a href="http://twitter.com/jony_chunfang">
        <img src="https://img.shields.io/badge/twitter-@JonyFang-blue.svg?style=flat" alt="Twitter">
    </a>
</p>

<p align="center">FFPopup is a lightweight library for presenting custom views as a popup.</p>

<table>
<tr>
<th>Bounce from Top & Bounce to Bottom</th>
<th>Bounce from Top & Bounce to Top</th>
<th>Bounce in & Bounce out</th>
<th>Grow in & Shrink out</th>
<th>Bounce from Bottom & Slide to Bottom</th>
<th>Slide from Bottom & Slide to Bottom</th>
</tr>
<tr>
<td><img src="/Resources/001_bounce_from_top&Bounce_to_bottom.gif"/></td>
<td><img src="/Resources/002_bounce_from_top&bounce_to_top.gif"/></td>
<td><img src="/Resources/003_bounce_in&bounce_out.gif"/></td>
<td><img src="/Resources/004_grow_in&shrink_out.gif"/></td>
<td><img src="/Resources/005_bounce_from_bottom&slide_to_bottom.gif"/></td>
<td><img src="/Resources/006_slide_from_bottom&slide_to_bottom.gif"/></td>
</tr>
</table>

## Features

- Support several popup show types
	- [x] None
	- [x] Fade In
	- [x] Grow In
	- [x] Shrink In
	- [x] Slide In from top, bottom, left, right
	- [x] Bounce In from top, bottom, left, right, center
	- [ ] Support custom

- Support several popup dismiss types
	- [x] None
	- [x] Fade Out
	- [x] Grow Out
	- [x] Shrink Out
	- [x] Slide Out to top, bottom, left, right
	- [x] Bounce Out to top, bottom, left, right, center
	- [ ] Support custom

- Layout the popup in the horizontal direction
	- [x] Left
	- [x] Right
	- [x] Center
	- [x] Left of center
	- [x] Right of center
	- [ ] Support custom

- Layout the popup in the vertical direction
	- [x] Top
	- [x] Bottom
	- [x] Center
	- [x] Above center
	- [x] Below center
	- [ ] Support custom

- Controlled whether to allow interaction with the underlying view
	- [x] Allow interaction with underlying view
	- [x] Don't allow interaction with underlying view
	- [x] Don't allow interaction with underlying view, dim background
	- [ ] Don't allow interaction with underlying view, blur background
	- [ ] Support custom

- Others
	- [ ] Complete Documentation

## Requirements

- iOS 8.0+ / macOS 10.13.6+
- Xcode 10.1 (10B61) +

## Example

To run the `Example` project, clone the Repo, and start `Example` in Xcode.

```bash
$ git clone https://github.com/JonyFang/FFPopup.git
$ cd FFPopup/Example
$ pod install
$ open FFPopup_Example.xcworkspace
```

## Installation

There are three ways to use `FFPopup` in your project:

- Installation with `CocoaPods`
- Installation with `Carthage`
- `Manually` install

#### CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager, which automates and simplifies the process of using 3rd-party libraries like `FFPopup` in your projects. First, add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
pod 'FFPopup'
```

If you want to use the latest features of `FFPopup` use normal external source dependencies.

```ruby
pod 'FFPopup', :git => 'https://github.com/JonyFang/FFPopup.git'
```

This pulls from the master branch directly.

Second, install `FFPopup` into your project:

```bash
$ pod install
```

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate `FFPopup` into your Xcode project using Carthage, specify it in your `Cartfile`:

```bash
github "JonyFang/FFPopup"
```

Run the following command to build the framework:

```bash
$ carthage update
```

Drag the built `FFPopup.framework` binaries from `Carthage/Build/iOS` into your application’s Xcode project.

On your application targets’ `Build Phases` settings tab, click the `+ icon` and choose `New Run Script Phase`. Create a `Run Script` in which you specify your shell (ex: `/bin/sh`), add the following contents to the script area below the shell:

```sh
/usr/local/bin/carthage copy-frameworks
```

Add the following paths to the frameworks you want to use under `Input Files`.

```
$(SRCROOT)/Carthage/Build/iOS/FFPopup.framework
```

For an in depth guide, read on from [Adding frameworks to an application](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)

#### Manually

Alternatively you can directly add the `FFPopup.h` and `FFPopup.m` source files to your project.

- Download the [latest code version]() or add the repository as a git submodule to your git-tracked project.
- Open your project in Xcode, then drag and drop `FFPopup.h` and `FFPopup.m` onto your project (use the `"Product Navigator view"`). Make sure to select `Copy items` when asked if you extracted the code archive outside of your project.
- Include `FFPopup` wherever you need it with `#import "FFPopup.h"`.

## Swift

Even though `FFPopup` is written in Objective-C, it can be used in Swift with no hassle. If you use [CocoaPods](http://cocoapods.org/) add the following line to your [Podfile](http://guides.cocoapods.org/using/using-cocoapods.html):

```ruby
use_frameworks!
```

If you added `FFPopup` manually, just add a [bridging header](https://developer.apple.com/library/content/documentation/Swift/Conceptual/BuildingCocoaApps/MixandMatch.html) file to your project with the `FFPopup` header included.

## Usage

Import the library where you want to use it.

- Objective-C

```objc
#import <FFPopup.h>

[[FFPopup popupWithContentView:self.contentView] show];

// Do something...

[FFPopup dismissPopupForView:self.contentView animated: YES];
``` 

- Swift

```swift
import FFPopup

FFPopup.init(contentView:self.contentView).show()

// Do something...

FFPopup.dismiss(for:self.contentView animated:true)
```

## Customization

#### 1.FFPopupShowType

Animation transition for presenting contentView. Controlled how the popup will be presented.

The default value is `FFPopupShowType_BounceInFromTop`.

| FFPopupShowType |
| :------ |
| FFPopupShowType_None |
| FFPopupShowType_FadeIn |
| FFPopupShowType_GrowIn |
| FFPopupShowType_ShrinkIn |
| FFPopupShowType_SlideInFromTop |
| FFPopupShowType_SlideInFromBottom |
| FFPopupShowType_SlideInFromLeft |
| FFPopupShowType_SlideInFromRight |
| FFPopupShowType_BounceIn |
| FFPopupShowType_BounceInFromTop |
| FFPopupShowType_BounceInFromBottom |
| FFPopupShowType_BounceInFromLeft |
| FFPopupShowType_BounceInFromRight |

#### 2.FFPopupDismissType

Animation transition for dismissing contentView. Controlled how the popup will be dismissed.

The default value is `FFPopupDismissType_BounceOutToBottom`.

| FFPopupDismissType |
| :------ |
| FFPopupDismissType_None |
| FFPopupDismissType_FadeOut |
| FFPopupDismissType_GrowOut |
| FFPopupDismissType_ShrinkOut |
| FFPopupDismissType_SlideOutToTop |
| FFPopupDismissType_SlideOutToBottom |
| FFPopupDismissType_SlideOutToLeft |
| FFPopupDismissType_SlideOutToRight |
| FFPopupDismissType_BounceOut |
| FFPopupDismissType_BounceOutToTop |
| FFPopupDismissType_BounceOutToBottom |
| FFPopupDismissType_BounceOutToLeft |
| FFPopupDismissType_BounceOutToRight |

#### 3.FFPopupMaskType

Mask prevents background touches from passing to underlying views. Controlled whether to allow interaction with the underlying view.

The default value is `FFPopupMaskType_Dimmed`.

| FFPopupMaskType |
| :------ |
| FFPopupMaskType_None |
| FFPopupMaskType_Clear |
| FFPopupMaskType_Dimmed |

#### 4.Other Properties

| Property Name | Description | Default Value |
| :------ | :------ | :------: |
| dimmedMaskAlpha | Overrides alpha value for dimmed mask. | 0.5 |
| showInDuration | Overrides animation duration for show in. | 0.15 |
| dismissOutDuration | Overrides animation duration for dismiss out. | 0.15 |
| shouldDismissOnBackgroundTouch | If `YES`, the popup will dismiss when background is touched. | YES |
| shouldDismissOnContentTouch | If `YES`, the popup will dismiss when content view is touched. | NO |

#### 5.Blocks

```objc
/**
 A block to be executed when showing animation started.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^willStartShowingBlock)(void);

/**
 A block to be executed when showing animation finished.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^didFinishShowingBlock)(void);

/**
 A block to be executed when dismissing animation started.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^willStartDismissingBlock)(void);

/**
 A block to be executed when dismissing animation finished.
 The default value is nil.
 */
@property (nonatomic, copy, nullable) void(^didFinishDismissingBlock)(void);
```

#### 6.Convenience Initializers

Create a new popup with custom values.

```objc
/**
 Convenience Initializers
 Create a new popup with `contentView`.
 */
+ (FFPopup *)popupWithContentView:(UIView *)contentView;

/**
 Convenience Initializers
 Create a new popup with custom values.
 
 @param contentView The view you want to appear in popup.
 @param showType    The default value is `FFPopupShowType_BounceInFromTop`.
 @param dismissType The default value is `FFPopupDismissType_BounceOutToBottom`.
 @param maskType    The default value is `FFPopupMaskType_Dimmed`.
 @param shouldDismissOnBackgroundTouch  The default value is `YES`.
 @param shouldDismissOnContentTouch     The default value is `NO`.
 */
+ (FFPopup *)popupWithContentView:(UIView *)contentView
                         showType:(FFPopupShowType)showType
                      dismissType:(FFPopupDismissType)dismissType
                         maskType:(FFPopupMaskType)maskType
         dismissOnBackgroundTouch:(BOOL)shouldDismissOnBackgroundTouch
            dismissOnContentTouch:(BOOL)shouldDismissOnContentTouch;
```

#### 7.Showing the Popup

```objc
/**
 Show popup with center layout.
 `FFPopupVerticalLayout_Center` & `FFPopupHorizontalLayout_Center`
 Showing animation is determined by `showType`.
 */
- (void)show;

/**
 Show popup with specified layout.
 Showing animation is determined by `showType`.
 */
- (void)showWithLayout:(FFPopupLayout)layout;

/**
 Show and then dismiss popup after `duration`.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showWithDuration:(NSTimeInterval)duration;

/**
 Show popup with specified `layout` and then dismissed after `duration`.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showWithLayout:(FFPopupLayout)layout duration:(NSTimeInterval)duration;

/**
 Show popup at point in view's coordinate system.
 If view is nil, will use screen base coordinates.
 */
- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view;

/**
 Show popup at point in view's coordinate system and then dismissed after duration.
 If view is nil, will use screen base coordinates.
 If duration is `0.0` or `less`, it will be considered infinity.
 */
- (void)showAtCenterPoint:(CGPoint)point inView:(UIView *)view duration:(NSTimeInterval)duration;
```

#### 8.Dismissing the Popup

```objc
/**
 Dismiss popup.
 Use `dismissType` if animated is `YES`.
 */
- (void)dismissAnimated:(BOOL)animated;
```

```objc
 /**
 Dismiss all the popups in the app.
 */
+ (void)dismissAllPopups;

/**
 Dismiss the popup for contentView.
 */
+ (void)dismissPopupForView:(UIView *)view animated:(BOOL)animated;

/**
 Dismiss super popup.
 Iterate over superviews until you find a `FFPopup` and dismiss it.
 */
+ (void)dismissSuperPopupIn:(UIView *)view animated:(BOOL)animated;
```

## TODO List

This is the to-do list for the `FFPopup` project. You can join us to become a contributor.

- [ ] Support blur option for background mask
- [ ] Support for keyboard show/hide
- [ ] Support for drag-to-dismiss

See the [CONTRIBUTING](./CONTRIBUTING.md) file for contributing guidelines.

## Live Demo

My app [Time Card -Countdown](https://itunes.apple.com/cn/app/%E6%97%B6%E9%97%B4%E5%8D%A1-%E7%B2%BE%E8%87%B4%E7%9A%84%E7%BA%AA%E5%BF%B5%E6%97%A5%E5%8A%A9%E6%89%8B/id1347998487?mt=8) (Never Forget Important Days) is using `FFPopup`. You can download it and try it on your multiple devices to experience the effect.

<a href="https://itunes.apple.com/cn/app/%E6%97%B6%E9%97%B4%E5%8D%A1-%E7%B2%BE%E8%87%B4%E7%9A%84%E7%BA%AA%E5%BF%B5%E6%97%A5%E5%8A%A9%E6%89%8B/id1347998487?mt=8">
  <img src="/Resources/download-on-the-appstore.png">
</a>

## Contributors

This project exists thanks to all the people who contribute. [Contribute](./CONTRIBUTING.md)

<a href="https://opencollective.com/ffpopup#backer"><img src="https://opencollective.com/ffpopup/contributors.svg?width=890" /></a>

## Backers

Thank you to all our backers! Your support is really important for the project and encourages us to continue. 🙏 [Become a backer](https://opencollective.com/ffpopup#backer)

<a href="https://opencollective.com/ffpopup#backers" target="_blank"><img src="https://opencollective.com/ffpopup/backers.svg?width=890"></a>

## Sponsors

Thank you to all our sponsors! [Become a sponsor](https://opencollective.com/ffpopup#sponsor)

<a href="https://opencollective.com/ffpopup/sponsor/0/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/1/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/2/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/3/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/4/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/5/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/6/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/7/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/8/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/ffpopup/sponsor/9/website" target="_blank"><img src="https://opencollective.com/ffpopup/sponsor/9/avatar.svg"></a>

## License

`FFPopup` is available under the [MIT license](/LICENSE). See the LICENSE file for more info.
