import 'package:flutter/material.dart';
import 'package:hms_app/entities/physical_activities/activities_screen.dart';

class NewActivity extends StatefulWidget {
  const NewActivity({super.key});

  @override
  State<NewActivity> createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(69, 186, 136, 1),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ActivitiesScreen())));
            },
            icon: const Icon(Icons.keyboard_backspace)),
        title: const Text('Новая активность'),
        actions: [
          OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const ActivitiesScreen())));
              },
              child: const Text('ОК'))
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Название',
                  labelText: 'Название'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ккал/час',
                  labelText: 'Ккал/час'),
            ),
          )
        ],
      ),
    );
  }
}
