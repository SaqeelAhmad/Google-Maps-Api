import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMerkerInfoWindow extends StatefulWidget {
  const CustomMerkerInfoWindow({Key? key}) : super(key: key);

  @override
  State<CustomMerkerInfoWindow> createState() => _CustomMerkerInfoWindowState();
}

class _CustomMerkerInfoWindowState extends State<CustomMerkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latLang = //<LatLng>
      [
    LatLng(34.012752222197264, 71.50105327713736),
    LatLng(33.5889, 71.4429),
    LatLng(34.22197264, 71.32771373),
    LatLng(31.0127522264, 71.501053272),
    LatLng(32.052222197264, 74.375),
    LatLng(37.0127522221, 71.501057137),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLang.length; i++) {
      if(i %2 == 0){
        _markers.add(Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLang[i],
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                  Container(

                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10) ,
                               color: Colors.blue[100],
                            ),
                            child: const Center(child: CircleAvatar(radius: 30,backgroundColor: Colors.green,)),
                          ),
                        ),



                      ],
                    ),
                  ),
                  _latLang[i]


              );
            }
        ));
      }else{
        _markers.add(Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLang[i],
            onTap: (){
              _customInfoWindowController.addInfoWindow!(
                  Container(

                    decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.green),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10) ,
                              image:const DecorationImage(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9RMDBAbGZqCq5Y97PlZ_ATTG8vVCfdk3c6Eqfuk3d&s"
                                ,),fit: BoxFit.cover)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 6),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text('SSAPRO ShoP',style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("3ml")
                            ],),
                        ),
                        Container(child: const Text("Syed Saqeel Ahmad Shop open of all time."),)

                      ],
                    ),
                  ),
                  _latLang[i]


              );
            }
        ));

      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Info Window Example"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(34.012752222197264, 71.50105327713736),
              zoom: 14
            ),
            markers:Set<Marker>.of(_markers),
            onTap: (postition){
             _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (Postition){
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(controller: _customInfoWindowController,
          width: 300,height: 200,offset: 35,),


        ],
      ),
    );
  }
}
