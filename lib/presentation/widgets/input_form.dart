import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/user_input.dart';
import '../../domain/usecases/get_report_usecase.dart';
import '../pages/result_page.dart';
import '../../core/errors/exceptions.dart';

class InputForm extends StatefulWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _formKey = GlobalKey<FormState>();
  String? _mbti;
  String? _bloodType;
  DateTime? _birthday;

  final List<String> _mbtiTypes = [
    'INTJ', 'INTP', 'ENTJ', 'ENTP', 'INFJ', 'INFP', 'ENFJ', 'ENFP',
    'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ', 'ISTP', 'ISFP', 'ESTP', 'ESFP'
  ];

  final List<String> _bloodTypes = ['A', 'B', 'AB', 'O'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Profile In This Life',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I interact with the world like ...',
                  style: TextStyle(color: Colors.indigo, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                  ),
                  value: _mbti,
                  hint: Text('Choose MBTI Type'),
                  items: _mbtiTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _mbti = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your MBTI type';
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I was born with...',
                  style: TextStyle(color: Colors.indigo, fontSize: 16),
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                  ),
                  value: _bloodType,
                  hint: Text('Choose Blood Type'),
                  items: _bloodTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _bloodType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your blood type';
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'I was assigned on this planet when ...',
                  style: TextStyle(color: Colors.indigo, fontSize: 16),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Choose Birthday',
                    contentPadding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2000, 1),
                      firstDate: DateTime(1950, 1),
                      lastDate: DateTime(2015, 12, 31),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.indigo, // header background color
                              onPrimary: Colors.white, // header text color
                              onSurface: Colors.indigo, // body text color
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.indigo, // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (picked != null && picked != _birthday) {
                      setState(() {
                        _birthday = picked;
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: _birthday == null ? '' : DateFormat('MM-dd').format(_birthday!),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your birthday';
                    }
                    return null;
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final userInput = UserInput(
                      mbti: _mbti!,
                      bloodType: _bloodType!,
                      birthday: _birthday!,
                    );
                    final useCase = GetReportUseCase();
                    try {
                      final report = await useCase.execute(userInput);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(report: report),
                        ),
                      );
                    } catch (e) {
                      String errorMessage;
                      if (e is ServerException) {
                        errorMessage = 'Failed to load data from the server.';
                      } else if (e is CacheException) {
                        errorMessage = 'No report found for the given input.';
                      } else {
                        errorMessage = 'An unexpected error occurred.';
                      }
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text(errorMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                ),
                child: Text(
                  'My Finkey Type',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
