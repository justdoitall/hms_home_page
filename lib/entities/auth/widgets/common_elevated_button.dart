import 'package:flutter/material.dart';

class CommonElevateButton extends StatelessWidget {
  const CommonElevateButton(
      {super.key,
      required this.onPressed,
      this.isDisabled = false,
      required this.child});

  final bool isDisabled;
  final Function onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Builder(
        builder: (context) {
          return ElevatedButton(
              onPressed: isDisabled
                  ? null
                  : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      onPressed();
                    },
              child: isDisabled
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : child);
        },
      ),
    );
  }
}
