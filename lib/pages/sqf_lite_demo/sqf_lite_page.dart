import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/database_helper/database_helper.dart';
import 'package:permission_handler_demo/store/sqf_lite_store/sqf_lite_store.dart';
import 'package:provider/provider.dart';

class SqfLitePage extends StatelessWidget {
  const SqfLitePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<SqfLiteStore>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqf_lite Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: DataBaseHelper.instance.getItems,
        child: Observer(
          builder: (context) {
            return store.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: store.userData.length,
                    itemBuilder: (context, index) => Card(
                      color: Colors.orange[200],
                      margin: const EdgeInsets.all(15),
                      child: Dismissible(
                        key: ValueKey(store.userData[index]['title']),
                        onDismissed: (direction) => store.deleteItem(
                          store.userData[index]['id'] as int,
                        ),
                        child: ListTile(
                          title: Text(
                            store.userData[index]['title'].toString(),
                          ),
                          subtitle: Text(
                            store.userData[index]['description'].toString(),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => store.showForm(
                                    store.userData[index]['id'] as int,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => store.deleteItem(
                                    store.userData[index]['id'] as int,
                                  ),
                                ),
                              ],
                            ),
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
          store
            ..fetchUserData(
              'Native Developer',
            )
            ..showForm(null);
        },
      ),
    );
  }
}
