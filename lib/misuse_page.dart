import 'dart:io';
import 'app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'report_history.dart';
import 'mysql.dart';

class MisusePage extends StatefulWidget {
  const MisusePage({Key? key}) : super(key: key);

  @override
  _MisusePageState createState() => _MisusePageState();
}

class _MisusePageState extends State<MisusePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _descriptionController = TextEditingController();
  XFile? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'Misuse of Parking Spot'),
      body: ListView(
        children: [
          buildMisuseForm(context),
        ],
      ),
    );
  }

  Widget buildMisuseForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child:Form(
    key: _formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInputField('Descriptions', 'Write a brief description'),
          SizedBox(height: 15),
          buildInputField('Offender Plate Number', 'eg: ABC0000'),
          SizedBox(height: 15), // space between desc form and box under
          buildInputField('How Long This Occured', 'eg: 2 hours'),
          SizedBox(height: 15),

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
                  primary: Colors.transparent,
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
                _submitMisuseForm(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF00C4AC),
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
    )
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedFile != null ? XFile(pickedFile.path) : null;
    });
  }

  void _submitMisuseForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {

      String description = _descriptionController.text;
      String offender_plate = '';
      String time_occured = '';
      String? image_path = _selectedImage?.path;

      // Save data to MySQL database
      Mysql().insertMisuseData(description, offender_plate, time_occured, image_path);


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
          maxLines: 2,
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

          child: Column(
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
              SizedBox(height: 16),
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



