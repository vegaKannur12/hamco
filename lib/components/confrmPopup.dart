import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/controller/controller.dart';

import 'package:provider/provider.dart';

class ConfirmPopup {
  Future buildPopupDialog(
    BuildContext context,
    String itemId,
  ) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          // FocusManager.instance.primaryFocus!.unfocus();
          return new AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(
                  "Do You want to Confrim ?",
                  style: TextStyle(fontSize: 15),
                )),
              ],
            ),
            actions: <Widget>[
              Consumer<Controller>(
                builder: (mcontext, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: P_Settings.loginPagetheme),
                          onPressed: () {
                            Provider.of<Controller>(context, listen: false)
                                .confirmDamagedList(context,itemId);
                                  Navigator.pop(mcontext);
                          },
                          child: Text("Ok")),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: P_Settings.loginPagetheme),
                            onPressed: () {
                              Navigator.pop(mcontext);
                            },
                            child: Text("Cancel")),
                      )
                    ],
                  );
                },
              ),
            ],
          );
        });
  }
}
