import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App1",
        style: TextStyle(
          backgroundColor: const Color.fromARGB(255, 17, 214, 236)
        ),),
        
      ),
     
    );
  }
}