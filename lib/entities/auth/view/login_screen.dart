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
    return BlocProvider(
      create: (context) => AuthCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<AuthCubit, AuthCubitState>(builder: (context, state) {
        return state.when(initial: () {
          return const ScreenLayout();
        }, loading: () {
          return const Center(
              child: SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator()));
        }, success: (auth) {
          return const ScreenLayout();
        }, error: (e) {
          return const ScreenLayout();
        });
      }, listener: (context, state) {
        state.when(
            initial: () {},
            loading: () {},
            success: (token) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('TOKEN:${token.access}'),
                  duration: const Duration(seconds: 5),
                ),
              );
              context.go("/profile");
            },
            error: (e) {
              ScaffoldMessenger.of(context).showSnackBar(
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
  const ScreenLayout({
    super.key,
  });

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  @override
  Widget build(BuildContext context) {
    final loginController = TextEditingController();
    final passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    @override
    void dispose() {
      loginController.dispose();
      passwordController.dispose();

      super.dispose();
    }

    return Column(
      children: [
        const Header(
          title: "Вход в\nприложение",
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              AuthForm(
                  formKey: formKey,
                  passwordController: passwordController,
                  loginController: loginController),
              TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero, // Set this
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () {
                    context.push('/email-reset');
                  },
                  child: const Text("Забыли пароль?")),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().getAuth(
                            loginController.text, passwordController.text);
                      }
                    },
                    child: const Text("Войти")),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: TextButton(
                  onPressed: () {
                    context.push('/onboarding');
                  },
                  child: const Text("Зарегистрироваться"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
