import 'dart:async';
import 'package:confereshop/pages/intro/intro_page.dart';
import 'package:confereshop/pages/tab_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  bool isAnimatedImg = false;
  bool isAnimatedText = false;
  var imageI = Image.asset("assets/imgs/logo1.png");
  var imageII = Image.asset("assets/imgs/logo1.png");

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isAnimatedText = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isAnimatedImg = true;
        });

        Future.delayed(const Duration(milliseconds: 300), () async {

          Navigator.push(
            context,
            new PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              pageBuilder: (_, __, ___) => IntroPage(),
              transitionsBuilder: (context, animation1, animation2, child) {
                return FadeTransition(opacity: animation1, child: child);
              },
            ));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(child: child, scale: animation);
          },
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: <Widget>[
              Hero(
                tag: 'splash',
                child: Container(
                  height: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.center,
                  child: isAnimatedImg ? imageII : imageI,
                )
              ),

              Container(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: isAnimatedText && !isAnimatedImg ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 800),
                  child: Text('SHOP',
                    style: TextStyle(color: Colors.black, fontSize: 35.0, fontWeight: FontWeight.bold),
                  )
                ),
              )
            ],
          ),
        )
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
