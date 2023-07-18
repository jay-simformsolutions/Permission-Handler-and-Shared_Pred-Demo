import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/store/firebase_store/cloud_firestore_store.dart';
import 'package:provider/provider.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<FirebaseCloudStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Existing User'),
      ),
      body: RefreshIndicator(
        onRefresh: store.getAllUsers,
        child: Observer(
          builder: (context) {
            return ListView.builder(
              itemCount: store.userList.length,
              itemBuilder: (context, index) => Card(
                color: Colors.orange[200],
                margin: const EdgeInsets.all(15),
                child: ListTile(
                  title: Text(
                    store.userList[index].name.toString(),
                  ),
                  subtitle: Text(
                    store.userList[index].phoneNo,
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => store.showForm(
                            store.userList[index].userId!,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => store.deleteUser(
                            store.userList[index].userId!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          store.showForm(null);
        },
      ),
    );
  }
}
