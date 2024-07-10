import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
import 'package:hms_app/repositories/data_service.dart';
import 'package:hms_app/state/verification_state/verification_cubit.dart';

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key, required this.from});

  final String from;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final input = CommonFormInput(
        inputKey: "code", label: "Код потверждения", isValidated: true);
    return BlocProvider(
      create: (context) =>
          VerificationCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<VerificationCubit, VerificationState>(
          builder: (context, state) {
            return state.when(
                initial: () =>
                    ResetScreenLayout(input: input, formKey: formKey),
                loading: () =>
                    ResetScreenLayout(input: input, formKey: formKey),
                success: (r) =>
                    ResetScreenLayout(input: input, formKey: formKey),
                error: (e) =>
                    ResetScreenLayout(input: input, formKey: formKey));
          },
          listener:(context, state) {
            state.when(initial: (){}, loading: (){}, success: (r){
              context.push("/change-password");
            }, error: (e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
            });
          },),
    );
    //ResetScreenLayout(input: input, formKey: formKey);
  }
}

class ResetScreenLayout extends StatelessWidget {
  const ResetScreenLayout({
    super.key,
    required this.input,
    required this.formKey,
  });

  final CommonFormInput input;
  final GlobalKey<FormState> formKey;

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
              const Text("На вашу почту было отправлено сообщение с кодом"),
              CommonForm(
                inputsList: [input],
                formKey: formKey,
              ),
              const SizedBox(
                height: 20,
              ),
              CommonElevateButton(
                  onPressed: () {
                    final data = input.controller.text;
                    if (formKey.currentState!.validate()) {
                      context.read<VerificationCubit>().getPassVerification(data);
                    }
                  },
                  child: const Text("Отправить код подтвержения")),
              const SizedBox(
                height: 12,
              ),
              CommonTextButton(
                onPressed: () {
                  final service = DataService();
                  service.logOut();
                  context.go('/login');
                },
                child: const Text("Вернуться"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
