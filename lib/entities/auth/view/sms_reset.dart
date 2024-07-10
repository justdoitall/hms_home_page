import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';

class SmsReset extends StatelessWidget {
  const SmsReset({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final inputsList = [CommonFormInput(inputKey: "Телефон", label: "Телефон")];
    return Column(
      children: [
        const Header(title: "Восстановление\nпароля"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonForm(
                inputsList: inputsList,
                formKey: formKey,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero, // Set this
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () {
                    context.push("/tech-sup");
                  },
                  child: const Text("Нет доступа к телефону")),
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
                            context.pushNamed("reset",
                                queryParameters: {"from": "email"});
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
