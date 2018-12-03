![FFPopup](/Resources/ffpopup-logo.png)

*FFPopup is a lightweight library for presenting custom views as a popup.*

## Features

- Support several popup show types
	- [x] None
	- [x] Fade In
	- [x] Grow In
	- [x] Shrink In
	- [x] Slide In from top, bottom, left, right
	- [x] Bounce In
	- [x] Bounce In from top, bottom, left, right
	- [ ] Support custom

- Support several popup dismiss types
	- [x] None
	- [x] Fade Out
	- [x] Grow Out
	- [x] Shrink Out
	- [x] Slide Out to top, bottom, left, right
	- [x] Bounce Out
	- [x] Bounce Out to top, bottom, left, right
	- [ ] Support custom

- Layout the popup in the horizontal direction
	- [x] Left
	- [x] Left of center
	- [x] Center
	- [x] Right of center
	- [x] Right
	- [ ] Support custom

- Layout the popup in the vertical direction
	- [x] Top
	- [x] Above center
	- [x] Center
	- [x] Below center
	- [x] Bottom
	- [ ] Support custom

- Controled whether to allow interaction with the underlying view
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
$ open FFPopup_Example.xcworkspace
```

## Installation

#### CocoaPods

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

#### Manually

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

Animation transition for presenting contentView. Controled how the popup will be presented.

The default value is `FFPopupShowType_ShrinkIn`.

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

Animation transition for dismissing contentView. Controled how the popup will be dismissed.

The default value is `FFPopupDismissType_ShrinkOut`.

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

Mask prevents background touches from passing to underlying views. Controled whether to allow interaction with the underlying view.

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

Creat a new popup with custom values.

```objc
/**
 Convenience Initializers
 Creat a new popup with `contentView`.
 */
+ (FFPopup *)popupWithContentView:(UIView *)contentView;

/**
 Convenience Initializers
 Creat a new popup with custom values.
 
 @param contentView The view you want to appear in popup.
 @param showType    The default value is `FFPopupShowType_ShrinkIn`.
 @param dismissType The default value is `FFPopupDismissType_ShrinkOut`.
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

#### 7,Showing the Popup

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

## Live Demo

My app [Time Card -Countdown](https://itunes.apple.com/cn/app/%E6%97%B6%E9%97%B4%E5%8D%A1-%E7%B2%BE%E8%87%B4%E7%9A%84%E7%BA%AA%E5%BF%B5%E6%97%A5%E5%8A%A9%E6%89%8B/id1347998487?mt=8) (Never Forget Important Days) is using FFPopup. You can download it and try it on your multiple devices to experience the effect.

<a href="https://itunes.apple.com/cn/app/%E6%97%B6%E9%97%B4%E5%8D%A1-%E7%B2%BE%E8%87%B4%E7%9A%84%E7%BA%AA%E5%BF%B5%E6%97%A5%E5%8A%A9%E6%89%8B/id1347998487?mt=8">
  <img src="/Resources/download-on-the-appstore.png">
</a>

## License

`FFPopup` is available under the [MIT license](/LICENSE). See the LICENSE file for more info.
