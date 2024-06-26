import 'package:flutter/material.dart';

class AddEatenFood extends StatefulWidget {
  List<String> gramms;
  AddEatenFood(this.gramms, {super.key});

  @override
  State<AddEatenFood> createState() => _AddEatenFoodState();
}

class _AddEatenFoodState extends State<AddEatenFood> {
  String selectedValue = "";
  @override
  void initState() {
    selectedValue = widget.gramms.first;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (option, index) {
        return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              selectedValue = widget.gramms[index];
              setState(() {});
            },
            child: Container(
                color: selectedValue == widget.gramms[index]
                    ? const Color.fromARGB(255, 200, 230, 207)
                    : null,
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: <Widget>[
                      Radio(
                          value: widget.gramms[index],
                          groupValue: selectedValue,
                          onChanged: (s) {
                            // selectedValue;
                            // setState(() {});
                            selectedValue = widget.gramms[index];
                            setState(() {});
                          }),
                      Text(widget.gramms[index])
                    ],
                  ),
                )));
      },
      itemCount: widget.gramms.length,
    );
  }
}
