import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/store/mongo_db_database_store/mongo_db_database_store.dart';
import 'package:provider/provider.dart';

class MongodbDatabasePage extends StatelessWidget {
  const MongodbDatabasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<MongodbDatabaseStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mongodb Database Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: store.getAllData,
        child: Observer(
          builder: (context) {
            return store.userList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: store.userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.orange[200],
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                          title: Text(
                            store.userList[index].name,
                          ),
                          subtitle: Text(
                            store.userList[index].phone,
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () =>
                                      store.showForm(store.userList[index]),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () =>
                                      store.deleteItem(store.userList[index]),
                                  // => store.deleteItem(
                                  //   store.tasks[index].id,
                                  // ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.showForm(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
