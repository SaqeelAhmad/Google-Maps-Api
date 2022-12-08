import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class PloygoneScreen extends StatefulWidget {
  const PloygoneScreen({Key? key}) : super(key: key);

  @override
  State<PloygoneScreen> createState() => _PloygoneScreenState();
}

class _PloygoneScreenState extends State<PloygoneScreen> {

  Completer<GoogleMapController>  _controller= Completer();

  CameraPosition  _KGooglePlex = CameraPosition(
      target: LatLng(33.526064, 71.580125),
  zoom: 15);


  final Set<Marker> _marker={};
 final Set<Polygon> _polygon =  HashSet<Polygon>();
 
 List<LatLng> points =[
   LatLng(33.526064, 71.580125 ),
   LatLng(33.61403017278039, 71.47686318783819),
   LatLng(33.59688957103559, 71.35249999130791),
   LatLng(33.51220080331997, 71.42802298835907),
   LatLng(33.519354, 71.426310),
   LatLng(33.549968476902386, 71.42254783582257),
   LatLng(33.526064, 71.580125 ),
 ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(polygonId: PolygonId('1'),points: points,
      fillColor: Colors.green.withOpacity(0.3),
      geodesic: true,
      strokeWidth: 4,
      strokeColor: Colors.cyanAccent)
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Ploygone"),
        
      ),
      body: GoogleMap(initialCameraPosition:  _KGooglePlex,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
        polygons: _polygon,
      ),
    );
  }
}
