import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/personal_data_state/personal_data_cubit.dart';

String getBodyMassIndex(height, weight) {
  final num heightToMeter = height / 100;
  return (weight / ((heightToMeter * heightToMeter))).toString();
}

class PersonalInfoInputScreen extends StatefulWidget {
  const PersonalInfoInputScreen({super.key});

  @override
  State<PersonalInfoInputScreen> createState() =>
      _PersonalInfoInputScreenState();
}

class _PersonalInfoInputScreenState extends State<PersonalInfoInputScreen> {
  @override
  Widget build(BuildContext context) {

    final List<CommonFormInput> inputsList = [
      CommonFormInput(inputKey: "name", label: "Ваше имя"),
      CommonFormInput(inputKey: "lastName", label: "Ваша фамилия"),
      CommonFormInput(inputKey: "nickName", label: "Ваш никнейм"),
      CommonFormInput(
          inputKey: "weight",
          label: "Ваш вес",
         ),
      CommonFormInput(
          inputKey: "height",
          label: "Ваш рост",
          ),
    ];
    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) =>
          PersonalDataCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<PersonalDataCubit, PersonalDataState>(
        builder: (context, state) {
          return state.when(
              initial: () => PersonalDataLayout(
                  theme: theme,
                  inputsList: inputsList,
                  formKey: formKey,
                  ),
              loading: () => PersonalDataLayout(
                  theme: theme,
                  inputsList: inputsList,
                  formKey: formKey,
                  ),
              success: (r) => PersonalDataLayout(
                  theme: theme,
                  inputsList: inputsList,
                  formKey: formKey,
                  ),
              error: (e) => PersonalDataLayout(
                  theme: theme,
                  inputsList: inputsList,
                  formKey: formKey,
                  ));
        },
        listener: (context, state) {
          state.when(
              initial: () {}, loading: () {}, success: (r) {
                context.push('/chat');
              }, error: (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
              });
        },
      ),
    );
  }
}

class PersonalDataLayout extends StatelessWidget {
  const PersonalDataLayout({
    super.key,
    required this.theme,
    required this.inputsList,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final ThemeData theme;
  final List<CommonFormInput> inputsList;
  final GlobalKey<FormState> _formKey;

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
              CommonForm(inputsList: inputsList, formKey: _formKey),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                      final data = {
                        for (var v in inputsList) v.inputKey: v.controller.text
                      };
                      if (_formKey.currentState!.validate()) {
                        final PersonalData registrationData =
                            PersonalData(
                                lastName: data["lastName"]!,
                                name: data["name"]!,
                                nickName: data["nickName"]!,
                                weight: data["weight"]!,
                                height: data["height"]!
                                );
                        context
                            .read<PersonalDataCubit>()
                            .setPersonalData(registrationData);
                      }
                  },
                  child: const Text("Завершить регистрацию"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
