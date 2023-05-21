import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:githubsearch/model/list_gituser.dart';
import 'package:githubsearch/model/profile_model.dart';
import 'package:githubsearch/provider/profile.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

abstract class Services {
  static Future<void> getProfile(
    BuildContext context,
    String name,
  ) async {
    final response =
        await http.get(Uri.parse('https://api.github.com/users/$name'));

    var jsondata = json.decode(response.body);
    if (jsondata['message'] == 'Not Found') {
      final provider = context.read<ProfileProvider>();
      provider.setSearchProfile(null);
    } else {
      ProfileModel prof = ProfileModel(
          jsondata['id'].toString(),
          jsondata['name'] ?? '',
          jsondata['company'] ?? '',
          jsondata['email'] ?? '',
          jsondata['public_repos'] ?? 0,
          jsondata['avatar_url'] ?? '',
          jsondata['html_url'] ?? '',
          jsondata['created_at'] ?? '',
          jsondata['updated_at'] ?? '');
      // ignore: use_build_context_synchronously
      final provider = context.read<ProfileProvider>();
      provider.setSearchProfile(prof);
    }
  }

  static Future<void> getListProfile(
    BuildContext context,
  ) async {
    final response = await http.get(Uri.parse('https://api.github.com/users?per_page=10'));

    var jsondata = json.decode(response.body);

    List<ListProfileModel> listProfile = [];

    for (var u in jsondata) {
      ListProfileModel prof = ListProfileModel(
            u['id'].toString(),
            u['login'] ?? '',
            u['url'] ?? '',
            u['avatar_url'] ?? '',);
        // ignore: use_build_context_synchronously
        listProfile.add(prof);
    }

    final provider = context.read<ProfileProvider>();
    provider.setList(listProfile);
  }
}
