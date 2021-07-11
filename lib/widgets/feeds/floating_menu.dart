import 'package:flutter/material.dart';

class FloatingMenu extends StatefulWidget {
  const FloatingMenu({Key? key}) : super(key: key);

  @override
  _FloatingMenuState createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController? _animationController;
  Animation<Color>? _buttonColor;
  Animation<double>? _animationIcon;
  Animation<double>? _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animationIcon =
        Tween<double>(begin: 0, end: 1).animate(_animationController!);
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController!,
            curve: Interval(0, 0.75, curve: _curve)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Widget buttonAdd() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buttonInvite() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.group_add),
      ),
    );
  }

  Widget buttonWrite() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget buttonWrite() {
    return Container(
      child: FloatingActionButton(
          onPressed: animate,
          child: AnimatedIcon(
              icon: AnimatedIcons.menu_close, progress: _animationIcon!)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform:
              Matrix4.translationValues(0, _translateButton.value * 3, 0),
          child: buttonAdd(),
        )
      ],
    );
  }
}
