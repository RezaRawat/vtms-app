import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/components/customTextField.dart';
import 'package:vtms_v6/services/serverSide/authentication.dart';

class RegisterUser extends StatefulWidget {

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _userEmail   = TextEditingController(); final _userPass    = TextEditingController();
  final _userName    = TextEditingController(); final _userSurname = TextEditingController();
  final _contact     = TextEditingController(); 
  // Form Validation
  final _formKey = GlobalKey<FormState>();
  final Function validate = (value) => value.isEmpty ? 'Complete Field' : null;
  final FutureClasses _futureData = FutureClasses();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        title: Text('User Registration', style: customtxtStyle),
      ),

      body: CustomContainer(
        child: Form(key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 25),
                Text('Fill in the following fields', 
                  style: TextStyle(fontSize: 16, color: amber900, letterSpacing: 2)),
                SizedBox(height: 5),

                CustomTextField(hintText: 'Name', validator: validate,
                  controller: _userName,
                ),
                CustomTextField(hintText: 'Surname', validator: validate,
                  controller: _userSurname,
                ),
                CustomTextField(hintText: 'Contact Number', 
                  validator: (value) => value.length < 10 ? 'Enter a 10 Digit Number' : null,
                  controller: _contact,
                ),
                CustomTextField(hintText: 'Email', validator: validate,
                  controller: _userEmail,
                ),
                CustomTextField(hintText: 'Password', 
                  validator: (value) => value.length < 6 ? 'Enter a Password 6+ Characters Long' : null,
                  obscureText: true,
                  controller: _userPass,
                ),

                SizedBox(height: 15),
                FormatButton(text: 'Register', color: btnBlue2,
                  fontSize: 16,
                  buttonWidth: 0.4,
                  onPressed: () { 
                    if (_formKey.currentState.validate()) {
                      _futureData.register(_userEmail, _userPass, _userName, _userSurname, _contact, context);
                    }},
                  ),
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}