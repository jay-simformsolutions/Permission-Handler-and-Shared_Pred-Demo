import 'package:flutter/material.dart';

class MongodbDatabasePage extends StatelessWidget {
  const MongodbDatabasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mongodb Database Demo'),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
