import 'package:flutter/material.dart';


class ValidationScreen extends StatelessWidget {

  const ValidationScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Supplier Validation"),
      ),

      body: const Center(

        child: Text(
          "Validation Screen",
        ),

      ),

    );

  }

}