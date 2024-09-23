import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 5, 11, 5),
        appBar: AppBar(
          title: const Text(
            "I Am Rich",
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 172, 103, 12),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 30, 12, 8),
          elevation: 0,
          centerTitle: true,
          // leading: Icon(Icons.arrow_back_ios),
        ),
        body: const Center(
          child: Image(
            image: AssetImage('images/rich.jpg'),
            //image: NetworkImage('https://images.pexels.com/photos/296282/pexels-photo-296282.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
          ),
        ),
      ),
    ),
  );
}
