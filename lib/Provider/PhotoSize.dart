import 'package:flutter/cupertino.dart';

class PhotoSize with ChangeNotifier {
  bool play = false;

  void resize() {
    play = !play;
    notifyListeners();
  }
}
