import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/Components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  AnimationController controller_logo, controller2;
  Animation animation, animation2;

  @override
  void initState() {
    super.initState();

    controller_logo = AnimationController(
        duration: Duration(seconds: 1), upperBound: 0.7, vsync: this);
    animation =
        CurvedAnimation(parent: controller_logo, curve: Curves.bounceInOut);

    controller2 =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation2 = ColorTween(begin: Colors.blueAccent, end: Colors.teal)
        .animate(controller2);

    controller_logo.forward();
    //loop for animation small to big and big to small:
    // controller_logo.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller_logo.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller_logo.forward();
    //   }
    // });

    controller_logo.addListener(() {
      setState(() {});
      print(controller_logo.value);
    });
    controller2.forward();
    controller2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller_logo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation2.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: controller_logo.value * 100,
                    //60->100=controller.value*100
                  ),
                ),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 35.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('BroCode Talk',
                          speed: const Duration(milliseconds: 300))
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log in',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
