import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/auth_state/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CommonFormInput> inputsList = [
      CommonFormInput(inputKey: "login", label: "Почта", isValidated: true),
      CommonFormInput(
          inputKey: "password",
          label: "Пароль",
          isObscure: true,
          isValidated: true),
    ];

    return BlocProvider(
      create: (context) => AuthCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<AuthCubit, AuthCubitState>(builder: (context, state) {
        return state.when(initial: () {
          return ScreenLayout(
            inputsList: inputsList,
          );
        }, loading: () {
          return ScreenLayout(
            inputsList: inputsList,
            state: 'loading',
          );
        }, success: (auth) {
          return ScreenLayout(
            inputsList: inputsList,
          );
        }, error: (e) {
          return ScreenLayout(
            inputsList: inputsList,
          );
        });
      }, listener: (context, state) {
        state.when(
            initial: () {},
            loading: () {},
            success: (token) {
              for (var element in inputsList) {
                element.controller.text = "";
              }
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  content: Text('TOKEN:${token.access}'),
                  duration: const Duration(seconds: 5),
                ),
              );
              context.go("/profile");
            },
            error: (e) {
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  content: Text(e),
                  duration: const Duration(seconds: 5),
                ),
              );
            });
      }),
    );
  }
}

class ScreenLayout extends StatefulWidget {
  const ScreenLayout(
      {super.key, this.state = "initial", required this.inputsList});
  final String? state;
  final List<CommonFormInput> inputsList;
  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    logIn() {
      final data = {
        for (var v in widget.inputsList) v.inputKey: v.controller.text
      };
      if (formKey.currentState!.validate()) {
        context.read<AuthCubit>().getAuth(data["login"]!, data["password"]!);
      }
    }

    return Column(
      children: [
        const Header(
          title: "Вход в\nприложение",
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonForm(
                inputsList: widget.inputsList,
                formKey: formKey,
                isDisabled: widget.state != null && widget.state == "loading",
              ),
              CommonTextButton(
                isSmall: true,
                onPressed: () {
                  context.push('/email-reset');
                },
                child: const Text("Забыли пароль?"),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonElevateButton(
                isDisabled: widget.state != null && widget.state == "loading",
                onPressed: logIn,
                child: const Text("Войти"),
              ),
              const SizedBox(
                height: 10,
              ),
              CommonTextButton(
                  onPressed: () {
                    context.push('/onboarding');
                  },
                  child: const Text("Зарегистрироваться"))
            ],
          ),
        ),
      ],
    );
  }
}
