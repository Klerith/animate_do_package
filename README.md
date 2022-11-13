# animate_do 
## Null-Safety checked!

An animation package inspired in [Animate.css](https://daneden.github.io/animate.css/), built using only Flutter animations, no extra packages.

## Getting Started

This package is simple to use. Every single animation contains default values that look beautiful, but you can change properties to accomplish your needs.

## Properties in almost every animated widget:

| Property        | Type           | Description  |
| ------------- |-------------| -----|
| key | __Key__ | (optional) Widget key |
| child | __Widget__ | Child Widget to animate |
| duration | __Duration__ | Animation duration  |
| delay | __Duration__ | Delay before the animation |
| from | __double__ | Initial or final destination, if you want a slide or fade more striking |
| animate | __boolean__ | Change this property from false to true to starts the animation (useful if you use setState, Bloc, Provider, Redux or any other state management system) |
| infinite | __boolean__ | Attention seekers can be run infinitely with this property |
| spins | __double__ | The number of spins that you want (some animations have this, ex: Spin, Roulette, PerfectSpin )  |
| manualTrigger | __boolean__ | if you're going to trigger the animation manually (required the controller property)  |
| controller | __Function__ | Function that exposes the controller (for more control of the animation |


# Available **Animations**

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

## SlideIns Animations
- SlideInDown
- SlideInUp
- SlideInLeft
- SlideInRight

## FlipIn Animations
- FlipInX
- FlipInY

## Zooms
- ZoomIn
- ZoomOut

## SpecialIn Animations
- JelloIn

## Attention Seeker
All of the following animations could be infinite with a property called ```infinite``` (type Bool)
- Bounce
- Flash
- Pulse
- Swing
- Spin
- SpinPerfect
- Dance
- Roulette

## Example Basic 

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


## Example Basic #2 - Now with Toggle
Just toggle the __animate__ property to animate in or out easily.
Check the full code inside the example folder
```
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  bool launchAnimation = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            const Text('Now with a simple Toggle', style: TextStyle(fontSize: 20),),
            Text('Boolean animate value: $launchAnimation' ),
            const SizedBox(height: 20 ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FadeIn(child: const Square(), animate: launchAnimation,),
                FadeInUp(child: const Square(), animate: launchAnimation,),
                FadeInDown(child: const Square(), animate: launchAnimation,),
                FadeInLeft(child: const Square(), animate: launchAnimation,),
                FadeInRight(child: const Square(), animate: launchAnimation,),
                
              ],
            ),

            const SizedBox(height: 20 ),

            ElevatedButton(onPressed: () {
              setState(() {
                launchAnimation = !launchAnimation;
              });
            }, child: const Text('Toggle animation'))
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
      ),
    );
  }
}

```





![Animate_do demo animation](https://raw.githubusercontent.com/Klerith/animate_do_package/master/animate_do.gif "Animate_do")



## Manual Trigger
Since version ```1.2.0```, there is a way to get the AnimationController easily, so you can restart it, change the duration, do the animation again.

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

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
