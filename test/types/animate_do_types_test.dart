import 'package:animate_do/animate_do.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {

  test('should ensure the types AnimateDo Types', () {
         
    expect(AnimateDoDirection.forward.toString(), 'AnimateDoDirection.forward');
    expect(AnimateDoDirection.backward.toString(), 'AnimateDoDirection.backward');


  });


}