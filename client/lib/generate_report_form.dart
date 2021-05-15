import 'package:client/models/generate_report_form_model.dart';
import 'package:client/models/patient_list_object_mode.dart';
import 'package:client/resources/api_provider.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class GenerateReportForm extends StatefulWidget {
  final Patient patient;
  const GenerateReportForm({this.patient});

  @override
  _GenerateReportFormState createState() =>
      _GenerateReportFormState(patient);
}

class _GenerateReportFormState extends State<GenerateReportForm> {
  Patient _patient;
  _GenerateReportFormState(Patient _tempPatient) {
    _patient = _tempPatient;
  }

  final _form = GlobalKey<FormState>();
  final GenerateReport _reportObj = GenerateReport();

  void postGenerate(Patient _tempPatient) {
    FocusManager.instance.primaryFocus.unfocus();
    if (_form.currentState.validate()) {
      _form.currentState.save();
      generateReport(context, _reportObj, _tempPatient);
      // _form.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
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
        body: Form(
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
                              'Enter the patient details :-',
                              style: GoogleFonts.poppins(
                                  fontSize: deviceWidth * 0.06),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: deviceWidth * 0.9,
                            child: TextFormField(
                              initialValue: _patient.name,
                              readOnly: true,
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
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: deviceWidth * 0.42,
                              child: TextFormField(
                                initialValue: _patient.age.toString(),
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth, hint: 'Age'),
                              ),
                            ),
                            Container(
                              width: deviceWidth * 0.42,
                              child: TextFormField(
                                initialValue:
                                    _patient.gender == "M" ? "male" : "female",
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth, hint: 'Gender'),
                              ),
                            )
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
                                onChanged: (val) {
                                  _reportObj.familyMember =
                                      val == 'Yes' ? true : false;
                                },
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
                                      hint: 'Physically Active'),
                                  items: ['no', 'low', 'mild', 'high']
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
                                      _reportObj.physicallyActive = val;
                                    });
                                  })),
                        ],
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: deviceWidth * 0.42,
                              child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.weight = int.parse(val);
                                    });
                                  },
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth,
                                      hint: 'Weight',
                                      sufftxt: 'kg')),
                            ),
                            Container(
                                width: deviceWidth * 0.42,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (val) {
                                    setState(() {
                                      _reportObj.height = double.parse(val);
                                    });
                                  },
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth,
                                      hint: 'Height',
                                      sufftxt: 'inch'),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: deviceWidth * 0.42,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  setState(() {
                                    _reportObj.bloodPressure = int.parse(val);
                                  });
                                },
                                decoration: customFieldDecoration(
                                    deviceWidth: deviceWidth,
                                    hint: 'Blood Pressure',
                                    sufftxt: 'mmHg'),
                              ),
                            ),
                            Container(
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
                                      _reportObj.averageSleep = int.parse(val);
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
                                onChanged: (val) {
                                  _reportObj.smoking =
                                      val == 'Yes' ? true : false;
                                },
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
                                onChanged: (val) {
                                  _reportObj.alcohol =
                                      val == 'Yes' ? true : false;
                                },
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
                                onChanged: (val) {
                                  _reportObj.soundSleep =
                                      val == 'Yes' ? true : false;
                                },
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
                                onChanged: (val) {
                                  _reportObj.medicineRegularly =
                                      val == 'Yes' ? true : false;
                                },
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
                                  items: ['no', 'low', 'mild', 'high']
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
                              width: deviceWidth * 0.42,
                              child: DropdownButtonFormField(
                                  elevation: 0,
                                  decoration: customFieldDecoration(
                                      deviceWidth: deviceWidth, hint: 'Stress'),
                                  items: ['no', 'low', 'mild', 'high']
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
                                      _reportObj.stress = val;
                                    });
                                  }),
                            ),
                            Container(
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
                      _patient.gender == 'F'
                          ? Container(
                              width: deviceWidth * 0.9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // height: deviceHeight * 0.12,
                                    width: deviceWidth * 0.42,
                                    child: TextFormField(
                                        decoration: customFieldDecoration(
                                            deviceWidth: deviceWidth,
                                            hint: 'pregnancies count'),
                                        onChanged: (val) {
                                          setState(() {
                                            _reportObj.pregnancies =
                                                int.parse(val);
                                          });
                                        }),
                                  ),
                                  Container(
                                    width: deviceWidth * 0.42,
                                    child: DropdownButtonFormField(
                                        elevation: 0,
                                        decoration: customFieldDecoration(
                                            deviceWidth: deviceWidth,
                                            hint: 'Gestational'),
                                        items: ['Yes', 'No']
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
                                            _reportObj.gestational =
                                                val == 'Yes' ? true : false;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(width: 1),
                      SizedBox(
                        height: deviceHeight * 0.02,
                      ),
                      Container(
                        width: deviceWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () => postGenerate(_patient),
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                minimumSize: Size(
                                    deviceWidth * 0.25, deviceHeight * 0.07),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                backgroundColor: const Color(0xff05483F),
                              ),
                              child: Text('Generate',
                                  style:
                                      TextStyle(fontSize: deviceWidth * 0.05)),
                            )
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
