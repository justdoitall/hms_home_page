import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hms_app/entities/auth/widgets/common_elevated_button.dart';
import 'package:hms_app/entities/auth/widgets/header.dart';

class TechSupportScreen extends StatelessWidget {
  const TechSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(title: "Обратитесь\nв поддержку"),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            
          Text("Позвоните по номеру:\n88005553535"),
          const SizedBox(height: 20,),
          
           CommonElevateButton(onPressed: (){
            context.pop();
           }, child: const Text("Вернуться"))
          ],),
        )
      ],
    );
  }
}