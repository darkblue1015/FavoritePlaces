// Import necessary Flutter and Firebase packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // For state management
import 'package:google_fonts/google_fonts.dart'; // For custom fonts
import 'package:firebase_core/firebase_core.dart'; // Firebase core functionalities
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication
import 'screens/auth.dart'; // Authentication screen
import 'screens/places.dart'; // Places screen

import 'firebase_options.dart'; // Firebase project configuration

// Define the color scheme for the application
final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247), // Primary color
  background: const Color.fromARGB(255, 56, 49, 66), // Background color
);

// Define the theme settings, leveraging Material 3 guidelines
final theme = ThemeData().copyWith(
  useMaterial3: true, // Enable Material 3 design
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

// Main entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Initialize Firebase with platform-specific settings
  );
  runApp(
    const ProviderScope(
        child: MyApp()), // Wrap the app with ProviderScope for state management
  );
}

// Root widget of the application
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Great Places', // App title
      theme: theme, // Apply the defined theme
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), // Listen to auth state changes
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading indicator while waiting
          } else if (userSnapshot.hasData) {
            return const PlacesScreen(); // Navigate to Places screen if user is logged in
          } else {
            return const AuthScreen(); // Navigate to Authentication screen if user is not logged in
          }
        },
      ),
    );
  }
}
