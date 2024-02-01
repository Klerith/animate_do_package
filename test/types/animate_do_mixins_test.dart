import 'package:animate_do/src/types/animate_do_mixins.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';



class MockAnimatedState extends Mock with AnimateDoState {}

void main() {
  group('AnimatedDoState Mixin', () {
    final mockAnimatedState = MockAnimatedState();

    test('Test the AnimateDoMixins Props', () {
      expect(mockAnimatedState.disposed, false);
      //Todo: test the late AnimationController controller;
    });

    test('Test the AnimateDoMixins ConfigAnimation Method', () {
      mockAnimatedState.configAnimation(
        delay: Duration.zero,
        animate: true,
        manualTrigger: true,
        infinite: true,
        onFinish: () {},
        controllerCallback: (controller) {},
      );



    });
  });
}
