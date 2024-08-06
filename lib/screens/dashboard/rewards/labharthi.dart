import 'package:flutter/material.dart';
import 'package:maru_naam_che_pathshala_2/models/labharthi_modal.dart';
import 'package:maru_naam_che_pathshala_2/utils/utils.dart';

class Labharthi extends StatefulWidget {
  const Labharthi({super.key});

  @override
  State<Labharthi> createState() => _LabharthiState();
}

class _LabharthiState extends State<Labharthi> {
  List<LabharthiModal> _modal = [];
  bool load = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Labharthi".text.white.make(),
      ),
      body: (_modal.isNotEmpty)
          ? ListView.builder(
              itemCount: _modal.length,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: _modal[i].date! != '0000-00-00'
                      ? _modal[i].date!.text.make()
                      : null,
                  title: _modal[i].name!.text.make(),
                  subtitle: _modal[i].nimit! != ''
                      ? _modal[i].nimit!.text.sm.make()
                      : null,
                  trailing: _modal[i].amount!.text.bold.white.make(),
                );
              })
          : (!load)
              ? progressInd()
              : Center(
                  child: "NO LABHARTHI FOUND".text.make(),
                ),
    );
  }

  getData() async {
    final data = await ApiService.getData(endPoint: EndPoints.labharthi);
    _modal = labharthiModallFromJson(data);
    load = true;
    setState(() {});
  }
}
