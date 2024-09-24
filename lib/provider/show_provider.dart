import 'package:flutter/material.dart';
import 'package:quadb/models/show_model.dart';

class ShowProvider extends ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  List<ShowModel> _shows = [];

  List<ShowModel> get shows => _shows;

  void setShows(List<ShowModel> value) {
    _shows = value;
    notifyListeners();
  }

  void clearShows() {
    _shows = [];
    notifyListeners();
  }

  Color _color = Colors.black;

  Color get color => _color;

  void setColor(Color value) {
    _color = value;
    notifyListeners();
  }

  bool _searching = false;

  bool get searching => _searching;

  void setSearching(bool value) {
    _searching = value;
    notifyListeners();
  }

  List<ShowModel> _searchResults = [];

  List<ShowModel> get searchResults => _searchResults;

  void setSearchResults(List<ShowModel> value) {
    _searchResults = value;
    notifyListeners();
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }
}
