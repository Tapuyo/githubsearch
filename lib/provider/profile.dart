import 'package:flutter/foundation.dart';
import 'package:githubsearch/model/list_gituser.dart';
import 'package:githubsearch/model/profile_model.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  String _name = '';
  ProfileModel? _profile;

  List<ListProfileModel> _list = [];

  List<ListProfileModel> get list => _list;

  bool get isLoading => _isLoading;

  String get name => _name;

  ProfileModel? get profile => _profile;

  void setRefresh() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void setNameSearch(String value) {
    _name = value;
    notifyListeners();
  }

  void setSearchProfile(ProfileModel? value) {
    _profile = value;
    notifyListeners();
  }

   void setList(List<ListProfileModel> value) {
    _list = value;
    notifyListeners();
  }
}
