import 'dart:io';
import 'app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'report_history.dart';
import 'mysql.dart';

class ConditionPage extends StatefulWidget {
  const ConditionPage({Key? key}) : super(key: key);

  @override
  _ConditionPageState createState() => _ConditionPageState();
}

class _ConditionPageState extends State<ConditionPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Condition of Parking Spot'),
      body: ListView(
        children: [
          buildConditionForm(context),
        ],
      ),
    );
  }

  Widget buildConditionForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInputField('Descriptions', 'Write a brief description'),
          SizedBox(height: 20), // space between desc form and box under

          Center(
            child: _selectedImage != null
                ? Image.file(
              _selectedImage!.path as File,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFD6CACA)
              ),
                child: ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),

                child: Text('UPLOAD IMAGE',
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey[700]
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                _submitConditionForm(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C4AC),
                minimumSize: Size(double.infinity, 40),
              ),
              child: const Text(
                'Submit',
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

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedFile != null ? XFile(pickedFile.path) : null;
    });
  }

  void _submitConditionForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {

      String description = _descriptionController.text;
      String? image_path = _selectedImage?.path;

      // Save data to MySQL database
      Mysql().insertConditionData(description, image_path);


      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Report Submitted'),
            content: const Text('Your Report has been submitted successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  Widget buildInputField(String labelText, String hintText) {
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
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: const Color(0xFFD6CACA),
          ),
          maxLines: 5,
          //validator: validator,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
  void _submitReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report Submitted'),
          content: Text('Your report has been submitted successfully.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _showReportHistory();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showReportHistory() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
           height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFCCE7EB),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          clipBehavior: Clip.antiAlias,

          child: Column(
           // mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportHistory()
                    )
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF00C4AC),
                    minimumSize: Size(double.infinity, 40),
                    textStyle: const TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 18,
                      color: Colors.black,
                    )
                ),
                child: const Text('Report History'
                ),
              ),
               SizedBox(height:10 ),
              Spacer(), // x button at bottom center
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}


