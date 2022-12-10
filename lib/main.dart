import 'package:flutter/material.dart';
import 'package:google_maps/ploygone_screen.dart';
import 'package:google_maps/polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Custom_Marker_Screen.dart';
import 'Custom_Merker_Info_Window.dart';
import 'Get_User_Currnt_Location_Screen.dart';
import 'Home_Page.dart';
import 'Network_Image_Marker.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: NetworkImageMarker(),
      //PolylineSceen(),
      // PloygoneScreen(),
      //CustomMerkerInfoWindow(),
      //CustomMarkerScreen(),
      //GooglePlacesApiScreen(),
      //GetUserCurrntLocationScreen(),
        //MyHomePage2(),
       //MyHomePage(),
    );
  }
}

