import 'package:confereshop/pages/tab_page.dart';
import 'package:confereshop/services/page_transition.dart';
import 'package:confereshop/widgets/sliding_widget.dart';
import 'package:confereshop/widgets/theme.dart';
import 'package:flutter/material.dart';


class IntroPage extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            'assets/imgs/background.png',
            fit: BoxFit.fill,
            color: CustomsColors.customBlueI,
            colorBlendMode: BlendMode.hardLight,
          ),
        ),
        Positioned(
          child: Container(
            height: width * 0.1,
            width: width * 0.1,
            decoration: ShapeDecoration(
                shape: CircleBorder(),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF00FFDC),
                    const Color(0xFF5096FE),
                  ],
                )),
          ),
          top: 100,
          left: 20,
        ),
        Positioned(
          top: height * 0.2,
          child: Column(
            children: <Widget>[
              ScaleTransition(
                scale: _animationController.drive(
                  Tween<double>(begin: 0.3, end: 1.0).chain(
                    CurveTween(
                      curve: Interval(0.0, 0.2, curve: Curves.elasticInOut),
                    ),
                  ),
                ),
                child: FadeTransition(
                  opacity: _animationController.drive(
                    Tween<double>(begin: 0.0, end: 1.0).chain(
                      CurveTween(
                        curve: Interval(0.2, 0.4, curve: Curves.decelerate),
                      ),
                    ),
                  ),
                  child: ScaleTransition(
                    scale: _animationController.drive(
                      Tween<double>(begin: 1.3, end: 1.0).chain(
                        CurveTween(
                          curve: Interval(0.2, 0.4, curve: Curves.elasticInOut),
                        ),
                      ),
                    ),
                    child: Container(
                      width: width * 0.4,
                      height: width * 0.4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/imgs/logo2.png',
                          )
                        )
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              FadingSlidingWidget(
                animationController: _animationController,
                interval: const Interval(0.5, 0.9),
                child: Text(
                  'Olá, Seja Bem-Vindo(a)',
                  style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: width * 0.065,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.2,
              ),
              Container(
                width: width * 0.9,
                child: FadingSlidingWidget(
                  animationController: _animationController,
                  interval: const Interval(0.7, 1.0),
                  child: Text(
                    'Gerencie os seus produtos com\nfacilidade\n\nJosé Maria - Flutter DEV',
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: width * 0.050,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, SlideRightRoute(page: TabPage()));
              },
              child: FadingSlidingWidget(
                animationController: _animationController,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  alignment: Alignment.center,
                  width: width * 0.8,
                  height: height * 0.075,
                  child: Text(
                    'Começar',
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.1),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        CustomsColors.customBlueI,
                        CustomsColors.customBlueII,
                        CustomsColors.customBlueIII,
                      ]
                          
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}