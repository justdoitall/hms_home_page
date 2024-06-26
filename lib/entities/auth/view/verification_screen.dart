import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/interface_auth_repository.dart';
import 'package:hms_app/repositories/data_service.dart';
import 'package:hms_app/state/verification_state/verification_cubit.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VerificationCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return state.when(
              initial: () => VerificationLayout(),
              loading: () => CircularProgressIndicator(),
              success: (r) => VerificationLayout(),
              error: (e) => VerificationLayout());
        },
        listener: (context, state) {
          state.when(
              initial: () {},
              loading: () {},
              success: (token) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('TOKEN:${token.token.access}'),
                    duration: const Duration(seconds: 5),
                  ),
                );
                context.push('/personal-input');
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
      ),
    );
  }
}

class VerificationLayout extends StatelessWidget {
  const VerificationLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CommonFormInput input = CommonFormInput(
        inputKey: "verification-form", label: "Введите код потверждения");

    // @override
    // void dispose() {
    //   codeController.dispose();
    //   super.dispose();
    // }
    final formKey = GlobalKey<FormState>();
    final TextEditingController codeController = TextEditingController();
    return Column(
      children: [
        const Header(title: "Введите код\nиз почты"),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              CommonForm(inputsList: [input], formKey: formKey),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      // final data = input.controller.text;
                      if (formKey.currentState!.validate()) {}
                      context
                          .read<VerificationCubit>()
                          .getVerification(input.controller.text);
                    },
                    child: const Text("Отправить")),
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                     context.read<VerificationCubit>().repeadCodeSend();
                    },
                    child: const Text("Отправить код повторно")),
              ),
              ElevatedButton(onPressed: (){
                final service  = DataService();
                  service.logOut();
              }, child: Builder(builder: (context) => Text("LogOut"),)),
            ],
          ),
        ),
      ],
    );
  }
}
