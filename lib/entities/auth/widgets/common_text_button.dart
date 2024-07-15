import 'package:flutter/material.dart';

class CommonTextButton extends StatelessWidget {
  const CommonTextButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.isSmall = false});
  final Function onPressed;
  final Widget child;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? null : MediaQuery.of(context).size.width,
      height: isSmall ? null : 60,
      child: TextButton(
          style: isSmall
              ? TextButton.styleFrom(
                  minimumSize: Size.zero, // Set this
                  padding: EdgeInsets.zero, // and this
                )
              : null,
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onPressed();
          },
          child: child),
    );
  }
}
