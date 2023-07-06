import 'package:flutter/material.dart';
import 'package:permission_handler_demo/routes/navigator_service.dart';
import 'package:permission_handler_demo/routes/routes.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => NavigationService.instance
                  .navigateToScreen(Routes.openAppSettingOnCustomDialog),
              child: const Text('Open App Setting'),
            )
          ],
        ),
      ),
    );
  }
}
