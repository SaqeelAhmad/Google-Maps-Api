import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';

import 'package:geocoding/geocoding.dart';


class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  String Staddress = "";
  String staddress2 = "";
  String staddress3= "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Maps page 2"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Staddress),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () async {
                // From a query
                final query =
                    "2G62+WCX2G62+WCX, Mohallah Akazai Tahkal, Peshawar, Khyber Pakhtunkhwa, Pakistan";
                var addresses =
                    await Geocoder.local.findAddressesFromQuery(query);
                var second = addresses.first;
                print("${second.featureName} : ${second.coordinates}");

                final coordinates =
                    new Coordinates(34.012752222197264, 71.50105327713736);
                var address = await Geocoder.local
                    .findAddressesFromCoordinates(coordinates);
                var first = address.first;
                print("Address : " +
                    first.featureName.toString() +
                    first.addressLine.toString());

                setState(() {
                  Staddress = "Address : " +
                      first.featureName.toString() +
                      first.addressLine.toString();
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(child: Text("Convert")),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(onPressed: () async {
              List<Location> locations = await locationFromAddress("2G62+WCX2G62+WCX, Mohallah Akazai Tahkal, Peshawar, Khyber Pakhtunkhwa, Pakistan");


              List<Placemark> placemarks = await placemarkFromCoordinates(
                  34.012752222197264, 71.50105327713736);
              setState(() {
                 staddress2= placemarks.reversed.last.country.toString()+" "+placemarks.reversed.last.locality.toString()+" "+ placemarks.reversed.last.subLocality.toString()+" "+placemarks.reversed.last.street.toString() ;
                 staddress3 = locations.last.latitude.toString() +" " +locations.last.longitude.toString();
                print (staddress3);
              });
            }, child: Text("Convert")),
          ),
          Text(staddress2),
          Text(" Locations "+staddress3),

        ],
      ),
    );
  }
}
