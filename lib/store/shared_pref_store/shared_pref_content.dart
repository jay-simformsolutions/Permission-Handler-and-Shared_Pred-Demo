import 'package:flutter/material.dart';
import 'package:permission_handler_demo/shared_preference/shared_pref.dart';

class SharedPrefContent extends StatelessWidget {
  const SharedPrefContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Contet'),
      ),
      body: FutureBuilder<List<Widget>>(
        future: SharedPref.instance?.getAllPrefs(),
        builder: (context, snapshot) {
          // print(SharedPref.instance?.getAllPrefs());
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!,
          );
        },
      ),
    );
  }
}
