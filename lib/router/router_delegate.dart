import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/login_screen.dart';
import '../screen/register_screen.dart';
import '../screen/list_story_screen.dart';
import '../screen/detail_story_screen.dart';
import '../screen/add_story_screen.dart';
import '../provider/add_story_provider.dart';
import '../provider/auth_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../screen/location_picker_screen.dart';


class MyRouterDelegate extends RouterDelegate<String>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<String> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  String? _selectedStoryId;
  bool _isLoggedIn = false;
  bool _isRegister = false;
  bool _isAddStory = false;
  bool _showLogoutDialog = false;
  bool _showImageSourceDialog = false;
  bool _showLocationPicker = false;
  LatLng? _initialLocation;
  Function(LatLng, String)? _onLocationSelected;

  MyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  bool get isLoggedIn => _isLoggedIn;
  bool get isRegister => _isRegister;
  bool get isAddStory => _isAddStory;
  bool get showLogoutDialog => _showLogoutDialog;
  bool get showImageSourceDialog => _showImageSourceDialog;
  bool get showLocationPicker => _showLocationPicker;

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setRegister(bool value) {
    _isRegister = value;
    notifyListeners();
  }

  void setAddStory(bool value) {
    _isAddStory = value;
    notifyListeners();
  }

  void setShowLogoutDialog(bool value) {
    _showLogoutDialog = value;
    notifyListeners();
  }

  void setShowImageSourceDialog(bool value) {
    _showImageSourceDialog = value;
    notifyListeners();
  }

  void setShowLocationPicker(
      bool value, {
        LatLng? initialLocation,
        Function(LatLng, String)? onLocationSelected,
      }) {
    _showLocationPicker = value;
    _initialLocation = initialLocation;
    _onLocationSelected = onLocationSelected;
    notifyListeners();
  }

  void selectStory(String id) {
    _selectedStoryId = id;
    notifyListeners();
  }

  @override
  String? get currentConfiguration {
    if (!_isLoggedIn) {
      return _isRegister ? '/register' : '/login';
    }
    if (_isAddStory) {
      if (_showLocationPicker) {
        return '/add-story/location-picker';
      }
      return '/add-story';
    }
    if (_selectedStoryId != null) {
      return '/story/$_selectedStoryId';
    }
    return '/';
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (!_isLoggedIn) ...[
          MaterialPage(
            key: const ValueKey('LoginScreen'),
            child: LoginScreen(
              onLoggedIn: () {
                setLoggedIn(true);
              },
              onRegister: () {
                setRegister(true);
              },
            ),
          ),
          if (_isRegister)
            MaterialPage(
              key: const ValueKey('RegisterScreen'),
              child: RegisterScreen(
                onRegistered: () {
                  setRegister(false);
                },
                onBackToLogin: () {
                  setRegister(false);
                },
              ),
            ),
        ] else ...[
          MaterialPage(
            key: const ValueKey('StoryListScreen'),
            child: ListStoryScreen(
              onTapped: (String id) {
                selectStory(id);
              },
              onLoggedOut: () {
                setLoggedIn(false);
              },
              onAddStory: () {
                setAddStory(true);
              },
              onShowLogoutDialog: () {
                setShowLogoutDialog(true);
              },
            ),
          ),
          if (_isAddStory)
            MaterialPage(
              key: const ValueKey('AddStoryScreen'),
              child: AddStoryScreen(
                onUpload: () {
                  setAddStory(false);
                },
                onBack: () {
                  setAddStory(false);
                },
                onShowImageSourceDialog: () {
                  setShowImageSourceDialog(true);
                },
                onShowLocationPicker: (initialLocation, onLocationSelected) {
                  setShowLocationPicker(
                    true,
                    initialLocation: initialLocation,
                    onLocationSelected: onLocationSelected,
                  );
                },
              ),
            ),
          if (_showLocationPicker && _isAddStory)
            MaterialPage(
              key: const ValueKey('LocationPickerScreen'),
              child: LocationPickerScreen(
                initialLocation: _initialLocation,
                onLocationSelected: (location, address) {
                  if (_onLocationSelected != null) {
                    _onLocationSelected!(location, address);
                  }
                  setShowLocationPicker(false);
                },
                onBack: () {
                  setShowLocationPicker(false);
                },
              ),
            ),
          if (_selectedStoryId != null)
            MaterialPage(
              key: ValueKey('StoryDetail-$_selectedStoryId'),
              child: DetailStoryScreen(
                storyId: _selectedStoryId!,
                onBack: () {
                  _selectedStoryId = null;
                  notifyListeners();
                },
              ),
            ),
          if (_showImageSourceDialog)
            MaterialPage(
              key: const ValueKey('ImageSourceDialog'),
              child: Builder(
                builder: (context) {
                  final controller = Provider.of<AddStoryProvider>(
                    context,
                    listen: false,
                  );
                  return ImageSourceDialogPage(
                    onCamera: () {
                      controller.requestImagePick(ImageSource.camera);
                      setShowImageSourceDialog(false);
                    },
                    onGallery: () {
                      controller.requestImagePick(ImageSource.gallery);
                      setShowImageSourceDialog(false);
                    },
                    onCancel: () {
                      setShowImageSourceDialog(false);
                    },
                  );
                },
              ),
            ),
          if (_showLogoutDialog)
            MaterialPage(
              key: const ValueKey('LogoutDialog'),
              child: LogoutDialogPage(
                onConfirm: () async {
                  final authProvider = Provider.of<AuthProvider>(
                    navigatorKey.currentContext!,
                    listen: false,
                  );

                  await authProvider.logout();

                  setShowLogoutDialog(false);
                  setLoggedIn(false);
                },
                onCancel: () {
                  setShowLogoutDialog(false);
                },
              ),
            ),
        ],
      ],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        if (_showLocationPicker) {
          _showLocationPicker = false;
        } else if (_showImageSourceDialog) {
          _showImageSourceDialog = false;
        } else if (_showLogoutDialog) {
          _showLogoutDialog = false;
        } else if (_selectedStoryId != null) {
          _selectedStoryId = null;
        } else if (_isAddStory) {
          _isAddStory = false;
        } else if (_isRegister) {
          _isRegister = false;
        }

        notifyListeners();
        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(String configuration) async {}
}

class ImageSourceDialogPage extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;
  final VoidCallback onCancel;

  const ImageSourceDialogPage({
    Key? key,
    required this.onCamera,
    required this.onGallery,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCancel,
      behavior: HitTestBehavior.opaque,
      child: Material(
        color: Colors.black54,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: Text("Camera"),
                      onTap: onCamera,
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: Text("Gallery"),
                      onTap: onGallery,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutDialogPage extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const LogoutDialogPage({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.6),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, color: Colors.red, size: 32),
              ),

              const SizedBox(height: 16),

              Text(
                "Logout",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              Text(
                "Are you sure you want to logout?",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
