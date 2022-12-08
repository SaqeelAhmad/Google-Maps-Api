import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart'as http ;


class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApiScreen> createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {


    String kPLACES_API_KEY = "AIzaSyAOam7_nAHXXdncIgRclxnFrULOKxJvT6w";
    String type = '(regions)';

    try{
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print('mydata');
      print(data);
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    }catch(e){
      // toastMessage('success');
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Google Places Search Api"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4,left: 3,right: 3),
            child: TextFormField(
              minLines: 1,
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search Places With Name",
                prefixIcon: Icon(Icons.search),
              suffixIcon: InkWell(onTap: (){
                _controller.clear() ;
              },
                child:Icon(Icons.close),),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),)
            ),),
          ),

          Expanded(child: ListView.builder(
            itemCount:  _placeList.length,
              itemBuilder: (context , index){
return ListTile(
  onTap: () async {
    List<Location> locations = await locationFromAddress(_placeList[index]["description"]);
    print(locations.last.latitude);
    print(locations.last.longitude);

  },
  title:  Text(_placeList[index]["description"]),
);
          }))
        ],
      ),
    );
  }
}
