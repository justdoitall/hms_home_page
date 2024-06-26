import 'package:flutter/material.dart';
import 'package:hms_app/entities/food/foodlist.dart';

class NewFood extends StatefulWidget {
  const NewFood({super.key});

  @override
  State<NewFood> createState() => _NewFoodState();
}

class _NewFoodState extends State<NewFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новое блюдо'),
        backgroundColor: const Color.fromRGBO(69, 186, 136, 1),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const FoodTable())));
              },
              icon: const Icon(Icons.keyboard_backspace)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => const FoodTable())));
                },
                child: const Text('Ок')),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
              hintText: 'Название',
              labelText: 'Название',
              border: OutlineInputBorder(),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
              hintText: 'Калории',
              labelText: 'Калории',
              border: OutlineInputBorder(),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
              hintText: 'Белки',
              labelText: 'Белки',
              border: OutlineInputBorder(),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
              hintText: 'Жиры',
              labelText: 'Жиры',
              border: OutlineInputBorder(),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
              hintText: 'Углеводы',
              labelText: 'Углеводы',
              border: OutlineInputBorder(),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: const InputDecoration(
              hintText: 'Вес',
              labelText: 'Вес',
              border: OutlineInputBorder(),
            )),
          )
        ],
      ),
    );
  }
}
