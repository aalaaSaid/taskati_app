import 'package:flutter/material.dart';

 Future navigateTo(BuildContext context, Widget view) async{
   return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => view));
}

navigateWithReplacement(BuildContext context, Widget view) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => view));
}