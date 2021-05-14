import 'package:client/models/generate_report_form_model.dart';
import 'package:client/models/patient_list_object_mode.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class GenerateReportForm extends StatefulWidget {
  final Patient patient;
  const GenerateReportForm({this.patient});

  @override
  _GenerateReportFormState createState() =>
      _GenerateReportFormState(this.patient);
}

class _GenerateReportFormState extends State<GenerateReportForm> {
  Patient _patient;
  _GenerateReportFormState(Patient _temppatient) {
    this._patient = _temppatient;
  }

  final _form = GlobalKey<FormState>();
  final GenerateReport _reportObj = GenerateReport();

  @override
  Widget build(BuildContext context) {
    print(_patient);
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffA6E97C), Color(0xffF4F4F4)])),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: FormBuilder(
          key: _form,
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(width: deviceWidth * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      Row(
                        children: [
                          Container(
                            height: deviceHeight * 0.05,
                            width: deviceWidth * 0.9,
                            child: Text(
                              'Fill the details :-',
                              style: TextStyle(fontSize: deviceWidth * 0.06),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            // height: deviceHeight * 0.12,
                            width: deviceWidth * 0.9,
                            child: TextFormField(
                              onSaved: (val) => _reportObj.name = val,
                              decoration: customFieldDecoration(
                                  deviceWidth: deviceWidth, hint: 'Name'),
                            ),
                          ),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      Container(
                        // height: deviceHeight * 0.12,
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: deviceHeight * 0.12,
                              width: deviceWidth * 0.42,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (val) =>
                                    _reportObj.age = int.parse(val),
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth, hint: 'Age'),
                              ),
                            ),
                            Container(
                              // height: deviceHeight * 0.1,
                              width: deviceWidth * 0.42,
                              child: DropdownButtonFormField(
                                  elevation: 0,
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth, hint: 'Gender'),
                                  items: ['male', 'female']
                                      .map<DropdownMenuItem<String>>(
                                    (String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.gender = val.toString();
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                      Row(
                        children: [
                          Container(
                              width: deviceWidth * 0.9,
                              child: FormBuilderRadioGroup(
                                wrapAlignment: WrapAlignment.spaceAround,
                                activeColor: Colors.black,
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth,
                                    hint: 'Any family member diabetic'),
                                name: 'family_member',
                                onSaved: (val) => _reportObj.familyMember = val,
                                onChanged: (val) =>
                                    _reportObj.familyMember = val,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                options: [
                                  'Yes',
                                  'No',
                                ]
                                    .map((val) => FormBuilderFieldOption(
                                          value: val,
                                          child: Text(val),
                                        ))
                                    .toList(growable: false),
                                controlAffinity: ControlAffinity.trailing,
                              )),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              // height: deviceHeight * 0.1,
                              width: deviceWidth * 0.9,
                              child: DropdownButtonFormField(
                                  elevation: 0,
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth,
                                      hint: 'Physically Active'),
                                  items: [
                                    'less than half hour',
                                    'more than half hour',
                                    'one hour or more'
                                  ].map<DropdownMenuItem<String>>(
                                    (String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.physicallyActive = val;
                                    });
                                  })),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        // height: deviceHeight * 0.12,
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: deviceHeight * 0.12,
                              width: deviceWidth * 0.42,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (val) =>
                                    _reportObj.weight = int.parse(val),
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth, hint: 'Weight'),
                              ),
                            ),
                            Container(
                                // height: deviceHeight * 0.1,
                                width: deviceWidth * 0.42,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onSaved: (val) =>
                                      _reportObj.height = double.parse(val),
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth, hint: 'Height'),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        // height: deviceHeight * 0.12,
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: deviceHeight * 0.12,
                              width: deviceWidth * 0.42,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onSaved: (val) =>
                                    _reportObj.bloodPressure = val,
                                decoration: customFieldDecoration(
                                  deviceWidth: deviceWidth,
                                  hint: 'Blood Pressure',
                                ),
                              ),
                            ),
                            Container(
                              // height: deviceHeight * 0.1,
                              width: deviceWidth * 0.42,
                              child: DropdownButtonFormField(
                                  elevation: 0,
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth,
                                      hint: 'Average Sleep hour'),
                                  items: [
                                    '4',
                                    '5',
                                    '6',
                                    '7',
                                    '8',
                                    '9',
                                    '10',
                                    '11'
                                  ].map<DropdownMenuItem<String>>(
                                    (String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.averageSleep = val;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              width: deviceWidth * 0.9,
                              child: FormBuilderRadioGroup(
                                wrapAlignment: WrapAlignment.spaceAround,
                                activeColor: Colors.black,
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth,
                                    hint: 'Smoking habits'),
                                name: 'smoking',
                                onSaved: (val) => _reportObj.smoking = val,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                options: [
                                  'Yes',
                                  'No',
                                ]
                                    .map((val) => FormBuilderFieldOption(
                                          value: val,
                                          child: Text(val),
                                        ))
                                    .toList(growable: false),
                                controlAffinity: ControlAffinity.trailing,
                              )),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              width: deviceWidth * 0.9,
                              child: FormBuilderRadioGroup(
                                wrapAlignment: WrapAlignment.spaceAround,
                                activeColor: Colors.black,
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth,
                                    hint: 'Alcohol consumer'),
                                name: 'Alcohol',
                                onSaved: (val) => _reportObj.alcohol = val,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                options: [
                                  'Yes',
                                  'No',
                                ]
                                    .map((val) => FormBuilderFieldOption(
                                          value: val,
                                          child: Text(val),
                                        ))
                                    .toList(growable: false),
                                controlAffinity: ControlAffinity.trailing,
                              )),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              width: deviceWidth * 0.9,
                              child: FormBuilderRadioGroup(
                                wrapAlignment: WrapAlignment.spaceAround,
                                activeColor: Colors.black,
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth,
                                    hint: 'Sound sleep'),
                                name: 'sleep',
                                onSaved: (val) => _reportObj.soundSleep = val,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                options: [
                                  'Yes',
                                  'No',
                                ]
                                    .map((val) => FormBuilderFieldOption(
                                          value: val,
                                          child: Text(val),
                                        ))
                                    .toList(growable: false),
                                controlAffinity: ControlAffinity.trailing,
                              )),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              width: deviceWidth * 0.9,
                              child: FormBuilderRadioGroup(
                                wrapAlignment: WrapAlignment.spaceAround,
                                activeColor: Colors.black,
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth,
                                    hint: 'Taking any medicine regularly'),
                                name: 'medicine',
                                onSaved: (val) =>
                                    _reportObj.medicineRegularly = val,
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                options: [
                                  'Yes',
                                  'No',
                                ]
                                    .map((val) => FormBuilderFieldOption(
                                          value: val,
                                          child: Text(val),
                                        ))
                                    .toList(growable: false),
                                controlAffinity: ControlAffinity.trailing,
                              )),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Row(
                        children: [
                          Container(
                              width: deviceWidth * 0.9,
                              child: DropdownButtonFormField(
                                  elevation: 0,
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth,
                                      hint: 'How much often consume junk food'),
                                  items: [
                                    'Ocassionally',
                                    'often',
                                    'very often',
                                    'always'
                                  ].map<DropdownMenuItem<String>>(
                                    (String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.junkFood = val;
                                    });
                                  })),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        // height: deviceHeight * 0.12,
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: deviceHeight * 0.12,
                              width: deviceWidth * 0.42,
                              child: DropdownButtonFormField(
                                  elevation: 0,
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth, hint: 'Stress'),
                                  items: [
                                    'not at all',
                                    'sometime',
                                    'very often',
                                    'always'
                                  ].map<DropdownMenuItem<String>>(
                                    (String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.stress = val;
                                    });
                                  }),
                            ),
                            Container(
                              // height: deviceHeight * 0.1,
                              width: deviceWidth * 0.42,
                              child: DropdownButtonFormField(
                                  elevation: 0,
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth,
                                      hint: 'Urination frequency'),
                                  items: ['normal', 'high']
                                      .map<DropdownMenuItem<String>>(
                                    (String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(val),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.urinationFreq = val;
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        width: deviceWidth * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                                color: const Color(0xffA6E97C),
                                onPressed: () {
                                  print(_reportObj);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => MyHomePage(),
                                  //   ),
                                  // );
                                },
                                child: const Text('Generate')),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
