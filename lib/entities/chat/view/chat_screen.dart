import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

const storage = FlutterSecureStorage();

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: const Text("LogOut"),
              onPressed: () {
                storage.delete(key: 'auth_token');
                context.go('/login');
              },
            ),
            ElevatedButton(
              child: const Text("Open"),
              onPressed: () {},
            ),
          ],
        ),
    );
  }
}
