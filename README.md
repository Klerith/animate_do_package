# animate_do

## Null-Safety, Dart 3, with zero external dependencies

### iOS, Android, Linux, Mac, Web, Windows ready

An animation package inspired by [Animate.css](https://daneden.github.io/animate.css/), built using only Flutter animations, with zero dependencies.

![Animate_do demo animation](https://raw.githubusercontent.com/Klerith/animate_do_package/master/screenshots/demo-01.gif 'Animate_do')

## Getting Started

This package is simple to use. Every animation contains default values that look beautiful, but you can customize the properties to meet your needs.

## Properties in almost every animated widget:

| Property      | Type         | Description                                                                                       |
| ------------- | ------------ | ------------------------------------------------------------------------------------------------- |
| key           | **Key**      | (Optional) Widget key reference                                                                   |
| child         | **Widget**   | Required widget to animate                                                                        |
| duration      | **Duration** | Duration of the animation                                                                         |
| delay         | **Duration** | Delay before the animation starts                                                                 |
| from          | **double**   | Initial or final value for more pronounced slide/fade effects                                     |
| animate       | **boolean**  | Toggle from false to true to trigger animation (works with setState, Bloc, Provider, Redux, etc.) |
| infinite      | **boolean**  | Makes attention-seeking animations run indefinitely                                               |
| spins         | **double**   | Number of rotations for applicable animations (Spin, Roulette, PerfectSpin)                       |
| manualTrigger | **boolean**  | Enable manual animation triggering (requires controller property)                                 |
| controller    | **Function** | Exposes animation controller for advanced use cases                                               |
| onFinish      | **Function** | Callback triggered when animation completes (provides direction: forward/backward)                |
| curve         | **Curve**    | Customizable animation curve for any animated widget                                              |

# Available Animations

## FadeIn Animations

- FadeIn
- FadeInDown
- FadeInDownBig
- FadeInUp
- FadeInUpBig
- FadeInLeft
- FadeInLeftBig
- FadeInRight
- FadeInRightBig

## FadeOut Animations

- FadeOut
- FadeOutDown
- FadeOutDownBig
- FadeOutUp
- FadeOutUpBig
- FadeOutLeft
- FadeOutLeftBig
- FadeOutRight
- FadeOutRightBig

## BounceIn Animations

- BounceInDown
- BounceInUp
- BounceInLeft
- BounceInRight

## ElasticIn Animations

- ElasticIn
- ElasticInDown
- ElasticInUp
- ElasticInLeft
- ElasticInRight

## SlideIn Animations

- SlideInDown
- SlideInUp
- SlideInLeft
- SlideInRight

## FlipIn Animations

- FlipInX
- FlipInY

## Zoom Animations

- ZoomIn
- ZoomOut

## Attention Seekers

All of the following animations can be made infinite using the `infinite` property (type: bool)

- Bounce
- Dance
- Flash
- Pulse
- Roulette
- ShakeX
- ShakeY
- Spin
- SpinPerfect
- Swing
- HeartBeat
- Wobble
- Jello
- Tada
- RubberBand

## Two Syntaxes

Both syntaxes are supported, I have no plans to make the old one deprecated because some people like the old syntax better.

- Sugar Syntax
- Class Syntax

### (new) Sugar Syntax example

Check [the example folder](https://github.com/Klerith/animate_do_package/tree/master/example) for more details on how to use the sugar syntax.

```
home: Scaffold(
    body: Center(

        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

            const Square().fadeInLeft(),
            const Square().fadeInUp(),
            const Square().fadeInDown(),
            const Square().fadeInRight(),

        ],
        ),

    ),
),
```

## (classic) Class Syntax example

```
home: Scaffold(
    body: Center(

        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

            FadeInLeft(child: Square() ),
            FadeInUp(child: Square() ),
            FadeInDown(child: Square() ),
            FadeInRight(child: Square() ),

        ],
        ),

    ),
),
```

# Demos

For complete examples, check the `example` folder inside the repository

![Animate_do demo animation](https://raw.githubusercontent.com/Klerith/animate_do_package/master/screenshots/demo-00.gif 'Animate_do demo-00')

![Animate_do demo animation](https://raw.githubusercontent.com/Klerith/animate_do_package/master/screenshots/demo-02.gif 'Animate_do demo-02')

![Animate_do demo animation](https://raw.githubusercontent.com/Klerith/animate_do_package/master/screenshots/demo-04.gif 'Animate_do demo-04')

![Animate_do demo animation](https://raw.githubusercontent.com/Klerith/animate_do_package/master/screenshots/demo-05.gif 'Animate_do demo-05')

## Trigger animation manually (The easy way)

Just add the property animate to **true** to trigger the animation, and to **false** to revert the animation.

![Animate_do demo animation](https://raw.githubusercontent.com/Klerith/animate_do_package/master/screenshots/demo-03.gif 'animate property')

## Example: 02-Basic - Now with toggle

Just toggle the **animate** property to animate in or out easily.
Check the full code inside the example folder

```
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool animate = true;
  late AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                /// The animations are just widgets
                FadeIn(animate: animate,child: const Square(),),
                FadeInUp(animate: animate,child: const Square(),),
                FadeInDown(animate: animate,child: const Square(),),
                FadeInLeft(animate: animate,child: const Square(),),
                FadeInRight(animate: animate,child: const Square(),),

              ],
            ),


          ],
        ),
      ),
    );
  }
}
```

### Note: Square, is just a Square blue container

```
class Square extends StatelessWidget {
  const Square({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: const Color(0xff67549B),
    );
  }
}

```

## Events

There is a new property called `onFinish` that is called when the animation finishes. It returns a value of type `AnimateDoDirection` indicating the direction of the animation (forward or backward).

### Example:

**Sugar syntax**

```
const Square()
  .fadeIn(animate: animate,
      delay: const Duration(milliseconds: 100),
      onFinish: (direction) => print('$direction'),
  ),
```

**Classic syntax**

```
FadeIn(
  animate: animate,
  delay: const Duration(milliseconds: 100),
  onFinish: (direction) => print('$direction'),
  child: const Square(),
),
```

## Manual Trigger

There is a way to get the AnimationController used inside the animation, which lets you control the animation by restarting it, changing its duration, repeating it, etc.

However, with all the new features added, this is not needed for the majority of users, but if you need it, here is how to do it.

**Important:** If you decide to go for the manual trigger, you have to control the animation entirely, which means running controller.forward() and controller.reverse() manually.

Usually it's easier now to use the animate property and just toggle it to true or false to trigger the animation.

#### Example

```
class FadeOutDownBig extends StatelessWidget/StatefulWidget {

AnimationController animateController;
...
...
...

child: FadeInUp(

    // (optional) if true, will not fire the animation on load
    manualTrigger: true,

    //(optional, but mandatory if you use manualTrigger:true) This callback exposes the AnimationController used for the selected animation. Then you can call animationController.forward() to trigger the animation wherever you like manually.
    controller: ( controller ) => animateController = controller,

    child: YourWidget(),

```

### More examples

Check the [**repository for more examples**](https://github.com/Klerith/animate_do_package), or the example folder inside the package.

Don't forget to like the package if you find it useful, and if you have any suggestion, please let me know.
