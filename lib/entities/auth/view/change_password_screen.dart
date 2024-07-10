import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/change_password_state/change_password_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final inputList = [
      CommonFormInput(
          inputKey: "password",
          label: "Пароль",
          isObscure: true,
          isValidated: true),
      CommonFormInput(
          inputKey: "password-repeat",
          label: "Повторите пароль",
          repeatedTo: "password",
          isObscure: true,
          isValidated: true)
    ];

    final formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        GetIt.I<InterfaceAuthRepository>(),
      ),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return state.when(
              initial: () => ChangePasswordScreenLayout(
                  inputList: inputList, formKey: formKey),
              loading: () => ChangePasswordScreenLayout(
                  inputList: inputList, formKey: formKey, state: "loading",),
              success: (r) => const Placeholder(),
              error: (e) =>ChangePasswordScreenLayout(
                  inputList: inputList, formKey: formKey),);
        },
        listener: (context, state) {
          state.when(
              initial: () {}, loading: () {}, success: (r) {
                context.go("/chat");
              }, error: (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
              });
        },
      ),
    );
  }
}

class ChangePasswordScreenLayout extends StatelessWidget {
  const ChangePasswordScreenLayout(
      {super.key,
      required this.inputList,
      required this.formKey,
      this.state = "initial"});

  final List<CommonFormInput> inputList;
  final GlobalKey<FormState> formKey;
  final String state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(title: "Восстановление\nпароля"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonForm(
                inputsList: inputList,
                formKey: formKey,
                isDisabled: state == "loading",
              ),
              const SizedBox(height: 12,),
              CommonElevateButton(
                  isDisabled: state == "loading",
                  onPressed: () {
                    final data = inputList[0].controller.text;
                    if (formKey.currentState!.validate()) {
                      context.read<ChangePasswordCubit>().changePassword(data);
                    }
                  },
                  child: const Text("Изменить пароль")),
              const SizedBox(
                height: 12,
              ),
              CommonTextButton(
                  onPressed: () {
                    try {
                      context.pop();
                    } catch (e) {
                      context.go("/login");
                    }
                  },
                  child: const Text("Вернуться")),
            ],
          ),
        )
      ],
    );
  }
}
