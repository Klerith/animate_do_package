# animate_do

An animation package inspired in [Animate.css](https://daneden.github.io/animate.css/), build using only Flutter animations, no extra packages.

## Getting Started

This package is very simple to use, all the animations are Widgets that contains a ```duration``` (type Duration), ```delay``` (type Duration) and recieves a ```child``` widget (The widget you want to animate)

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

## Example

```
home: Scaffold(
    body: Center(

        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

            FadeInLeft(child: Rectangulo() ),
            FadeInUp(child: Rectangulo() ),
            FadeInDown(child: Rectangulo() ),
            FadeInRight(child: Rectangulo() ),
            
        ],
        ),

    ),
),

```

### Note: Rectangulo, is just a Square blue container
```
class Rectangulo extends StatelessWidget {

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

![alt text](https://res.cloudinary.com/dx0pryfzn/image/upload/v1582046881/x2fqhn05vshgbienhrow.gif "Animate_do")



## Manual Trigger
Since version ```1.2.0```, there is a way to get the AnimationController easily, so you can restart it, change the duration, do the animation again.

#### Example 
```
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
