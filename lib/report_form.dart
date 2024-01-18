import 'package:flutter/material.dart';
import 'app_bar.dart';
import 'condition_page.dart';
import 'misuse_page.dart';

import 'mysql.dart';

class SubmitReport extends StatefulWidget {
  const SubmitReport({Key? key}) : super(key: key);

  @override
  _SubmitReportState createState() => _SubmitReportState();
}

class _SubmitReportState extends State<SubmitReport> {
  final _formKey = GlobalKey<FormState>();
  String selectedIssue = '';


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Report'),
      body: ListView(
        children: [
          buildReportForm(context),
        ],
      ),
    );
  }

  Widget buildReportForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child:Form(
        key: _formKey,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInputField('Email', 'eg: IncessWahab@gmail.com',validateNonEmpty,_emailController ),
          buildInputField('Location', 'Imago Shopping Mall', validateNonEmpty, _locationController),
          buildInputField('Zone', 'eg: A', validateNonEmpty, _zoneController),
          buildInputField('Parking Number', 'eg: ABC0000', validateNonEmpty, _parking_numberController),
          buildIssueSelector(),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {

                // move to condition page if user select condition
                if (selectedIssue == 'Condition of Parking Spot') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  ConditionPage()),
                  );
                  // move to misuse page if user select misuse
                } else if (selectedIssue == 'Misuse of Parking Spot') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MisusePage()),
                  );
                } else {
                  print("test");
                }
                } else {
                  print("Form is not valid");

                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C4AC),
                minimumSize: Size(double.infinity, 40),
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _zoneController = TextEditingController();
  final TextEditingController _parking_numberController = TextEditingController();

  Widget buildInputField(String labelText, String hintText, String? Function(String?)? validator, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 20.0
            ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            fillColor: const Color(0xFFD6CACA),
          ),
          validator: validator,
        ),
        const SizedBox(height: 10),
      ],
    );
  }




  String? validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }


  Widget buildIssueSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Issue:',
          style: TextStyle(
            fontFamily: 'Ubuntu',
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),

        const SizedBox(height: 6),
        Row(
          children: [
            buildCircularBox(
              'Condition of Parking Spot',
              selectedIssue == 'Condition of Parking Spot',
            ),
            const SizedBox(width: 10),
            buildCircularBox(
              'Misuse of Parking Spot',
              selectedIssue == 'Misuse of Parking Spot',
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCircularBox(String issue, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIssue = issue;
        });
      },
      child: Container(
        width: 170,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF00C4AC) : Colors.grey,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            issue,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.white,
              fontFamily: 'Ubuntu',
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
