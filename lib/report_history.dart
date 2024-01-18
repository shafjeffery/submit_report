import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'mysql.dart';
import 'condition_page.dart';
import 'misuse_page.dart';

class ReportHistory extends StatefulWidget {
  const ReportHistory({Key? key}) : super(key: key);

  @override
  _ReportHistoryState createState() => _ReportHistoryState();
}

class _ReportHistoryState extends State<ReportHistory> {
  final _formKey = GlobalKey<FormState>();




  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Report History'),
      body: ListView(
        children: [

        ],
      ),
    );
  }
}