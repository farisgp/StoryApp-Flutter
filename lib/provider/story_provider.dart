import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/model/story.dart';

class StoryProvider with ChangeNotifier {
  final ApiService apiService;

  List<Story> _stories = [];
  Story? _selectedStory;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  String? _errorMessage;
  int _currentPage = 1;
  bool _hasMore = true;

  List<Story> get stories => _stories;
  Story? get selectedStory => _selectedStory;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  String? get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  StoryProvider({required this.apiService});

  Future<void> fetchStories(String token, {bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      _stories = [];
      _hasMore = true;
    }

    if (!_hasMore || _isLoading || _isLoadingMore) return;

    if (_currentPage == 1) {
      _isLoading = true;
    } else {
      _isLoadingMore = true;
    }
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.getAllStories(
        token,
        page: _currentPage,
        size: 10,
      );

      if (!response.error) {
        if (response.listStory.isEmpty) {
          _hasMore = false;
        } else {
          _stories.addAll(response.listStory);
          _currentPage++;
        }
      } else {
        _errorMessage = response.message;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> fetchStoryDetail(String token, String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await apiService.getStoryDetail(token, id);

      if (!response.error && response.story != null) {
        _selectedStory = response.story;
      } else {
        _errorMessage = response.message;
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSelectedStory() {
    _selectedStory = null;
    notifyListeners();
  }

  void reset() {
    _stories = [];
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    _isLoadingMore = false;
    _errorMessage = null;
    notifyListeners();
  }
}
