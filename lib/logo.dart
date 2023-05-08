import "package:flutter/material.dart";
import "equal_icons.dart";

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Container(
        child:Center(
          child:Container(
            padding:const EdgeInsets.all(25),
            margin: const EdgeInsets.all(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.2, 0.4, 0.6, 0.8, 1.0],
                colors: [
                  Color(0xff2e2e30),
                  Color(0xff2b2c36),
                  Color(0xff2a2752),
                  Color(0xff1e1a54),
                  Color(0xff0c093d),
                ],
              ),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              children:[
                Container(
                  padding:const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child:const Icon(Icons.add,color:Colors.white60,size:62),
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child:const Icon(Icons.remove,color:Colors.white60,size:62),
                ),
                Container(
                  padding:const EdgeInsets.fromLTRB(20, 0, 0, 20),
                  child:const Icon(Icons.close,color:Colors.white60,size:62),
                ),
                Container(
                    padding:const EdgeInsets.fromLTRB(0, 0, 20, 30),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(0),color:const Color(0xff32324f),),
                  child:const Icon(Equal.equals,color:Colors.white60,size:52)
                )
              ],
            )
          ))),
    );
  }
}
