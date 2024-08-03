import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/screens/screens.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class SwitchChildScreen extends StatefulWidget {
  const SwitchChildScreen({super.key});

  @override
  State<SwitchChildScreen> createState() => _SwitchChildScreenState();
}

class _SwitchChildScreenState extends State<SwitchChildScreen> {
  List<StudentModel> students = [];
  String mnpid = '';
  bool change = false;
  @override
  void initState() {
    super.initState();
    students = studentModelListFromJson(box.read(Keys.studentList));
    mnpid = box.read(Keys.sid);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didpop) {
        change ? Get.offAll(() => const DashBoardScreen()) : Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: "Select Child".text.make(),
          leading: BackButton(
            onPressed: () {
              if (change) {
                Get.offAll(() => const DashBoardScreen());
              } else {
                Get.back();
              }
            },
          ),
        ),
        body: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, i) {
              return ListTile(
                tileColor: Colors.white,
                leading: const Icon(FontAwesomeIcons.idCard),
                title: students[i].fullName!.text.sm.make(),
                trailing: students[i].sid! == mnpid
                    ? "Selected"
                        .text
                        .green500
                        .make()
                        .box
                        .p4
                        .border(color: Colors.green)
                        .make()
                    : ElevatedButton(
                        onPressed: () {
                          change = true;
                          box.write(Keys.sid, students[i].sid!);
                          mnpid = students[i].sid!;
                          setState(() {});
                        },
                        child: "Select".text.white.make()),
              );
            }),
      ),
    );
  }
}
