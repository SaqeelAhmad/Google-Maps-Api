import 'package:flutter/material.dart';


class ContainerButton extends StatefulWidget {
   ContainerButton({Key? key,required this.title,required this.value}) : super(key: key);
String title='';
// ignore: prefer_typing_uninitialized_variables
final value ;
  @override
  State<ContainerButton> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 20),

      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>widget.value));
        },
        child: Container(height: 50,
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 2,color: Colors.black)
          ),
          child: Center(child: Text(widget.title,style: TextStyle(fontSize: 20),)),

        ),
      ),
    );
  }
}
