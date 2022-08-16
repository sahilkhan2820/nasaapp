import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../helpers/debouncer.dart';
import '../models/picture.dart';

class PicturesProvider extends ChangeNotifier {
  // At the beginning, we fetch the first 20 posts
  int page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int limit = 20;
  // There is next page or not
  bool hasNextPage = true;
  // Used to display loading indicators when _firstLoad function is running
  bool isFirstLoadRunning = false;
  // Used to display loading indicators when _loadMore function is running
  bool isLoadMoreRunning = false;

  int _numberPage = 0;
  int selectedmoview = 0;
  List<Picture> listPicturesPlaying = [];
  List<Picture> popularPictures = [];

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final StreamController<List<Picture>> _suggestionStreamController =
      StreamController.broadcast();
  Stream<List<Picture>> get suggestionStream =>
      _suggestionStreamController.stream;

  loadcontroller() {
    // scrollcontroller = ScrollController()..addListener(getNowPlayingPictures);
  }

  disposecontroller() async {
    //  scrollcontroller.removeListener(await getNowPlayingPicturesPage(1));
    super.dispose();
  }

  setfilter(int i) {
    // selectedmoview = 1;
    notifyListeners();
  }

  PicturesProvider() {
    loadData();
  }

  loadData() async {
    await Future.delayed(Duration(seconds: 2));
    final pictureJson = await rootBundle.loadString("assets/files/nasa.json");
    final decodedData = jsonDecode(pictureJson);
    PictureModel.items = List.from(decodedData)
        .map<Picture>((item) => Picture.fromJson(item))
        .toList();
    listPicturesPlaying = PictureModel.items;

    notifyListeners();
  }
}

class PopularPicturesResponse {
  static fromJson(String responseData) {}
}
