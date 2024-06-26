import 'package:flutter/material.dart';

class Clients {
  final int id;
  final String name;
  final int weight;
  final int progress;

  const Clients(
      {required this.id,
      required this.name,
      required this.weight,
      required this.progress});
}

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  dynamic mockList = <Clients>[
    const Clients(id: 1, name: 'client1', weight: 74, progress: 32),
    const Clients(id: 2, name: 'client2', weight: 74, progress: 28),
    const Clients(id: 3, name: 'client3', weight: 74, progress: 10),
    const Clients(id: 4, name: 'client4', weight: 74, progress: 83),
    const Clients(id: 5, name: 'client5', weight: 74, progress: 61),
    const Clients(id: 6, name: 'client6', weight: 74, progress: 90)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Пациенты')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: mockList?.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return const Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text('ID'),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 150,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text('Name'),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 70,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text('Weight'),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 90,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text('Progress'),
                            ),
                          ),
                        ],
                      );
                    }
                    index -= 1;
                    return Row(children: [
                      SizedBox(
                          height: 40,
                          width: 40,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(mockList[index].id.toString()),
                          )),
                      SizedBox(
                          height: 40,
                          width: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(mockList[index].name),
                          )),
                      SizedBox(
                          height: 40,
                          width: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(mockList[index].weight.toString()),
                          )),
                      SizedBox(
                          height: 40,
                          width: 70,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 5, 1, 5),
                                child:
                                    Text(mockList[index].progress.toString()),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(1, 5, 5, 5),
                                child: Text('%'),
                              )
                            ],
                          ))
                    ]);
                  }),
            )
          ],
        ));
  }
}
