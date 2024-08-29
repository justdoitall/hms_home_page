import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: 
      const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Icon(Icons.launch_outlined),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Доброе утро, user',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star), 
              SizedBox(width: 8), 
              Text(
                '125 hms',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
      ],)
    );
  }
}