import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';




class GoogleMapsThem extends StatefulWidget {
  const GoogleMapsThem({Key? key}) : super(key: key);

  @override
  State<GoogleMapsThem> createState() => _GoogleMapsThemState();
}

class _GoogleMapsThemState extends State<GoogleMapsThem> {
String mapsTheme = '';

   Completer<GoogleMapController> _controller = Completer();
   static final CameraPosition _kGooglePlex = const CameraPosition(
       target: LatLng(34.012752222197264, 71.50105327713736), zoom: 14);
   
   
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString("assets/maps_theme/Silver_Theme.json").then((value){
 mapsTheme = value ;
    }).catchError((error){
      print("error :"+error.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Google Maps Theme"),
      actions: [
        PopupMenuButton(itemBuilder: (BuildContext context)=> [
          PopupMenuItem(
              onTap: (){
                _controller.future.then((value) {
                  DefaultAssetBundle.of(context).loadString("assets/maps_theme/Silver_Theme.json").then((string){
                    value.setMapStyle(string);
                  });
                });
              },
              child: Text("Silver")),
          PopupMenuItem(
              onTap:(){
                _controller.future.then((value) {
                  DefaultAssetBundle.of(context).loadString("assets/maps_theme/dark_Theme.json").then((string){
                    value.setMapStyle(string);
                  });
                });

              },
              child: Text("Dark"))
        ],)
      ],),
      body: SafeArea(
        child: GoogleMap(initialCameraPosition: _kGooglePlex,
        //mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller){
          controller.setMapStyle(mapsTheme);
          _controller.complete(controller);
          },

        ),
      ),
    );
  }
}
