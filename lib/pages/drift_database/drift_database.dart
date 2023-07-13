import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler_demo/store/drift_store/drift_database_store.dart';
import 'package:provider/provider.dart';

class DriftDatabasePage extends StatelessWidget {
  const DriftDatabasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.read<DriftDatabaseStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drift Database Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: store.getAllTask,
        child: Observer(
          builder: (context) {
            return store.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: store.tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: store.tasks[index].isCompleted
                            ? Colors.green.shade200
                            : Colors.red.shade100,
                        margin: const EdgeInsets.all(15),
                        child: ListTile(
                          title: Text(
                            store.tasks[index].name,
                          ),
                          subtitle: Text(
                            store.tasks[index].task,
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => store.showForm(
                                    store.tasks[index].id,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => store.deleteItem(
                                    store.tasks[index].id,
                                  ),
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
        heroTag: 1,
        onPressed: () {
          store.showForm(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
