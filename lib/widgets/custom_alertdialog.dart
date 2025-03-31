import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final text;
  final textfontSize;
  final textColor;
  final buttontextcolor;
  final buttontext;
  final textfontweight;
  final buttonbgcolor;
  final buttontextsize;
  const CustomAlertDialog({Key? key, this.textfontSize, this.textColor, this.buttontextcolor, this.buttontext, this.textfontweight, this.buttonbgcolor, this.text, this.buttontextsize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Center(
        child: Text(
          text,
          maxLines: 3,
          style:
          TextStyle(fontSize: 14, fontWeight: textfontweight, color: textColor),
        ),
      ),
      actions: <Widget>[
        Center(
          child: InkWell(
            child: Container(
              width: 238,
              height: 48,
              decoration:  BoxDecoration(
                  color: buttonbgcolor,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              child:  Center(
                child: Text(
                  buttontext,
                  style: TextStyle(
                      fontSize: buttontextsize, color: buttontextcolor, fontWeight: textfontweight),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}