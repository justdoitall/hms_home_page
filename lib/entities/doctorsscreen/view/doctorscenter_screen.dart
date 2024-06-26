import 'package:flutter/material.dart';
import 'package:hms_app/entities/doctorsscreen/widsgets/widgest.dart';

class DoctorCenter extends StatefulWidget {
  const DoctorCenter({super.key});

  @override
  State<DoctorCenter> createState() => _DoctorCenterState();
}

class _DoctorCenterState extends State<DoctorCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: const Color.fromARGB(255, 22, 245, 171),
              child: const Center(child: Text('Имя доктора')),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.work),
                  GestureDetector(
                      child: const SizedBox(
                          width: 280, child: Text('Tasks/Issues')),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const DoctorsNotifications())));
                      }),
                  GestureDetector(
                      child: const SizedBox(width: 50, child: Text('0')),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const DoctorsNotifications())));
                      }),
                  const Icon(Icons.chat)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.assessment),
                  GestureDetector(
                      child: const Text('Statistics/Analytics'), onTap: () {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(Icons.people),
                  GestureDetector(
                      child: const Text('Clients'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const ClientList())));
                      })
                ],
              ),
            ),
            const SizedBox(height: 70),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Center(child: Text('Ваш персональный код врача:')),
            ),
            const Center(child: Text('*code*')),
            const Padding(
              padding: EdgeInsets.all(6.0),
              child: Center(
                  child: Icon(
                Icons.content_copy,
                size: 40,
              )),
            )
          ],
        ));
  }
}
