import 'package:flutter/material.dart';


class Button extends StatelessWidget { //Create Uniformed Button for Login and Registration

  final String text;
  final Function handler;

  Button(this.text, this.handler);
  @override
  Widget build(BuildContext context) {
    return Container(
  height: 50.0,
  constraints: BoxConstraints(maxWidth: 350.0, maxHeight: 40.0),
  child: Card(
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) ),
      child: RaisedButton(
      onPressed: handler,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xff374ABE), Color(0xff64B6FF)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15)
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 350.0, maxHeight: 150.0),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    ),
  ),
);
  }
}