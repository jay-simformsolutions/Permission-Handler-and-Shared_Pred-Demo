import 'package:flutter/material.dart';
import 'package:permission_handler_demo/abstract_dispose/dispose.dart';
import 'package:provider/provider.dart';

extension AccessParentProvider on Widget {
  Widget accessParentProvider<U, P extends U>(P provider) => MultiProvider(
        providers: [
          Provider<U>(
            create: (_) => provider,
          ),
          Provider<P>(
            create: (_) => provider,
          ),
        ],
        child: this,
      );

  Widget withProvider<T>(T provider) => Provider(
        create: (_) => provider,
        dispose: (context, value) {
          if (value is Disposable) {
            value.dispose();
          }
        },
        child: this,
      );

  Widget withCommonProvider<T>(T provider) => Provider.value(
        value: provider,
        child: this,
      );
}
