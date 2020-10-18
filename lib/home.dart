import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  void toggle() {
    animationController.isDismissed
        ? animationController.forward()
        : animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
          curve: Curves.fastOutSlowIn, parent: animationController),
      builder: (context, child) {
        return Stack(
          children: [
            Container(color: Colors.orangeAccent),
            Transform.translate(
              offset: Offset(300 * (animationController.value - 1), 0),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(math.pi / 2 * (1 - animationController.value)),
                alignment: Alignment.centerRight,
                child: CustomDrawer(toggle: toggle),
              ),
            ),
            Transform.translate(
              offset: Offset(300 * animationController.value, 0),
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(-math.pi / 2 * animationController.value),
                alignment: Alignment.centerLeft,
                child: MyWidget(toggle: toggle),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MyWidget extends StatelessWidget {
  final Function toggle;

  MyWidget({this.toggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: toggle,
          icon: Icon(Icons.menu),
        ),
        title: Text('Animation'),
      ),
      body: Container(
        child: Center(
          child: Text('Transform'),
        ),
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Function toggle;

  CustomDrawer({this.toggle});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 300,
        color: Colors.redAccent,
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            IconButton(icon: Icon(Icons.menu), onPressed: toggle),
            FlutterLogo(size: 40),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.person, color: Colors.white, size: 40),
                SizedBox(width: 10),
                Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.settings, color: Colors.white, size: 40),
                SizedBox(width: 10),
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
