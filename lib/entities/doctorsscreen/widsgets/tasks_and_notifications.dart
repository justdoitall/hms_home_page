import 'package:flutter/material.dart';

class Notifications {
  final int id;
  final String name;
  final String message;

  const Notifications({
    required this.id,
    required this.name,
    required this.message,
  });
}

class DoctorsNotifications extends StatefulWidget {
  const DoctorsNotifications({super.key});

  @override
  State<DoctorsNotifications> createState() => _DoctorsNotificationsState();
}

class _DoctorsNotificationsState extends State<DoctorsNotifications> {
  dynamic mockList = <Notifications>[
    const Notifications(id: 1, name: 'name1', message: 'issue1'),
    const Notifications(id: 2, name: 'name2', message: 'issue2'),
    const Notifications(id: 3, name: 'name3', message: 'issue3'),
    const Notifications(id: 4, name: 'name4', message: 'issue4'),
    const Notifications(id: 5, name: 'name5', message: 'issue5'),
    const Notifications(id: 6, name: 'name6', message: 'issue6')
  ];

  List<String> titless = ['ID', 'name', 'message', 'progress'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Задачи/оповещения')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mockList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return const Row(
                        children: [
                          SizedBox(height: 30, width: 40, child: Text('ID')),
                          SizedBox(height: 30, width: 150, child: Text('Имя')),
                          SizedBox(
                              height: 30, width: 200, child: Text('Пояснение')),
                        ],
                      );
                    }

                    index -= 1;
                    return Row(
                      children: [
                        SizedBox(
                            height: 30,
                            width: 40,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(mockList[index].id.toString()),
                            )),
                        SizedBox(
                            height: 30,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(mockList[index].name),
                            )),
                        SizedBox(
                            height: 30,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(mockList[index].message),
                            )),
                      ],
                    );
                  }),
            )
          ],
        ));
  }
}
