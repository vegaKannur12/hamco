import 'package:flutter/material.dart';
import 'package:hamco/components/commonColor.dart';
import 'package:provider/provider.dart';

import '../../controller/controller.dart';

class StatusMonitoring extends StatefulWidget {
  const StatusMonitoring({super.key});

  @override
  State<StatusMonitoring> createState() => _StatusMonitoringState();
}

class _StatusMonitoringState extends State<StatusMonitoring> {
  int _index = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: P_Settings.loginPagetheme),
        body: Consumer<Controller>(
          builder: (context, value, child) {
            return Container(
              height: double.infinity,
              child: Stepper(
                  controlsBuilder: (context, details) {
                    return Row(
                      children: <Widget>[
                        Container(),
                        Container(),
                      ],
                    );
                  },
                  // currentStep: _index,
                  onStepCancel: () {},
                  onStepContinue: () {},
                  onStepTapped: (int index) {},
                  steps: value.statusList.map((e) {
                    return Step(
                        isActive: e["isAct"] == "1" ? true : false,
                        title: Text(e["title"]),
                        content: Container(
                            alignment: Alignment.centerLeft,
                            child: Text("")));
                  }).toList()

                  // steps: <Step>[
                  //   Step(
                  //     isActive: true,
                  //     title: Text('Level 1'),
                  //     content: Container(
                  //         alignment: Alignment.centerLeft,
                  //         child: Text('Content for Step 1')),
                  //   ),
                  //   Step(
                  //     isActive: true,
                  //     title: Text('Step 2 title'),
                  //     content: Container(
                  //         alignment: Alignment.centerLeft,
                  //         child: Text('Content for Step 2')),
                  //   ),
                  //   Step(
                  //     isActive: true,
                  //     title: const Text('Step 3 title'),
                  //     content: Container(
                  //         alignment: Alignment.centerLeft,
                  //         child: const Text('Content for Step 3')),
                  //   ),
                  //   Step(
                  //     title: const Text('Step 4 title'),
                  //     content: Container(
                  //         alignment: Alignment.centerLeft,
                  //         child: Text('Content for Step 4')),
                  //   ),
                  // ],
                  ),
            );
          },
        ));
  }
}
