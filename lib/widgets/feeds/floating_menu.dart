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
  Animation<Color?>? _buttonColor;
  Animation<Color?>? _foregroundColor;
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
    _buttonColor = ColorTween(begin: Colors.purpleAccent, end: Colors.white)
        .animate(CurvedAnimation(
            parent: _animationController!,
            curve: Interval(0, 1, curve: Curves.linear)));
    _foregroundColor = ColorTween(begin: Colors.white, end: Colors.purpleAccent)
        .animate(CurvedAnimation(
            parent: _animationController!,
            curve: Interval(0, 1, curve: Curves.linear)));
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Widget buttonInvite() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'btn1',
        elevation: 0,
        onPressed: () {},
        child: Icon(Icons.group_add),
      ),
    );
  }

  Widget buttonWrite() {
    return Container(
      child: FloatingActionButton(
        heroTag: 'btn2',
        elevation: 0,
        onPressed: () {
          Navigator.of(context).pushNamed('/home/write-post-screen');
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
          heroTag: 'btn3',
          elevation: 0,
          backgroundColor: _buttonColor!.value,
          foregroundColor: _foregroundColor!.value,
          onPressed: animate,
          child: AnimatedIcon(
              icon: AnimatedIcons.menu_close, progress: _animationIcon!)),
    );
  }

  animate() {
    if (!isOpened) {
      _animationController!.forward();
    } else
      _animationController!.reverse();
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform:
              Matrix4.translationValues(0, _translateButton!.value * 2, 0),
          child: buttonWrite(),
        ),
        Transform(
          transform:
              Matrix4.translationValues(0, _translateButton!.value * 1, 0),
          child: buttonInvite(),
        ),
        buttonToggle()
      ],
    );
  }
}
