import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:todo_app/screen/view.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      showNextButton: true,
      showDoneButton: true,
      done: const Text('Done'),
      onDone: ()=> Get.to(const HomePage()),
      next: const Icon(Icons.arrow_forward),
      pages: [
        PageViewModel(
          image: SvgPicture.asset('assets/todosvg1.svg'),
          title: 'Todo App',
          body: 'Make Schedules'
        ),
        PageViewModel(
          image: SvgPicture.asset('assets/todosvg2.svg'),
          title: 'Todo App',
          body: 'Stay up to dated'
        )
      ],
    );
  }
}
