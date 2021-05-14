import 'package:client/resources/api_provider.dart';
import 'package:client/resources/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPaitentScreen extends StatefulWidget {
  AddPaitentScreen({Key key}) : super(key: key);

  @override
  _AddPaitentScreenState createState() => _AddPaitentScreenState();
}

class _AddPaitentScreenState extends State<AddPaitentScreen> {
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
    Wsb(val) => SizedBox(width: deviceWidth * val);
    Hsb(val) => SizedBox(height: deviceHeight * val);

    return template(
        body: Form(
      key: _form,
      child: Row(
        children: [
          SizedBox(width: deviceWidth * 0.05),
          Column(
            children: [
              SizedBox(height: deviceHeight * 0.06),
              Column(
                children: [
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.9,
                    child: Text('Add Patient Form',
                        style: GoogleFonts.poppins(
                            fontSize: deviceWidth * 0.07, letterSpacing: 1)),
                  ),
                  SizedBox(height: deviceHeight * 0.01),
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.9,
                    child: Text(
                      'Enter the patient details :-',
                      style: GoogleFonts.poppins(fontSize: deviceWidth * 0.06),
                    ),
                  ),
                  Hsb(0.02),
                  Container(
                      width: deviceWidth * 0.9,
                      child: TextFormField(
                        onSaved: (val) => _name = val,
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required(context)]),
                        decoration: customFieldDecoration(
                            deviceWidth: deviceWidth, hint: 'Name'),
                      )),
                  Hsb(0.02),
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
                          decoration: customFieldDecoration(
                              deviceWidth: deviceWidth, hint: 'Age'),
                        ),
                      ),
                      Wsb(0.05),
                      Container(
                        height: deviceHeight * 0.07,
                        width: deviceWidth * 0.42,
                        child: DropdownButtonFormField(
                            validator: FormBuilderValidators.compose(
                                [FormBuilderValidators.required(context)]),
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
                                _gender = val == 'male' ? 'M' : 'F';
                              });
                            }),
                      ),
                    ],
                  ),
                  Hsb(0.02),
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
                      decoration: customFieldDecoration(
                          deviceWidth: deviceWidth, hint: 'Contact Number'),
                    ),
                  ),
                  Hsb(0.02),
                  TextButton(
                    onPressed: _submit,
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize:
                          Size(deviceWidth * 0.25, deviceHeight * 0.07),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      backgroundColor: const Color(0xff05483F),
                    ),
                    child: Text('Add Patient',
                        style: TextStyle(fontSize: deviceWidth * 0.05)),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
