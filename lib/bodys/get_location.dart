import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungtransport/utility/my_dialog.dart';

class GetLocationShowMap extends StatefulWidget {
  const GetLocationShowMap({Key? key}) : super(key: key);

  @override
  State<GetLocationShowMap> createState() => _GetLocationShowMapState();
}

class _GetLocationShowMapState extends State<GetLocationShowMap> {
  double? lat, lng;
  bool load = true;

  @override
  void initState() {
    super.initState();
    findLatLng();
  }

  

  Future<void> findLatLng() async {
    bool locationEnable;
    LocationPermission locationPermission;

    locationEnable = await Geolocator.isLocationServiceEnabled();
    if (locationEnable) {
      // Enablen Location Service
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        MyDialog(context: context).normalDialog(
            title: 'Denyed Forever',
            subTitle: 'Please Open Premission',
            pressFunc: () {
              exit(0);
            });
      }

      if (locationPermission == LocationPermission.denied) {
        await Geolocator.requestPermission();
      } else {
        // Alway
        print('Location Can Find');

        Position position = await findPosition();
        if (position != null) {
          lat = position.latitude;
          lng = position.longitude;
          print('lat = $lat, lng = $lng');
          load = false;
          setState(() {});
        }
      }
    } else {
      MyDialog(context: context).normalDialog(
          title: 'Non Location Service',
          subTitle: 'Please Open Service',
          pressFunc: () {
            exit(0);
          });
    }
  }

  Future<Position> findPosition() async {
    Position? position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = null;
    }
    return position!;
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('id'),
        position: LatLng(lat!, lng!)
      ),
      Marker(
        markerId: MarkerId('id1'),
        position: LatLng(13.678060167212296, 100.58310091480081)
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(lat!, lng!),
                zoom: 16,
              ),
              onMapCreated: (value) {},
              markers: myMarker(),
            ),
    );
  }
}
