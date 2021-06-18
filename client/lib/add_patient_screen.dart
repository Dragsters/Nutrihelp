import 'package:client/resources/api_provider.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key key}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _form = GlobalKey<FormState>();
  String _name;
  String _gender;
  int _age;
  String _mobile;

  void _submit() {
    FocusManager.instance.primaryFocus.unfocus();
    if (_form.currentState.validate()) {
      _form.currentState.save();
      postPatient(context, _name, _gender, _age, _mobile);
      _form.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    SizedBox wsb(val) => SizedBox(width: deviceWidth * val);
    SizedBox hsb(val) => SizedBox(height: deviceHeight * val);

    return Scaffold(
      appBar: new AppBar(
        title: Text("Add Patient"),
        backgroundColor: const Color(0xFF01579B),
      ),
        body: Container(
          decoration: const BoxDecoration(
              //image:  DecorationImage(image: AssetImage("client/assets/images/nutrition.png"), fit: BoxFit.cover)),
              gradient: LinearGradient(
                   begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF4FC3F7), Color(0xFFE1F5FE)])),
          child: SingleChildScrollView(
            child: Form(
      key: _form,
      child: Row(
            children: [
              SizedBox(width: deviceWidth * 0.05),
              Column(
                children: [
                  SizedBox(height: deviceHeight * 0.20),
                  Column(
                    children: [
                      //Container(
                        //height: deviceHeight * 0.05,
                        //width: deviceWidth * 0.9,
                        //child: Text('Add Patient Form',
                            //style: GoogleFonts.poppins(
                                //fontSize: deviceWidth * 0.07, letterSpacing: 1)),
                     // ),
                      //SizedBox(height: deviceHeight * 0.01),
                      Container(
                        height: deviceHeight * 0.05,
                        width: deviceWidth * 0.9,
                        child: Text(
                          'ENTER THE PATIENT DETAILS:',
                          style: GoogleFonts.poppins(fontSize: deviceWidth * 0.06, fontWeight: FontWeight.bold),
                        ),
                      ),
                      hsb(0.02),
                      Container(
                          width: deviceWidth * 0.9,
                          child: TextFormField(
                            onSaved: (val) => _name = val,
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required(context)]),
                            decoration: InputDecoration(
                               // deviceWidth: deviceWidth,
                                labelText: 'NAME',),
                          )),
                      hsb(0.02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: deviceWidth * 0.42,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.max(context, 99)
                              ]),
                              onSaved: (val) => _age = int.parse(val),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2)
                              ],
                              decoration: InputDecoration(
                                  //deviceWidth: deviceWidth,
                                  labelText: 'AGE',),
                            ),
                          ),
                          wsb(0.05),
                          Container(
                            width: deviceWidth * 0.42,
                            child: DropdownButtonFormField(
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                elevation: 2,
                                decoration: InputDecoration(
                                    //deviceWidth: deviceWidth,
                                    labelText : 'GENDER'),
                                items: ['Male', 'Female']
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
                                    _gender = val == 'male' ? 'M' : 'F';
                                  });
                                }),
                          ),
                        ],
                      ),
                      hsb(0.02),
                      Container(
                        width: deviceWidth * 0.9,
                        child: TextFormField(
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.minLength(context, 10)
                          ]),
                          onSaved: (val) => _mobile = val.toString(),
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              //deviceWidth: deviceWidth,
                            labelText: 'CONTACT NUMBER'),
                        ),
                      ),
                      hsb(0.09),
                      TextButton(
                        onPressed: _submit,
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          minimumSize:
                              Size(deviceWidth * 0.29, deviceHeight * 0.07),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          backgroundColor: const Color(0xFF01579B),
                        ),
                        child: Text('Add Patient',
                            style: TextStyle(fontSize: deviceWidth * 0.06)),
                      ),
                      hsb(2),
                    ],
                  ),
                ],
              ),
            ],
      ),
    ),
          ),
        ));
  }
}
