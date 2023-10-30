import 'package:flutter/material.dart';
import 'package:hamco/components/commonColor.dart';



class CustomSnackbar {
  showSnackbar(BuildContext context, String content,String type) {
    ScaffoldMessenger. of(context).showSnackBar(
      SnackBar(
        backgroundColor:Color.fromARGB(255, 119, 14, 7),
        duration: const Duration(seconds: 2),
        content: Text("${content}"),
        action: SnackBarAction(
          label: '',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
