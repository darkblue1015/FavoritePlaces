import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// A StatefulWidget that handles the functionality of capturing an image using the device camera.
class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onPickImage});

  // Callback function to pass the selected image back to the parent widget.
  final void Function(File image) onPickImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage; // Local storage for the selected image file.

  // Method to invoke the camera, capture an image, and handle the file.
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 600); // Limit image width to 600 pixels for performance.

    if (pickedImage == null) {
      return; // If no image is picked (e.g., camera dialog is cancelled), exit the method.
    }

    setState(() {
      _selectedImage = File(
          pickedImage.path); // Save the image file from the captured image.
    });

    widget.onPickImage(
        _selectedImage!); // Call the callback function with the new image.
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture, // Button to activate the camera.
    );

    // If an image is selected, display it with a GestureDetector to allow re-taking the picture.
    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture, // Tap the image to activate the camera again.
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover, // Cover the container bounds with the image.
          width: double.infinity,
          height: double.infinity,
        ),
      );
    }

    // Container for displaying the content, with a border.
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context)
              .colorScheme
              .primary
              .withOpacity(0.2), // Slightly transparent primary color border.
        ),
      ),
      height: 250, // Fixed height for the container.
      width: double.infinity, // Take up all available width.
      alignment: Alignment.center,
      child: content, // Display the current content (button or image).
    );
  }
}
