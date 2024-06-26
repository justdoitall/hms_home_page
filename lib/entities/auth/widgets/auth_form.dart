import 'package:flutter/material.dart';
import 'package:hms_app/theme/theme.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(
      {super.key,
      required this.formKey,
      required this.passwordController,
      required this.loginController});
  final GlobalKey<FormState> formKey;
  final TextEditingController loginController;
  final TextEditingController passwordController;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration:
                CustomInputDecoration(hintText: "Номер телефона / почта"),
            controller: widget.loginController,
            validator: (value) {
              // String pattern = r'@';
              // RegExp regex = RegExp(pattern);
              if (value == null || value.isEmpty) {
                return 'Введите номер телефона или почту';
              } 
              // else if (!regex.hasMatch(value)) {
              //   return "Некорректный Email адрес";
              // }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: CustomInputDecoration(hintText: "Пароль"),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: widget.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Введите пароль';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
