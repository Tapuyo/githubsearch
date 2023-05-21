// ignore_for_file: prefer_const_constructors
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:githubsearch/model/profile_model.dart';
import 'package:githubsearch/provider/profile.dart';
import 'package:githubsearch/services/service.dart';
import 'package:flutter/material.dart';
import 'package:githubsearch/ui/profile_page.dart';
import 'package:provider/provider.dart';

bool dayNow = true;

class ListProfile extends HookWidget {
  const ListProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String searchName = context.select((ProfileProvider p) => p.name);
    final ProfileModel? profile =
        context.select((ProfileProvider p) => p.profile);
    useEffect(() {
      Future.microtask(() async {
        await Services.getProfile(context, searchName);
        print(profile!.name);
      });
      return;
    }, [searchName]);

    return profile != null
        ? GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => Profile()));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hero(
                              tag: 'profileImage',
                              child: CircleAvatar(
                                radius: 35.0,
                                backgroundImage: NetworkImage(profile.image),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 8, 10),
                                  child: Text(profile.name),
                                )
                              ],
                            )),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Not Found.',
                  style: TextStyle(
                    color: Colors.white,
                  ))
            ],
          );
  }
}
