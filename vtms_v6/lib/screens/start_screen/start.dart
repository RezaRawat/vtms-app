import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/components/customTextField.dart';
import 'package:vtms_v6/services/serverSide/authentication.dart';
import 'package:vtms_v6/services/loader.dart';

class Start extends StatefulWidget {

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final _formKey1 = GlobalKey<FormState>(); // Form validation -> email and password
  final _formKey2 = GlobalKey<FormState>(); // Form validation -> MMD ID
  // User Text Field Listener Variables
  final _userEmail = TextEditingController();
  final _userPass  = TextEditingController();
  final _mmdID     = TextEditingController();
  String _uEmail, _uPassw, _uMMD;
  // Misc
  bool loading = false, load;
  final FutureClasses _futureData = FutureClasses();

  @override
  Widget build(BuildContext context) {
    return loading ? Loader() : CustomContainer(
      child: Form(
        key: _formKey1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Text('Vaccine Transport Management System',
                style: TextStyle(fontSize: 19, letterSpacing: 1, color: lightPurple, fontFamily: 'inconsolata')
                ),
            Text('VTMS',
                style: TextStyle(fontSize: 55, letterSpacing: 12, color: cyan200, fontWeight: FontWeight.normal, fontFamily: 'nasalization')
                ),  
            SizedBox(height: 10),

            StartTxtField(hintText: 'Email',
              obscureText: false,
              icon: Icons.person,
              controller: _userEmail,
              onChanged: (text) { setState(() { _uEmail = text; }); },
              validator: (value) => value.isEmpty || value.contains(' ') ? 'Enter an email' : null,
            ),
            StartTxtField(hintText: 'Password',
              obscureText: true,
              icon: Icons.lock,
              controller: _userPass,
              onChanged: (text) { setState(() { _uPassw = text; }); },
              validator: (value) => value.length < 6 ? 'Password Must Be 6+ Char' : null,
            ),
            ButtonExtra(text: 'LOGIN',
              color: btnGreen1,
              borderColor: fullBlack,
              bHeight: 40,
              bWidth: 120,
              fontSize: 16,
              onPressed: () async {
                if (_formKey1.currentState.validate()) {
                  setState(() => loading = true );
                  dynamic load = await _futureData.login(_uEmail, _uPassw, context, true, '');
                  // load = _futureData.login(_uEmail, _uPassw, context, true, '') as bool;
                  if (load == null){
                    setState(() { loading = false; });
                  }
              }},    
            ),
            SizedBox(height: 10),
            Text('Or Enter The Unique MMD ID ',
              style: TextStyle(fontSize: 16, letterSpacing: 2, color: fullWhite, fontFamily: 'inconsolata')
             ),

            Form(key: _formKey2,
              child: StartTxtField(hintText: 'Unique ID',
                obscureText: false,
                icon: Icons.airport_shuttle,
                controller: _mmdID,
                onChanged: (text) { setState(() { _uMMD = text; }); },
                validator: (value) => value.isEmpty ? 'Enter Unique ID' : null,
              ),
            ),
            ButtonExtra(text: 'SEARCH',
              color: btnBlue1,
              borderColor: fullBlack,
              bHeight: 40,
              bWidth: 120,
              fontSize: 16,
              onPressed: () {
                if (_formKey2.currentState.validate()) {
                  setState(() => loading = true );
                _futureData.search(_uMMD, context);
              }},    
            ),
            SizedBox(height: 15),

            Text('Dont have an account?',
             style: TextStyle(fontSize: 18, letterSpacing: 2, color: fullWhite, fontFamily: 'inconsolata')
             ),
            RichText(text: TextSpan(
                text: 'Register',
                style: TextStyle(fontSize: 22, letterSpacing: 2, color: Colors.pink[600], fontFamily: 'nasalization'),
                  recognizer: TapGestureRecognizer()
                  ..onTap = () { Navigator.pushNamed(context, '/userReg'); }
                )), 
          ],
        ),
      ),
      
    );
  }
}