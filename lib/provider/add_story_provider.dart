import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryProvider with ChangeNotifier {
  ImageSource? _pendingImageSource;

  ImageSource? get pendingImageSource => _pendingImageSource;

  void requestImagePick(ImageSource source) {
    _pendingImageSource = source;
    notifyListeners();
  }

  void clearPendingRequest() {
    _pendingImageSource = null;
    notifyListeners();
  }
}
