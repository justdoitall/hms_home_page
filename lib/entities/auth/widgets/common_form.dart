import 'package:flutter/material.dart';
import 'package:hms_app/theme/theme.dart';

class CommonFormInput {
  CommonFormInput(
      {required this.inputKey,
      this.isValidated = false,
      required this.label,
      this.repeatedTo,
      this.repeatValidationText,
      this.callback,
      this.isObscure = false});

  String label;
  String? repeatedTo;
  String? repeatValidationText;
  bool isValidated;
  bool isObscure;
  final String inputKey;

  Function? callback;

  TextEditingController controller = TextEditingController();
}

class CommonForm extends StatefulWidget {
  const CommonForm(
      {super.key, required this.inputsList, required this.formKey, this.isDisabled = false});
  final List<CommonFormInput> inputsList;
  final GlobalKey<FormState> formKey;
  final bool isDisabled;

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  @override
  Widget build(BuildContext context) {
    @override
    void dispose() {
      for (var element in widget.inputsList) {
        element.controller.dispose();
      }

      super.dispose();
    }

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          for (var i = 0; i < widget.inputsList.length; i++)
            Column(
              children: [
                TextFormField(
                  enabled: !widget.isDisabled,
                  onChanged: (value) {
                    if (widget.inputsList[i].callback != null) {
                      widget.inputsList[i].callback!(value);
                    }
                  },
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                },

                  decoration: CustomInputDecoration(
                      hintText: widget.inputsList[i].label),
                  obscureText: widget.inputsList[i].isObscure,
                  controller: widget.inputsList[i].controller,
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        widget.inputsList[i].isValidated) {
                      return 'Заполните поле';
                    }
                    final inputKey = widget.inputsList[i].repeatedTo;
                    if (inputKey != null) {
                      final input = widget.inputsList.firstWhere(
                          (element) => element.inputKey == inputKey);
                      if (value != input.controller.text) {
                        return widget.inputsList[i].repeatValidationText ??
                            "Поля не совпадают";
                      }
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: i == widget.inputsList.length - 1 ? 0 : 12,
                )
              ],
            ),
        ],
      ),
    );
  }
}
