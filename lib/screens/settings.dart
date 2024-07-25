import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close_rounded,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        child: Icon(Icons.person, size: 50),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Save & Sync Your Favorites',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text("Sign in below to get started"),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: Get.width,
                        child: ElevatedButton.icon(
                          style: const ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.black,
                            ),
                            backgroundColor: WidgetStatePropertyAll(
                              Colors.white,
                            ),
                          ),
                          icon: Image.asset(
                            "assets/google.png",
                            height: 30,
                          ),
                          label: const Text('Sign in with Google'),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                color: Theme.of(context).colorScheme.inversePrimary,
                child: ListTile(
                  leading: const Icon(
                    Icons.workspace_premium_rounded,
                  ),
                  title: const Text('Upgrade to Backdrops Pro'),
                  subtitle: const Text(
                      'Unlock and enjoy the best Backdrops experience.'),
                  onTap: () {},
                ),
              ),
              ListTile(
                leading: const Icon(Icons.autorenew),
                title: const Text('Auto Switch (Pro)'),
                subtitle:
                    const Text('Automatically shuffle through your favorites.'),
                trailing: Switch(value: false, onChanged: (bool value) {}),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.upload),
                title: const Text('My Uploads'),
                subtitle:
                    const Text('View your approved Community wallpapers.'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('Restore Purchases'),
                subtitle: const Text('Restore your in-app purchases.'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Clear Cache'),
                subtitle: const Text(
                    'Clear locally cached images. Current size: 555.1 kB'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.sync),
                title: const Text('Sync Favorites'),
                subtitle: const Text(
                    'Sync your favorites across all your Android devices.'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
