import 'package:flutter/material.dart';
import 'package:wallpaper_app/Data/me_menu.dart';
import 'package:wallpaper_app/main.dart';

List icon = [Icons.favorite_rounded, Icons.star_rounded];

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Me",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: double.infinity,
                height: height * .2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: width * .424,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black.withOpacity(.1),
                          ),
                        ),
                        child: Icon(
                          icon[index],
                          size: height * .1,
                          color: Colors.blueGrey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          showDialog(
                            builder: (context) {
                              return const AboutDialog(
                                applicationLegalese:
                                    '''Copyright © 2023 [Your Name]. All rights reserved.\nThis app uses the Pixels API and Google images.\nYou may not modify, redistribute, or sell this app without permission.''',
                                applicationVersion: ".6.6.6",
                                applicationIcon: FlutterLogo(),
                                applicationName: "Wallpaper App",
                              );
                            },
                            context: context,
                          );
                        },
                        trailing: const Icon(null),
                        leading: Icon(meIcons[index]),
                        title: Text(
                          meTitles[index],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 55, right: 10),
                        child: Divider(
                          height: height * .01,
                          color: Colors.grey.withOpacity(.2),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
