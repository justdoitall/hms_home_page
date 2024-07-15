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
      this.isNumber = false,
      this.isObscure = false,
      this.fixedController
       });

  String label;
  String? repeatedTo;
  String? repeatValidationText;
  bool isValidated;
  bool isObscure;
  bool isNumber;
  final String inputKey;

  Function? callback;
  
  TextEditingController? fixedController;

  TextEditingController controller =   TextEditingController();
}

class CommonForm extends StatefulWidget {
  const CommonForm(
      {super.key,
      required this.inputsList,
      required this.formKey,
      this.isDisabled = false});
  final List<CommonFormInput> inputsList;
  final GlobalKey<FormState> formKey;
  final bool isDisabled;

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  @override
  void dispose() {
    super.dispose();
    for (var element in widget.inputsList) {
      element.controller.clear();
      element.controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          for (var i = 0; i < widget.inputsList.length; i++)
            Column(
              children: [
                TextFormField(
                  keyboardType: widget.inputsList[i].isNumber? TextInputType.number : null,
                  enabled: !widget.isDisabled,
                  onChanged: (value) {
                    if (widget.inputsList[i].callback != null) {
                      widget.inputsList[i].callback!(value);
                    }
                  },
                  decoration: CustomInputDecoration(
                      hintText: widget.inputsList[i].label),
                  obscureText: widget.inputsList[i].isObscure,
                  controller: widget.inputsList[i].fixedController ?? widget.inputsList[i].controller,
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
