import 'package:animate_do/animate_do.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wraps [child] in a minimal `Directionality` so widgets that build
/// `Text` or other directional widgets do not crash inside the test harness.
Widget wrap(Widget child) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: child,
  );
}

const Key _childKey = Key('animated-child');

Widget _testChild() => const SizedBox(key: _childKey, width: 10, height: 10);

void main() {
  group('Public API exports', () {
    testWidgets('every animation widget renders its child', (tester) async {
      final List<Widget> animations = <Widget>[
        FadeIn(child: _testChild()),
        FadeInDown(child: _testChild()),
        FadeInDownBig(child: _testChild()),
        FadeInUp(child: _testChild()),
        FadeInUpBig(child: _testChild()),
        FadeInLeft(child: _testChild()),
        FadeInLeftBig(child: _testChild()),
        FadeInRight(child: _testChild()),
        FadeInRightBig(child: _testChild()),
        FadeOut(child: _testChild()),
        FadeOutDown(child: _testChild()),
        FadeOutUp(child: _testChild()),
        FadeOutLeft(child: _testChild()),
        FadeOutRight(child: _testChild()),
        BackInUp(child: _testChild()),
        BackInDown(child: _testChild()),
        BackInLeft(child: _testChild()),
        BackInRight(child: _testChild()),
        BackOutUp(child: _testChild()),
        BackOutDown(child: _testChild()),
        BackOutLeft(child: _testChild()),
        BackOutRight(child: _testChild()),
        BounceIn(child: _testChild()),
        BounceInDown(child: _testChild()),
        BounceInUp(child: _testChild()),
        BounceInLeft(child: _testChild()),
        BounceInRight(child: _testChild()),
        ElasticIn(child: _testChild()),
        ElasticInDown(child: _testChild()),
        ElasticInUp(child: _testChild()),
        ElasticInLeft(child: _testChild()),
        ElasticInRight(child: _testChild()),
        SlideInUp(child: _testChild()),
        SlideInDown(child: _testChild()),
        SlideInLeft(child: _testChild()),
        SlideInRight(child: _testChild()),
        FlipInX(child: _testChild()),
        FlipInY(child: _testChild()),
        ZoomIn(child: _testChild()),
        ZoomInDown(child: _testChild()),
        ZoomOut(child: _testChild()),
        MoveTo(top: 10, child: _testChild()),
        MoveToArc(top: 10, child: _testChild()),
      ];

      for (final Widget animation in animations) {
        await tester.pumpWidget(wrap(animation));
        await tester.pump(const Duration(milliseconds: 1));
        expect(
          find.byKey(_childKey),
          findsOneWidget,
          reason: '${animation.runtimeType} should render its child',
        );
      }
    });
  });

  group('AnimateDoBaseWidget invariants', () {
    test('manualTrigger=true without controller throws assertion', () {
      expect(
        () => FadeIn(manualTrigger: true, child: _testChild()),
        throwsAssertionError,
      );
    });
  });

  group('FadeIn lifecycle', () {
    testWidgets('starts hidden and fades to fully visible', (tester) async {
      await tester.pumpWidget(
        wrap(
          FadeIn(
            duration: const Duration(milliseconds: 300),
            child: _testChild(),
          ),
        ),
      );

      Opacity opacity = tester.widget(find.byType(Opacity));
      expect(opacity.opacity, lessThan(0.05));

      await tester.pump(const Duration(milliseconds: 150));
      opacity = tester.widget(find.byType(Opacity));
      expect(opacity.opacity, greaterThan(0));
      expect(opacity.opacity, lessThan(1));

      await tester.pump(const Duration(milliseconds: 200));
      opacity = tester.widget(find.byType(Opacity));
      expect(opacity.opacity, 1);
    });

    testWidgets('does not start when animate is false', (tester) async {
      await tester.pumpWidget(
        wrap(
          FadeIn(
            animate: false,
            duration: const Duration(milliseconds: 100),
            child: _testChild(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 200));
      final Opacity opacity = tester.widget(find.byType(Opacity));
      expect(opacity.opacity, 0);
    });

    testWidgets('reacts to animate toggle via didUpdateWidget', (tester) async {
      Widget build({required bool animate}) {
        return wrap(
          FadeIn(
            animate: animate,
            duration: const Duration(milliseconds: 100),
            child: _testChild(),
          ),
        );
      }

      await tester.pumpWidget(build(animate: false));
      await tester.pump(const Duration(milliseconds: 200));
      expect((tester.widget(find.byType(Opacity)) as Opacity).opacity, 0);

      await tester.pumpWidget(build(animate: true));
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pumpAndSettle();
      expect((tester.widget(find.byType(Opacity)) as Opacity).opacity, 1);
    });

    testWidgets('respects delay before starting', (tester) async {
      await tester.pumpWidget(
        wrap(
          FadeIn(
            delay: const Duration(milliseconds: 100),
            duration: const Duration(milliseconds: 100),
            child: _testChild(),
          ),
        ),
      );

      await tester.pump(const Duration(milliseconds: 50));
      expect((tester.widget(find.byType(Opacity)) as Opacity).opacity, 0);

      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 150)),
      );
      await tester.pumpAndSettle();
      expect((tester.widget(find.byType(Opacity)) as Opacity).opacity, 1);
    });
  });

  group('Manual trigger', () {
    testWidgets('does not start automatically and exposes controller',
        (tester) async {
      AnimationController? exposed;

      await tester.pumpWidget(
        wrap(
          FadeIn(
            manualTrigger: true,
            duration: const Duration(milliseconds: 100),
            controller: (AnimationController c) => exposed = c,
            child: _testChild(),
          ),
        ),
      );

      expect(exposed, isNotNull);
      await tester.pump(const Duration(milliseconds: 200));
      expect((tester.widget(find.byType(Opacity)) as Opacity).opacity, 0);

      exposed!.forward();
      await tester.pumpAndSettle();
      expect((tester.widget(find.byType(Opacity)) as Opacity).opacity, 1);
    });
  });

  group('onFinish callback', () {
    testWidgets('fires with forward direction on completion', (tester) async {
      AnimateDoDirection? received;

      await tester.pumpWidget(
        wrap(
          FadeIn(
            duration: const Duration(milliseconds: 100),
            onFinish: (AnimateDoDirection direction) => received = direction,
            child: _testChild(),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(received, AnimateDoDirection.forward);
    });
  });

  group('Disposal safety', () {
    testWidgets('disposing during a delay does not throw', (tester) async {
      await tester.pumpWidget(
        wrap(
          FadeIn(
            delay: const Duration(seconds: 5),
            duration: const Duration(milliseconds: 100),
            child: _testChild(),
          ),
        ),
      );

      await tester.pumpWidget(wrap(const SizedBox.shrink()));
      await tester.pump(const Duration(seconds: 6));
      expect(tester.takeException(), isNull);
    });
  });

  group('AnimateDoDirection enum', () {
    test('has both forward and backward values', () {
      expect(AnimateDoDirection.values, hasLength(2));
      expect(AnimateDoDirection.forward.name, 'forward');
      expect(AnimateDoDirection.backward.name, 'backward');
    });
  });
}
