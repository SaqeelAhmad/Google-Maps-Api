import 'package:flutter/material.dart';
import 'package:google_maps/Container_Button_Widget.dart';
import 'package:google_maps/Home_Page2.dart';
import 'package:google_maps/ploygone_screen.dart';
import 'package:google_maps/polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Custom_Marker_Screen.dart';
import 'Custom_Merker_Info_Window.dart';
import 'Get_User_Currnt_Location_Screen.dart';
import 'Google_Maps_Theme.dart';
import 'Google_Places_Screen.dart';
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
      home:MyHome()

      //
      //
      // PloygoneScreen(),


    );
  }
}


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home "),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ContainerButton(title: "Google Maps", value: MyHomePage()),
ContainerButton(title: "Google Map Styal", value:GoogleMapsThem() ),
          ContainerButton(title: "Convert address to Locations", value: MyHomePage2()),
          ContainerButton(title: "Add Marker in Maps", value: CustomMerkerInfoWindow()),
          ContainerButton(title: "Add Custom Marker", value: CustomMarkerScreen()),
          ContainerButton(title: "User Current Location", value: GetUserCurrntLocationScreen()),
          ContainerButton(title: "Search Places in Google Maps ", value: GooglePlacesApiScreen()),
          ContainerButton(title: "Add Custom Marker to Network", value: NetworkImageMarker()),
          ContainerButton(title: "Ploy gone", value:PloygoneScreen() ),
          ContainerButton(title: "PolyLine", value: PolylineSceen(),)

        ],
      ),
    );
  }
}

