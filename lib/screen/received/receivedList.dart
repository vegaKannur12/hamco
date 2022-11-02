import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:hamco/screen/bottomSheet/dispatchedBottom.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class ReceivedList extends StatefulWidget {
  const ReceivedList({Key? key}) : super(key: key);

  @override
  State<ReceivedList> createState() => _ReceivedListState();
}

class _ReceivedListState extends State<ReceivedList> {
  DispatchedInfoSheet info = DispatchedInfoSheet();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: P_Settings.loginPagetheme,
        ),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.dispatchedList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Provider.of<Controller>(context, listen: false)
                            .getdispatchedListInfo(
                                context, value.dispatchedList[index]["os_id"]);

                        info.showinfoSheet(
                          context,
                          size,
                        );

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           StockApprovalPage(
                        //             os_id:
                        //                 value.stock_approve_list[
                        //                     index]["os_id"],
                        //           )),
                        // );
                      },
                      trailing: Icon(Icons.arrow_forward),
                      title: Row(
                        children: [
                          Text(
                            value.dispatchedList[index]["series"].toString(),
                            style: GoogleFonts.aBeeZee(
                              textStyle: Theme.of(context).textTheme.bodyText2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: P_Settings.loginPagetheme,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14.0),
                            child: Text(
                              value.dispatchedList[index]["entry_date"]
                                  .toString(),
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Flexible(
                        child: Row(
                          children: [
                            Text(
                              "Branch : ",
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                            ),
                            Text(
                              value.dispatchedList[index]["from_branch"]
                                  .toString(),
                              style: GoogleFonts.aBeeZee(
                                textStyle:
                                    Theme.of(context).textTheme.bodyText2,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                color: P_Settings.loginPagetheme,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
