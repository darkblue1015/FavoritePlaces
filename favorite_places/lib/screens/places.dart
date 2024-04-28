import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_places/screens/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:favorite_places/providers/user_places.dart';

// ConsumerWidget for displaying user-specific list of places and managing user sessions.
class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  // Fetches places associated with the currently signed-in user from Firestore.
  void fetchUserPlaces() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('places');

    collectionRef.get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc.data()); // Print each place's data to console for debugging
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref
        .watch(userPlacesProvider); // Watches for changes in userPlacesProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          // Button to add a new place
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const AddPlaceScreen(),
                ),
              );
            },
          ),
          // Button to sign out the user
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance
                  .signOut(); // Sign out from Firebase auth

              // Navigate to authentication screen after signing out
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (Route<dynamic> route) => false,
              );
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.onPrimary, // Icon color
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PlacesList(
          places: userPlaces, // Displays a list of places
        ),
      ),
    );
  }
}
