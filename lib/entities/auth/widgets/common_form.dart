import 'package:flutter/material.dart';
import 'package:hms_app/theme/theme.dart';

class CommonFormInput {
  CommonFormInput(
      {required this.inputKey,
      this.isValidated = false,
      required this.label,
      this.repeatedTo,
      this.repeatValidationText,
      this.callback});

  String label;
  String? repeatedTo;
  String? repeatValidationText;
  bool isValidated;
  final String inputKey;

  Function? callback;

  TextEditingController controller = TextEditingController();
}

class CommonForm extends StatefulWidget {
  const CommonForm(
      {super.key, required this.inputsList, required this.formKey});
  final List<CommonFormInput> inputsList;
  final GlobalKey<FormState> formKey;

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
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    onChanged: (value) {
                      if(widget.inputsList[i].callback != null) {
                        widget.inputsList[i].callback!(value);
                      }
                    },
                    
                    decoration: CustomInputDecoration(
                        hintText: widget.inputsList[i].label),
                    // obscureText: true,
                    controller: widget.inputsList[i].controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
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
