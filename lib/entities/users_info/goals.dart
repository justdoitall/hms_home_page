import 'package:flutter/material.dart';

class PersonalGoals extends StatefulWidget {
  const PersonalGoals({super.key});

  @override
  State<PersonalGoals> createState() => _PersonalGoalsState();
}

class _PersonalGoalsState extends State<PersonalGoals> {
  bool? checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Goals'),
          actions: [
            OutlinedButton(onPressed: () {}, child: const Text('save'))
          ],
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CheckboxListTile(
                      value: checkBoxValue,
                      onChanged: (bool? value) {
                        setState(() {
                          checkBoxValue = value;
                        });
                      },
                      title: const Text('Оповещение об утреннем взвешивании')),
                  Row(
                    children: [
                      const Expanded(child: Text('time')),
                      ElevatedButton(onPressed: () {}, child: const Text('pick time'))
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Суточное потребление калорий'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Set value'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Суточное потребление воды'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Set value'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Индекс массы тела'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Set value'),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Select daytime'),
                        ),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Гликелированный гемоглобин'),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Set value'),
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Select daytime'),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
