import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import '../provider/auth_provider.dart';
import '../provider/upload_provider.dart';
import '../provider/story_provider.dart';
import '../provider/add_story_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddStoryScreen extends StatefulWidget {
  final VoidCallback onUpload;
  final VoidCallback onBack;
  final VoidCallback onShowImageSourceDialog;
  final Function(LatLng?, Function(LatLng, String)) onShowLocationPicker;

  const AddStoryScreen({
    Key? key,
    required this.onUpload,
    required this.onBack,
    required this.onShowImageSourceDialog,
    required this.onShowLocationPicker,
  }) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  bool _isCompressing = false;
  LatLng? _selectedLocation;
  String? _locationAddress;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final controller = context.watch<AddStoryProvider>();
    if (controller.pendingImageSource != null) {
      final source = controller.pendingImageSource!;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.clearPendingRequest();
        pickImage(source);
      });
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<File> _compressImage(File file) async {
    try {
      final bytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(Uint8List.fromList(bytes));

      if (image == null) return file;

      const int maxSizeInBytes = 1024 * 1024;
      int currentSize = await file.length();

      if (currentSize <= maxSizeInBytes) {
        return file;
      }

      int quality = 85;
      List<int> compressedBytes = [];

      if (image.width > 1920 || image.height > 1920) {
        image = img.copyResize(
          image,
          width: image.width > image.height ? 1920 : null,
          height: image.height > image.width ? 1920 : null,
        );
      }

      do {
        compressedBytes = img.encodeJpg(image, quality: quality);
        quality -= 5;
        if (quality < 50) break;
      } while (compressedBytes.length > maxSizeInBytes);

      final compressedFile = File(
        '${file.parent.path}/compressed_${file.uri.pathSegments.last}',
      );
      await compressedFile.writeAsBytes(compressedBytes);

      return compressedFile;
    } catch (e) {
      return file;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _isCompressing = true;
        });

        File selectedFile = File(image.path);
        final fileSize = await selectedFile.length();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Original size: ${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB',
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }

        if (fileSize > 1024 * 1024) {
          selectedFile = await _compressImage(selectedFile);
          final compressedSize = await selectedFile.length();

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Compressed size: ${(compressedSize / 1024 / 1024).toStringAsFixed(2)} MB',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }

        setState(() {
          _imageFile = selectedFile;
          _isCompressing = false;
        });
      }
    } catch (e) {
      setState(() {
        _isCompressing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error processing image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickLocation() async {
    // Menggunakan declarative navigation
    widget.onShowLocationPicker(
      _selectedLocation,
          (location, address) {
        setState(() {
          _selectedLocation = location;
          _locationAddress = address;
        });
      },
    );
  }

  Future<void> _handleUpload() async {
    if (_formKey.currentState!.validate() && _imageFile != null) {
      final authProvider = context.read<AuthProvider>();
      final uploadProvider = context.read<UploadProvider>();
      final storyProvider = context.read<StoryProvider>();

      final token = await authProvider.getToken();

      if (token != null) {
        final success = await uploadProvider.uploadStory(
          token,
          _descriptionController.text,
          _imageFile!,
          lat: _selectedLocation?.latitude,
          lon: _selectedLocation?.longitude,
        );

        if (success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Story uploaded successfully'),
              backgroundColor: Colors.green,
            ),
          );

          await storyProvider.fetchStories(token, refresh: true);
          widget.onUpload();
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                uploadProvider.errorMessage ?? 'Failed to upload story',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.blue.shade800),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Add Story",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: widget.onBack,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade400, Colors.blue.shade800],
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      kToolbarHeight + 24,
                      16,
                      16,
                    ),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _isCompressing
                                  ? const Padding(
                                      padding: EdgeInsets.all(24),
                                      child: CircularProgressIndicator(),
                                    )
                                  : _imageFile != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        _imageFile!,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(
                                      Icons.image,
                                      size: 120,
                                      color: Colors.blue.shade300,
                                    ),

                              const SizedBox(height: 12),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        pickImage(ImageSource.gallery),
                                    icon: const Icon(Icons.photo),
                                    label: const Text("Gallery"),
                                  ),
                                  const SizedBox(width: 12),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        pickImage(ImageSource.camera),
                                    icon: const Icon(Icons.camera_alt),
                                    label: const Text("Camera"),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 16),

                              TextFormField(
                                controller: _descriptionController,
                                maxLines: 3,
                                decoration: _inputDecoration(
                                  "Description",
                                  Icons.description,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter description";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),
                              OutlinedButton.icon(
                                onPressed: _pickLocation,
                                icon: const Icon(Icons.location_on),
                                label: Text(
                                  _selectedLocation == null
                                      ? 'Add Location (Optional)'
                                      : 'Location Added',
                                ),
                              ),
                              if (_selectedLocation != null && _locationAddress != null) ...[
                                const SizedBox(height: 8),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on, size: 20),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                _locationAddress!,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.close, size: 20),
                                              onPressed: () {
                                                setState(() {
                                                  _selectedLocation = null;
                                                  _locationAddress = null;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                              Consumer<UploadProvider>(
                                builder: (context, uploadProvider, _) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed:
                                          uploadProvider.isLoading ||
                                              _isCompressing
                                          ? null
                                          : _handleUpload,
                                      child: uploadProvider.isLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            )
                                          : const Text("Add Story"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
