import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/widgets.dart';
import 'package:hms_app/repositories/auth/auth.dart';
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
    final CommonFormInput input = CommonFormInput(
        inputKey: "verification-form",
        label: "Введите код потверждения",
        isValidated: true);
    return BlocProvider(
      create: (context) =>
          VerificationCubit(GetIt.I<InterfaceAuthRepository>()),
      child: BlocConsumer<VerificationCubit, VerificationState>(
        builder: (context, state) {
          return state.when(
              initial: () => VerificationLayout(
                    input: input,
                  ),
              loading: () => VerificationLayout(
                    input: input,state: "loading",
                  ),
              success: (r) => const SizedBox(),
              error: (e) => VerificationLayout(
                    input: input,
                  ));
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
  const VerificationLayout({super.key, required this.input, this.state="initial"});

  final CommonFormInput input;
  final String state;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Column(
      children: [
        const Header(title: "Введите код\nиз почты"),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  style: IconButton.styleFrom(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                  onPressed: () {
                    final service = DataService();
                    service.logOut();
                    context.go("/login");
                  },
                  icon: Image.asset("assets/images/arrow-back.png")),
              const SizedBox(
                height: 12,
              ),
              CommonForm(inputsList: [input], formKey: formKey, isDisabled: state == "loading",),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: CommonElevateButton(
                  isDisabled: state == "loading",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<VerificationCubit>()
                            .getVerification(input.controller.text);
                      }
                    },
                    child: const Text("Отправить")),
              ),
              const SizedBox(
                height: 20,
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
              ElevatedButton(
                  onPressed: () {
                    final service = DataService();
                    service.logOut();
                  },
                  child: Builder(
                    builder: (context) => const Text("LogOut"),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
