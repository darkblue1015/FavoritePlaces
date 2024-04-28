import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:favorite_places/models/place.dart';

// A StatefulWidget that allows users to either select a new location on the map or display an existing one.
class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    // Default location centered around Googleplex, users can pass a specific location if needed.
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    // Determines whether the map is for selecting a new location (true) or just displaying (false).
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  // Stores the user's selected location on the map.
  LatLng? _pickedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Change the title based on whether the user is selecting or just viewing the location.
        title:
            Text(widget.isSelecting ? 'Pick your Location' : 'Your Location'),
        actions: [
          // If in selecting mode, show a save icon to confirm the selection.
          if (widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                // Pass the picked location back to the previous screen.
                Navigator.of(context).pop(_pickedLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        // Disable tap functionality when not in selecting mode.
        onTap: !widget.isSelecting
            ? null
            : (position) {
                setState(() {
                  // Set _pickedLocation to where the user tapped.
                  _pickedLocation = position;
                });
              },
        // Set initial position of the map based on passed or default location.
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        // Display marker on the initial or picked location.
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
