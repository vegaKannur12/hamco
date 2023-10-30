import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/components/confrmPopup.dart';
import 'package:hamco/controller/controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DamagedList extends StatefulWidget {
  const DamagedList({super.key});

  @override
  State<DamagedList> createState() => _DamagedListState();
}

class _DamagedListState extends State<DamagedList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: P_Settings.loginPagetheme,
        title: Text("Damaged List"),
      ),
      body: Consumer<Controller>(
        builder: (context, value, child) => value.damLoading
            ? Center(
                child: SpinKitCircle(
                  color: P_Settings.loginPagetheme,
                ),
              )
            : value.damagedList.length == 0
                ? Center(
                    child: Container(
                        height: 200,
                        child: Lottie.asset(
                          'asset/empty_box.json',
                          // height: size.height*0.3,
                          // width: size.height*0.3,
                        )),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.damagedList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              trailing: InkWell(
                                onTap: () {
                                  ConfirmPopup popup = ConfirmPopup();
                                  popup.buildPopupDialog(
                                    context,
                                    value.damagedList[index]["pdm_id"],
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundImage: AssetImage("asset/done.png"),
                                  backgroundColor: Colors.grey[400],
                                  // child: IconButton(
                                  //     onPressed: () {},
                                  //     icon: Icon(
                                  //       Icons.done,
                                  //       color: Colors.green,
                                  //       size: 29,
                                  //     )),
                                ),
                              ),
                              title: Column(
                                children: [
                                  Text(
                                    value.damagedList[index]["damaged_pdt"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  // Flexible(
                                  //     child: Text(
                                  //   value.damagedList[index]["damaged_pdt"],
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.bold, fontSize: 15),
                                  // )),
                                  Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "Series       :   ",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      Text(value.damagedList[index]
                                          ["req_series"],style: TextStyle(fontWeight: FontWeight.bold),)
                                      // Flexible(
                                      //   child: Text(
                                      //     value.damagedList[index]["msg"],
                                      //     style: TextStyle(fontSize: 14),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Text("Message    :   "),
                                  Flexible(
                                    child: Text(
                                      value.damagedList[index]["msg"],
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
