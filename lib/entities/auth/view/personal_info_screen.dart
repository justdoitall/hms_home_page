import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/personal_data_state/personal_data_cubit.dart';
import 'package:hms_app/theme/theme.dart';

class PersonalInfoInputScreen extends StatelessWidget {
  const PersonalInfoInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);

    final TextEditingController nameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    final TextEditingController heightController = TextEditingController();

    return BlocProvider(
      create: (context) =>
          PersonalDataCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<PersonalDataCubit, PersonalDataState>(
        builder: (context, state) {
          final List<CommonFormInput> inputsList = [
            CommonFormInput(
                inputKey: "name",
                label: "Ваше имя",
                fixedController: nameController,
                isValidated: true),
            CommonFormInput(
                inputKey: "lastName",
                label: "Ваша фамилия",
                fixedController: lastNameController,
                isValidated: true),
            CommonFormInput(
                inputKey: "weight",
                isValidated: true,
                label: "Ваш вес",
                isNumber: true,
                callback: (value) {
                  final string =
                      (value as String).replaceAll(RegExp('[a-zA-Z]+'), "");
                  context.read<PersonalDataCubit>().setWeight(string);
                  context.read<PersonalDataCubit>().getBodyMassIndex();
                },
                fixedController: weightController),
            CommonFormInput(
                inputKey: "height",
                label: "Ваш рост",
                isValidated: true,
                isNumber: true,
                callback: (value) {
                  final string =
                      (value as String).replaceAll(RegExp('[a-zA-Z]+'), "");
                  context.read<PersonalDataCubit>().setHeight(string);
                  context.read<PersonalDataCubit>().getBodyMassIndex();
                },
                fixedController: heightController),
          ];

          if (state is LoadingState) {
            return PersonalDataLayout(
              theme: theme,
              inputsList: inputsList,
              formKey: formKey,
              state: "loading",
            );
          }
          if (state is SuccessState) {
            return const SizedBox();
          }
          if (state is ErrorState) {
            return PersonalDataLayout(
              theme: theme,
              inputsList: inputsList,
              formKey: formKey,
            );
          }

          if (state is InitialState) {
            return PersonalDataLayout(
              theme: theme,
              inputsList: inputsList,
              formKey: formKey,
              bodyMassIndex: state.bodyMassIndex,
              isPolicyAgreed: state.isPolicyAgreed,
            );
          }
          return PersonalDataLayout(
            theme: theme,
            inputsList: inputsList,
            formKey: formKey,
          );
        },
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is SuccessState) {
            context.go('/chat');
          }
        },
      ),
    );
  }
}

class PersonalDataLayout extends StatelessWidget {
  const PersonalDataLayout(
      {super.key,
      this.state = "initial",
      required this.theme,
      required this.inputsList,
      required GlobalKey<FormState> formKey,
      this.bodyMassIndex = 0,
      this.isPolicyAgreed = false})
      : _formKey = formKey;

  final ThemeData theme;
  final List<CommonFormInput> inputsList;
  final GlobalKey<FormState> _formKey;

  final String state;

  final num bodyMassIndex;
  final bool isPolicyAgreed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 52,
        ),
        Text(
          "Еще минутку!",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          child: Column(
            children: [
              const Text(
                  textAlign: TextAlign.justify,
                  "Мы заметили, что вы у нас в первый раз, для того чтобы приложения работало правильно нам нужно чтобы Вы заполнили свои данные"),
              const SizedBox(
                height: 24,
              ),
              CommonForm(
                inputsList: inputsList,
                formKey: _formKey,
                isDisabled: state == "loading",
              ),
              const SizedBox(
                height: 12,
              ),
              const Text("Индекс массы тела"),
              TextField(
                enabled: false,
                style: const TextStyle(color: Colors.white),
                decoration: CustomInputDecorationDisabled(
                    hintText: "Начните вводить вес и рост"),
                controller: TextEditingController.fromValue(TextEditingValue(
                    text: bodyMassIndex < 5
                        ? "Начните вводить вес и рост"
                        : bodyMassIndex.toStringAsFixed(3))),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Checkbox(
                    value: isPolicyAgreed,
                    onChanged: (value) {
                      context.read<PersonalDataCubit>().setPolicyAgreement();
                    },
                  ),
                  InkWell(
                    onTap: () {
                      context.push("/policy");
                    },
                    child: const Text(
                        "Я согласен с правилами обработки\nперсональных данных"),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              CommonElevateButton(
                isDisabled: state == "loading",
                onPressed: () {
                  final data = {
                    for (var v in inputsList) v.inputKey: v.fixedController!.text
                  };
                  print(data);
                  if (_formKey.currentState!.validate()) {
                    if (isPolicyAgreed) {
                      final PersonalData registrationData = PersonalData(
                          lastName: data["lastName"]!,
                          name: data["name"]!,
                          weight: data["weight"]!,
                          height: data["height"]!);
                      context
                          .read<PersonalDataCubit>()
                          .setPersonalData(registrationData);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "Потвердите, что ознакомились с политикой конфиденциальности")));
                    }
                  }
                },
                child: const Text("Завершить регистрацию"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
