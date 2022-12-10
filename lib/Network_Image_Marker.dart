import 'dart:async';
import 'dart:typed_data';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui'as ui;
import 'dart:ui';



class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {





  final Completer<GoogleMapController> _controller = Completer();
  
  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(34.00705675721427, 71.52783304448486),
  zoom: 14);



  final List<Marker> _marker = <Marker>[];

  List<LatLng> _latLang = [
    LatLng(34.00705675721427, 71.52783304448486),
    LatLng(34.01730026761817, 71.48937727579057)

  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for(int i = 0 ; i < _latLang.length ; i++){
      Uint8List? image= await loadNetWorkImage('http://via.placeholder.com/350x150');
     final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
       image!.buffer.asUint8List(),
       targetHeight: 100,
       targetWidth: 100
     );
final ui.FrameInfo  fromeInfo = await markerImageCodec.getNextFrame();
final ByteData? byteData = await fromeInfo.image.toByteData(
  format:  ui.ImageByteFormat.png
);
final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _marker.add(Marker(markerId: MarkerId(i.toString()),
        position: _latLang[i],
        icon: BitmapDescriptor.fromBytes(resizedImageMarker),
        infoWindow: InfoWindow(
          
          title: "title Marker "+i.toString(),

        )
      ));
      setState(() {

      });
    }
  }



  Future<Uint8List?> loadNetWorkImage(String path)async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info,_)=> completer.complete(info))
    );
    final imageInfo = await completer.future;
    final bytaData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png );
    return bytaData!.buffer.asUint8List();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Network Images Marker"),),
body:
      // body: CircleAvatar(
      //   child: CachedNetworkImage(
      //     imageUrl: "http://via.placeholder.com/350x150",
      //     placeholder: (context, url) => CircularProgressIndicator(),
      //     errorWidget: (context, url, error) => Icon(Icons.error),
      //   ),

    GoogleMap(initialCameraPosition: _kGooglePlex,
      myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_marker),
      ),

    );
  }
}
