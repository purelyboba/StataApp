import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../utils.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: generateMap(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<Widget> generateMap() async {
    Position currentPosition = await Utils.getUserLocation();

    await dotenv.load();

    return FlutterMap(
      options: MapOptions(
        // center: latLng.LatLng(51.5, -0.09),
        zoom: 18,
        center: LatLng(
          currentPosition.latitude,
          currentPosition.longitude,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: dotenv.env['MAPBOX-URL'],
          additionalOptions: {
            'accessToken': dotenv.env['MAPBOX-ACCESS-TOKEN']!,
            'id': dotenv.env['MAPBOX-ID']!,
          },
        ),
      ],
    );
  }
}
