import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hms_app/entities/food/adding_food.dart';
import 'package:hms_app/entities/food/add_new_food.dart';

class Foods {
  final int id;
  final String title;
  final int calories;

  const Foods({required this.id, required this.title, required this.calories});
}

class ChosenFood {
  final int id;
  final String title;
  final int calories;

  const ChosenFood(
      {required this.id, required this.title, required this.calories});
}

class FoodTable extends StatefulWidget {
  const FoodTable({super.key});

  @override
  State<FoodTable> createState() => _FoodTableState();
}

class _FoodTableState extends State<FoodTable> {
  dynamic chosMockList = <ChosenFood>[
    const ChosenFood(id: 3, title: 'food3', calories: 312),
    const ChosenFood(id: 5, title: 'food5', calories: 432),
  ];
  dynamic mockList = <Foods>[
    const Foods(id: 1, title: 'food1', calories: 213),
    const Foods(id: 2, title: 'food2', calories: 432),
    const Foods(id: 3, title: 'food3', calories: 312),
    const Foods(id: 4, title: 'food4', calories: 314),
    const Foods(id: 5, title: 'food5', calories: 432),
    const Foods(id: 6, title: 'food6', calories: 534),
    const Foods(id: 7, title: 'food7', calories: 542)
  ];
  List<String> gramms = [
    'Чайная ложка(5гр.)',
    'Столовая ложка(15гр.)',
    'Граммы'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: const TextField(
                decoration: InputDecoration(
                    labelText: 'Search', suffixIcon: Icon(Icons.search)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 110,
                    child: FloatingActionButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const NewFood())));
                      },
                      child: const Text('Новое блюдо'),
                    ),
                  ),
                ),
              ],
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
                                  title: const Text('Добавьте еду'),
                                  content: SizedBox(
                                    height: 380,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          child: SizedBox(
                                              height: 150,
                                              width: 260,
                                              child: AddEatenFood(gramms)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: FloatingActionButton(
                                              onPressed: () {
                                                /*всплывашка с добавлением ложки?*/
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('add spoon'),
                                              )),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 100,
                                          child: SizedBox(
                                            height: 30,
                                            child: TextFormField(
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'weight',
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Отмена')),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }, //add to db?
                                                  child:
                                                      const Text('Добавить')),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                                height: 40,
                                width: 200,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 0, 0),
                                  child: Text(mockList[index].title),
                                )),
                            SizedBox(
                              height: 40,
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                    Text(mockList[index].calories.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Выбрано сегодня'),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: chosMockList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                height: 40,
                                width: 200,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 8, 0, 0),
                                  child: Text(chosMockList[index].title),
                                )),
                            SizedBox(
                              height: 40,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    chosMockList[index].calories.toString()),
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.highlight_off))
                          ],
                        )
                      ],
                    );
                  }),
            )
          ],
        ));
  }
}
