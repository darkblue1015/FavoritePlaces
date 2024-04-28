import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/providers/user_places.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// A StatefulWidget that allows users to add a new place with a title, image, and location
class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreenState();
  }
}

void addPlaceToDatabase(
    String title, File image, PlaceLocation location) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('places')
      .doc();

  await docRef.set({
    'title': title,
    // 'image': await uploadImageAndGetUrl(image),
    'latitude': location.latitude,
    'longitude': location.longitude,
    'address': location.address
  });
}

void fetchUserPlaces() {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final collectionRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('places');

  collectionRef.get().then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      print(doc.data());
    }
  });
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      return;
    }

    ref
        .read(userPlacesProvider.notifier)
        .addPlace(enteredTitle, _selectedImage!, _selectedLocation!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            ImageInput(
              onPickImage: (image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 10),
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
