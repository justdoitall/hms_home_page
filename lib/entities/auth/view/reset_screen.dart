import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key, required this.from});

  final String from;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final inputsList = [
      CommonFormInput(inputKey: "Код потверждения", label: "Код потверждения")
    ];
    return Column(
      children: [
        const Header(title: "Восстановление\nпароля"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("На вашу почту было отправлено сообщение с кодом"),
              CommonForm(
                inputsList: inputsList,
                formKey: formKey,
              ),
              const SizedBox(
                height: 20,
              ),
              // TextButton(
              //     style: TextButton.styleFrom(
              //       minimumSize: Size.zero, // Set this
              //       padding: EdgeInsets.zero, // and this
              //     ),
              //     onPressed: () {
              //       context.push('/sms-reset');
              //     },
              //     child: const Text("Нет доступа к почте")),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                      onPressed: () {
                        final data = {
                          for (var v in inputsList)
                            v.inputKey: v.controller.text
                        };
                        if (formKey.currentState!.validate()) {
                          for (var element in inputsList) {
                            print(element.controller.text);
                            print("FROM: $from");
                          }
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
