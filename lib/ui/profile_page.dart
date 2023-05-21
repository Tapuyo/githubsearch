import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:githubsearch/model/profile_model.dart';
import 'package:githubsearch/provider/profile.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final ProfileModel? profile =
        context.select((ProfileProvider p) => p.profile);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.white, spreadRadius: 3),
                      ],
                    ),
                    height: 40,
                    width: 40,
                    child: Center(
                      child: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Hero(
                      tag: 'profileImage',
                      child: Image.network(profile!.image)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Text(
                      'Name: ${profile.name}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Text(
                      'Email: ${profile.email}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Text(
                      'Company: ${profile.company}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Text(
                      'Public repos: ${profile.publicRepo}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Text(
                      'Created: ${profile.createdDate}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ColoredBox(
                    color: Colors.transparent,
                    child: Text(
                      'Updated: ${profile.updatedDate}',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              
            ]),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          openlaunchUrl(profile.gitUrl);
        },
        child: Text('Visit Github Profile'),
        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

   Future<void> openlaunchUrl(String urlLink) async {
    if (!await launchUrl(Uri.parse(urlLink))) {
      throw Exception('Could not launch $urlLink');
    }
  }
}
