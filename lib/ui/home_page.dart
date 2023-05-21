// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:githubsearch/model/list_gituser.dart';
import 'package:githubsearch/model/profile_model.dart';
import 'package:githubsearch/provider/profile.dart';
import 'package:githubsearch/services/service.dart';
import 'package:githubsearch/ui/list_search.dart';
import 'package:githubsearch/ui/profile_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();
  bool showTextResult = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      getList();
    });

    super.initState();
  }

  void getList() async {
    await Services.getListProfile(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/githubbg.png',
                fit: BoxFit.cover,
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Column(children: [
              Row(
                children: [
                  Hero(
                      tag: 'loading',
                      child: Image.asset(
                        'assets/githublogo.png',
                        width: 60,
                        height: 60,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!!!',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        'github search',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(2, 10, 2, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.2),
                  ),
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        await Services.getProfile(context, value);
                        setState(() {
                          showTextResult = true;
                        });
                      } else {
                        setState(() {
                          showTextResult = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (textEditingController.text.isNotEmpty) {
                            print(textEditingController.text);
                            final provider = context.read<ProfileProvider>();
                            provider.setNameSearch(textEditingController.text);
                            await Services.getProfile(
                                context, textEditingController.text);
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      fillColor: Colors.white,
                      hintText: "Search username",
                      hintStyle: TextStyle(color: Colors.black45),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.white, width: 2)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              if (showTextResult)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Search result for ${textEditingController.text}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              if (showTextResult) ListProfile(),
              listWidget(context),
            ]),
          ),
        ],
      ),
    );
  }

  SizedBox listWidget(BuildContext context) {
    final List<ListProfileModel> listProfile =
        context.select((ProfileProvider p) => p.list);
    return listProfile.isNotEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              scrollDirection: Axis.vertical,
              itemCount: listProfile.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () async {
                    await Services.getProfile(context, listProfile[i].name);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => Profile()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black)),
                      child: Card(
                          child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Hero(
                                    tag: 'profileImage',
                                    child: CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage:
                                          NetworkImage(listProfile[i].image),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 20, 8, 0),
                                    child: Text(listProfile[i].name),
                                  )
                                ]),
                          ),
                        ],
                      )),
                    ),
                  ),
                );
              },
            ),
          )
        : SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Let’s build from here',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  'Harnessed for productivity. Designed for collaboration. Celebrated for built-in security. Welcome to the platform developers love.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/original.gif',
                      width: 200,
                      height: 200,
                    ),
                  ],
                )
              ],
            ),
          );
  }
}
