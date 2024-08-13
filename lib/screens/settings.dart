import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_app/about_me_dialog.dart';
import 'package:wallpaper_app/main.dart';
import '../config.dart';
import '../utils/auth.dart';
import '../utils/cache_handle.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: InkWell(
        //   borderRadius: BorderRadius.circular(10),
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Theme.of(context).colorScheme.primary,
        //         borderRadius: BorderRadius.circular(10),
        //       ),
        //       child: Icon(
        //         CupertinoIcons.chevron_back,
        //         color: Theme.of(context).colorScheme.surface,
        //       ),
        //     ),
        //   ),
        // ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(gPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Theme.of(context).colorScheme.onSecondary,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      if (firebaseAuth.currentUser != null) ...[
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            firebaseAuth.currentUser!.photoURL!,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Welcome, ${firebaseAuth.currentUser!.displayName}!',
                          style: Theme.of(context).textTheme.titleLarge!.merge(
                                TextStyle(
                                  color:
                                      Theme.of(context).listTileTheme.iconColor,
                                ),
                              ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "You are using Lush Layers ${settings.isPro.value ? "Pro" : "Free"}"),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: Get.width,
                          child: FilledButton(
                            child: Text(
                              'Log Out',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                            onPressed: () async {
                              await SignIn.signOut(context);
                              setState(() {});
                            },
                          ),
                        ),
                      ] else ...[
                        const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person, size: 50),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Save & Sync Your Favorites',
                          style: Theme.of(context).textTheme.titleLarge!.merge(
                                TextStyle(
                                  color:
                                      Theme.of(context).listTileTheme.iconColor,
                                ),
                              ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Sign in below to get started"),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 60,
                          width: Get.width,
                          child: FilledButton.icon(
                            icon: Image.asset(
                              "assets/google.png",
                              height: 30,
                            ),
                            label: Text(
                              'Continue with Google',
                              style:
                                  Theme.of(context).textTheme.bodyLarge!.merge(
                                        TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                            onPressed: () async {
                              await SignIn.googleSignIn();
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Card(
                color: Theme.of(context).colorScheme.onInverseSurface,
                child: ListTile(
                  leading: const Icon(
                    Icons.workspace_premium_rounded,
                  ),
                  title: const Text('Upgrade to Lush Layers Pro'),
                  subtitle:
                      const Text('Unlock the best Lush Layers experience.'),
                  onTap: () {},
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.color_lens_rounded,
                ),
                title: const Text('Theme Mode'),
                subtitle: Text(settings.dark.value ? 'Dark' : 'Light'),
                trailing: Switch(
                  value: settings.dark.value,
                  onChanged: (bool value) {
                    settings.themeStateSave(value);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete,
                ),
                title: const Text('Clear Cache'),
                subtitle: const Text(
                  'Clear locally cached images.',
                ),
                onTap: () {
                  CacheManager().clearCacheAndShowSize();
                },
              ),
              Obx(() {
                return ListTile(
                  leading: const Icon(
                    CupertinoIcons.photo,
                  ),
                  title: const Text('Thumbnail quality'),
                  subtitle: Text(
                      settings.quality.value ? 'High quality' : 'Fast speed'),
                  trailing: Switch(
                    value: settings.quality.value,
                    onChanged: (bool value) {
                      settings.qualityStateSave(value);
                    },
                  ),
                );
              }),
              ListTile(
                leading: const Icon(
                  Icons.star_rounded,
                ),
                title: const Text('Rate Lush Layers'),
                subtitle: const Text(
                  'Enjoying Lush Layers? Rate us on the Play Store.',
                ),
                onTap: () async {
                  final InAppReview inAppReview = InAppReview.instance;

                  if (await inAppReview.isAvailable()) {
                    inAppReview.requestReview();
                  }
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.mail_rounded,
                ),
                title: const Text('Help and Feedback'),
                subtitle: const Text('Got questions? Email Us.'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                      "mailto:wizium123@gmail.com?subject=Feedback for Lush Layers",
                    ),
                    mode: LaunchMode.externalNonBrowserApplication,
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip_rounded,
                ),
                title: const Text('Privacy Policy'),
                subtitle: const Text('Read our Privacy Policy.'),
                onTap: () {
                  launchUrl(
                    Uri.parse(
                      "https://sites.google.com/view/lushlayers/home",
                    ),
                    mode: LaunchMode.inAppBrowserView,
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_rounded,
                ),
                title: const Text('About'),
                subtitle: const Text('Licenses and credits'),
                onTap: () {
                  showAboutDialog(
                    context: context,
                    applicationName: appName,
                    applicationVersion: version,
                    applicationIcon: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/appIcon.png",
                        height: 70,
                        width: 70,
                      ),
                    ),
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          aboutMeDialog();
                        },
                        child: const Text("About Developer"),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
