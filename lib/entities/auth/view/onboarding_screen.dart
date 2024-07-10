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
        isValidated: true, label: "Код входа в приложение", inputKey: "ref"),
    CommonFormInput(isValidated: true, label: "Почта", inputKey: "login"),
    CommonFormInput(
        isValidated: true,
        label: "Пароль",
        inputKey: "password",
        repeatedTo: "repeat-password",
        repeatValidationText: "Пароли не совпадают",
        isObscure: true),
    CommonFormInput(
        isValidated: true,
        label: "Повторите пароль",
        inputKey: "repeat-password",
        repeatedTo: "password",
        repeatValidationText: "Пароли не совпадают",
        isObscure: true)
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
                loading: () => OnboardingLayout(
                      inputsList: inputsList,
                      formKey: _formKey,
                      state: "loading",
                    ),
                success: (r) => const SizedBox(),
                error: (e) => OnboardingLayout(
                    inputsList: inputsList, formKey: _formKey));
          },
          listener: (context, state) {
            state.when(
                initial: () {},
                loading: () {},
                success: (data) {
                  for (var element in inputsList) {
                    element.controller.text = "";
                  }
                  context.push('/verification');
                },
                error: (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e),
                      duration: const Duration(seconds: 5),
                    ),
                  );
                });
          },
        ));
  }
}

class OnboardingLayout extends StatelessWidget {
  const OnboardingLayout({
    this.state = "initial",
    super.key,
    required this.inputsList,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final List<CommonFormInput> inputsList;
  final GlobalKey<FormState> _formKey;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(
          title: "Регистрация\nв приложении",
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              CommonForm(
                inputsList: inputsList,
                formKey: _formKey,
                isDisabled: state == "loading",
              ),
              const SizedBox(
                height: 10,
              ),
              CommonElevateButton(
                isDisabled: state == "loading",
                onPressed: () {
                  final data = {
                    for (var v in inputsList) v.inputKey: v.controller.text
                  };
                  if (_formKey.currentState!.validate()) {
                    final RegistrationData registrationData = RegistrationData(
                        login: data["login"]!,
                        password: data["password"]!,
                        referealCode: data["ref"]!);
                    context
                        .read<OnboardingCubit>()
                        .getRegistration(registrationData);
                  }
                },
                child: const Text("Зарегистрироваться"),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: const Text("Войти"))
            ],
          ),
        )
      ],
    );
  }
}
