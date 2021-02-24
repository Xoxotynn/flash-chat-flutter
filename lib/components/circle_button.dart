import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  CircleButton({@required this.onPressed, this.buttonIcon});

  final Function onPressed;
  final String buttonIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        shape: CircleBorder(),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          child: Container(
            child: Image.asset('images/google.png'),
            height: 40.0,
          ),
        ),
      ),
    );
  }
}
