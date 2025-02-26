## [4.2.0] - Changes

- Added moveToArc animation
  - upward property added
  - Fixed bug when using upward property on moveToArc
- Fixed animation controller not being disposed when the widget is disposed

## [4.1.1] - New animations

- New animations added
  - MoveTo
  - MoveToArc
- Fixed bug when using the fadeOut animations
  - FadeOut animations will trigger immediately, use animate or manualTrigger to control the animation

### [4.0.1] - New animations

- New animations added

  - BackInDown
  - BackInLeft
  - BackInRight
  - BackInUp
  - BackOutDown
  - BackOutLeft
  - BackOutRight
  - BackOutUp

- Remove accidental print statement

### [4.0.0] - New Api and project structure

- New Api (Sugar Syntax)
- New project structure
- More animations
- More examples
- More documentation
- Previous syntax is still available

### [3.3.10] - New animations

- New animations added
  - BounceIn

### [3.3.9] - New animations

- New animations added
  - Tada
  - Swing (updated animation)
  - Jello
  - Wobble
- Fixed the structure of the attention_seekers folder

#### [3.3.8] - RubberBand and Bounce bug fixed

- Fixed bug when state changes

#### [3.3.7] - RubberBand and Bounce bug fixed

- New animation toggle for RubberBand, HeartBeat and Bounce
- New animation HeartBeat added
- New animation FlipX and FlipY added

#### [3.3.6] - RubberBand and Bounce bug fixed

- New RubberBand animation
- New Bounce animation toggle

#### [3.3.5] - Swing bug fixed

- Fixed swing bug, now it works as expected
- from and to properties added to Pulse animation

#### [3.3.4] - ZoomIn and ZoomOut bug fixed

- Fixed ZoomIn and ZoomOut bug, now it works as expected

#### [3.3.3] - Spin bug fixed

- Fixed spin bug, now it works as expected + less code needed

#### [3.3.2] - PR Merge

- Fixed pulse animation - curve and curveOut added

#### [3.3.1] - On disposed bug fixed

- fixed the issue when you dispose the widget before the animation takes place, was throwing an error.

#### [3.3.0] - New Docs

- curve property added
- ZoomIn and ZoomOut fixed
- dart format .

#### [3.2.0] - New Docs

- onFinish added
- fix delay bug
- reformat code
- AnimateDoState Mixing added
- AnimateDoDirection type added

#### [3.1.2] - New Docs

- Dart format .

#### [3.1.1] - New Docs

- Typo Readme

#### [3.1.0] - Shakes and fixes

- Manual trigger fixed
- ShakeX and ShakeY added
- Other github issues fixed
- More examples added (Check Github repo)

#### [3.0.2] - FadeOuts bug fixed

- Fadeout bug fixed, now it works as expected
- Example #3 added - With controller

#### [3.0.1] - Animate Toggle

- Example #2 added

#### [3.0.0] - Animate Toggle

- Now you can Toggle the animate property
- All the animations can be executed backwards

#### [2.1.0] - Key constructors

- Prefer const
- Key constructors

#### [2.0.0] - Null-safety

- Now Animate_do its a library
- Null-safety checked and passed

#### [2.0.0-dev.1] - Null-safety

- Testing new null-safety version
- Refactored the entire library

#### [1.7.4] - Delay fixed

- Fixed: Calling forward on a disposed widget.
- Fixed: Some animations didn't have delayed.

#### [1.7.2] - Delay fixed

Fixed: Some issue in version 1.7.1 was blocking the delay.

#### [1.7.1] - controller.forward fix

- Bug fixed:
  When you were calling the animation with delay, and you dispose the widget before the animation takes place, was throwing an error because the controller was destroyed, this version fixes that.

#### [1.7.0] - Key added

- Key property added in every widget, now you can access the widget via Key and the AnimationController

#### [1.6.3] - Docs Updated

- Minor update

#### [1.6.2] - ZoomIn / ZoomOut

- Added a **from** property

#### [1.6.1] - Infinite animations can be stopped

- Now Attention Seekers can be stopped (even if they are in infinite mode). You just have to set the animate property from `true` to `false`
- You can use setState, Provider, Bloc, Redux to achieve that
- Delay bug fix with animate property

#### [1.5.1] - Description updated

- Description updated

#### [1.5.0] - Big step forward

- Readme updaded
- New animations
  - ZoomIn
  - Zoomout
  - FadeOut
  - FadeOutDown
  - FadeOutDownBig
  - FadeOutUp
  - FadeOutUpBig
  - FadeOutLeft
  - FadeOutLeftBig
  - FadeOutRight
  - FadeOutRightBig
- New properties added
  - from
  - animate
  - spins
- Smaller package size
- Smoother animations
- More customization

#### [1.2.1] - Readme updated

- Readme updated

#### [1.2.0] - Manual Trigger Added

- Manual Trigger added
  - (optional) bool manualTrigger
    - This option will not fire the animation on load. Forces you to provide the controller callback
  - (optional but mandatory if you use manualTrigger) Function controller
    - This callback, will give you access to the animationController from the selected animation. **See the example at the end of this documentation.**
- Minor fixes

#### [1.0.0] - Release

- Retouched all the animations
- Better FadeIns
- New animations added
  - JelloIn
  - FlipInX
  - FlipInY
  - Spin
  - SpinPerfect
  - Dance
  - Roulette
- Documentation updated

#### [0.2.0] - Delay implemented

- Implemented delay inside all animated widgets
- Big stability improvements
- Documentation updated

#### [0.1.5] - Small optimizations

- Readme updated
- Formatted the main file

#### [0.1.4] - New animations added

- Added the following animations
  - Swing
  - ElasticIn
  - ElasticInDown
  - ElasticInUp
  - ElasticInLeft
  - ElasticInRight

#### [0.1.3] - Example added

Fixing some Kotlin dependencies

#### [0.1.2] - Example added

You can find a simple demo in the "example" folder

#### [0.1.1] - Clean format

Just clean the animate_do main file

#### [0.1.0] - Basic functionality.

Production ready, but I want to add more features soon

- Added the following animations
  - FadeIn
  - FadeInDown
  - FadeInDownBig
  - FadeInUp
  - FadeInUpBig
  - FadeInLeft
  - FadeInLeftBig
  - FadeInRight
  - FadeInRightBig
  - BounceInDown
  - BounceInUp
  - BounceInLeft
  - BounceInRight
  - Bounce ( it could be infinite with a property)
  - Flash ( it could be infinite with a property)
  - Pulse ( it could be infinite with a property)
