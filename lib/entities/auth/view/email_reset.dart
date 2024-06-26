import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';

class EmailReset extends StatefulWidget {
  const EmailReset({super.key});

  @override
  State<EmailReset> createState() => _EmailResetState();
}

class _EmailResetState extends State<EmailReset> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final input = CommonFormInput(inputKey: "Email", label: "Email");

    return Column(
      children: [
        const Header(title: "Восстановление\nпароля"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonForm(
                inputsList: [input],
                formKey: formKey,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero, // Set this
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () {
                    context.push('/sms-reset');
                  },
                  child: const Text("Нет доступа к почте")),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        final data = input.controller.text;
                        if (formKey.currentState!.validate()) {
                          context.pushNamed("reset",
                              queryParameters: {"from": "email"});
                        }
                      },
                      child: const Text("Отправить код подтвержения"))),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Вернуться"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
