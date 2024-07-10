import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/state/email_reset_state/email_reset_cubit.dart';

class EmailResetScreen extends StatefulWidget {
  const EmailResetScreen({super.key});

  @override
  State<EmailResetScreen> createState() => _EmailResetScreenState();
}

class _EmailResetScreenState extends State<EmailResetScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final input =
        CommonFormInput(inputKey: "email", label: "Email", isValidated: true);

    return BlocProvider(
      create: (context) => EmailResetCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<EmailResetCubit, EmailResetState>(
          builder: (context, state) {
        return state.when(initial: () {
          return EmailResetScreenLayout(input: input, formKey: formKey);
        }, loading: () {
          return EmailResetScreenLayout(
            input: input,
            formKey: formKey,
            state: "loading",
          );
        }, success: (r) {
          return const SizedBox();
        }, error: (e) {
          return EmailResetScreenLayout(input: input, formKey: formKey);
        });
      }, listener: (context, state) {
        state.when(
            initial: () {},
            loading: () {},
            success: (r) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(r.access),
                  duration: const Duration(seconds: 5),
                ),
              );
              context.pushNamed("reset", queryParameters: {"from": "email"});
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

class EmailResetScreenLayout extends StatelessWidget {
  const EmailResetScreenLayout(
      {super.key,
      required this.input,
      required this.formKey,
      this.state = "initial"});

  final CommonFormInput input;
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
                inputsList: [input],
                formKey: formKey,
                isDisabled: state == "loading",
              ),
              CommonTextButton(
                  isSmall: true,
                  onPressed: () {
                    context.push('/sms-reset');
                  },
                  child: const Text("Нет доступа к почте")),
              CommonElevateButton(
                  isDisabled: state == "loading",
                  onPressed: () {
                    final data = input.controller.text;
                    if (formKey.currentState!.validate()) {
                      context.read<EmailResetCubit>().resetPassword(data);
                    }
                  },
                  child: const Text("Отправить код подтвержения")),
              const SizedBox(
                height: 12,
              ),
              CommonTextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: const Text("Вернуться")),
            ],
          ),
        )
      ],
    );
  }
}
