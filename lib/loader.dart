import "package:flutter/material.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatefulWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:Colors.white60,
      child:const Center(
        child:SpinKitCircle(color:Colors.blue),
      ),
    );
  }
}
