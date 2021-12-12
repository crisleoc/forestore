import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  final double? latitud;
  final double? longitud;

  const MapSample({
    Key? key,
    required this.latitud,
    required this.longitud,
  }) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState(latitud, longitud);
}

class MapSampleState extends State<MapSample> {
  final double? latitud;
  final double? longitud;

  MapSampleState(this.latitud, this.longitud);

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
        ),
        child: GoogleMap(
          mapType: MapType.normal,
          markers: {
            Marker(
                markerId: MarkerId('_MapsMarker'),
                infoWindow: InfoWindow(title: 'Aquí'),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(latitud!, longitud!))
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(latitud!, longitud!),
            zoom: 15,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ));
  }
}
