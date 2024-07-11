import 'package:flutter/material.dart';
import '../widgets/input_form.dart';

class InputPage extends StatelessWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Your Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: InputForm(),
      ),
    );
  }
}
