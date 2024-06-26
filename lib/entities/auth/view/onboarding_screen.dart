import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/onboarding_state/onboarding_cubit.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<CommonFormInput> inputsList = [
    CommonFormInput(
        isValidated: false, label: "Код входа в приложение", inputKey: "ref"),
    CommonFormInput(isValidated: false, label: "Почта", inputKey: "login"),
    CommonFormInput(
        isValidated: false,
        label: "Пароль",
        inputKey: "password",
        repeatedTo: "repeat-password",
        repeatValidationText: "Пароли не совпадают"),
    CommonFormInput(
        isValidated: false,
        label: "Повторите пароль",
        inputKey: "repeat-password",
        repeatedTo: "password",
        repeatValidationText: "Пароли не совпадают")
  ];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            OnboardingCubit(GetIt.I<InterfaceAuthRepository>()),
        child: BlocConsumer<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return state.when(
                initial: () =>
                    OnboardingLayout(inputsList: inputsList, formKey: _formKey),
                loading: () =>
                    CircularProgressIndicator(),
                success: (r) =>
                    OnboardingLayout(inputsList: inputsList, formKey: _formKey),
                error: (e) => OnboardingLayout(
                    inputsList: inputsList, formKey: _formKey));
          },
          listener: (context, state) {
            state.when(
                initial: () {},
                loading: () {},
                success: (data) {
                  context.push('/verification');
                },
                error: (e) {
                  print(e);
                });
          },
        ));
  }
}

class OnboardingLayout extends StatelessWidget {
  const OnboardingLayout({
    super.key,
    required this.inputsList,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final List<CommonFormInput> inputsList;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(
          title: "Вход в\nприложение",
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              CommonForm(
                inputsList: inputsList,
                formKey: _formKey,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      final data = {
                        for (var v in inputsList) v.inputKey: v.controller.text
                      };
                      if (_formKey.currentState!.validate()) {
                        final RegistrationData registrationData =
                            RegistrationData(
                                login: data["login"]!,
                                password: data["password"]!,
                                referealCode: data["ref"]!);
                        context
                            .read<OnboardingCubit>()
                            .getRegistration(registrationData);
                      }
                    },
                    child: const Text("Зарегистрироваться")),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: const Text("Войти"),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
