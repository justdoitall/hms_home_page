import 'package:flutter/material.dart';
import 'package:hms_app/entities/physical_activities/add_new_activity.dart';

class Activity {
  final int id;
  final String title;
  final int calories;

  const Activity(
      {required this.id, required this.title, required this.calories});
}

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  dynamic mockList = <Activity>[
    const Activity(id: 1, title: 'Activity1', calories: 4),
    const Activity(id: 2, title: 'Activity2', calories: 2),
    const Activity(id: 3, title: 'Activity3', calories: 8),
    const Activity(id: 4, title: 'Activity4', calories: 10),
    const Activity(id: 5, title: 'Activity5', calories: 9),
    const Activity(id: 6, title: 'Activity6', calories: 5),
    const Activity(id: 7, title: 'Activity7', calories: 11)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(hintText: 'Поиск'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const NewActivity())));
                  },
                  child: const Text('Новая активность')),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: mockList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      title: const Text('Введите время'),
                                      content: SizedBox(
                                          width: 250,
                                          height: 230,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                  decoration: const InputDecoration(
                                                      hintText: 'Часы',
                                                      border:
                                                          OutlineInputBorder()),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                'Минуты')),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: OutlinedButton(
                                                        onPressed: () {},
                                                        child: const Text(
                                                            'Отмена')),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: OutlinedButton(
                                                        onPressed: () {},
                                                        child: const Text(
                                                            'Добавить')),
                                                  )
                                                ],
                                              )
                                            ],
                                          )),
                                    );
                                  }));
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 8, 0, 0),
                                      child: Text(mockList[index].title),
                                    )),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        mockList[index].calories.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }))
          ],
        ));
  }
}
