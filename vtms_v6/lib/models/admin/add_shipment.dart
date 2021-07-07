import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/components/customTextField.dart';
import 'package:vtms_v6/services/serverSide/database.dart';

class AddShipment extends StatefulWidget {

  @override
  _AddShipmentState createState() => _AddShipmentState();
}

class _AddShipmentState extends State<AddShipment> {
  Map data = {};
  final _formKey = GlobalKey<FormState>(); // Form validation
  final Function validate = (value) => value.isEmpty ? 'Please Complete Field' : null;
  final ShipmentDetails _uDetails = ShipmentDetails();

  final _supplier     = TextEditingController(); final _customer     = TextEditingController();
  final _vaccine      = TextEditingController(); 
  final _dispatchTime = TextEditingController(); final _arrivalTime  = TextEditingController();
  final _driver       = TextEditingController(); final _comments     = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String userID = data['userUID'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        title: Text('Add New Shipment', style: customtxtStyle),
      ),

      body: CustomContainer(
        child: Form(key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 15),
                Text('Enter in the following details', style: TextStyle(fontSize: 18, color: amber900, fontFamily: 'inconsolata')),
                SizedBox(height: 5),
                CustomTextField(hintText: 'Supplier Name', validator: validate,
                  controller: _supplier,
                  ),
                CustomTextField(hintText: 'Customer Name', validator: validate,
                  controller: _customer,
                  ),
                CustomTextField(hintText: 'Vaccine Count', validator: validate,
                  controller: _vaccine,
                  ),
                CustomTextField(hintText: 'Driver Name', validator: validate,
                  controller: _driver,
                  ),
                CustomTextField(hintText: 'Dispatch Time (optional)',
                  controller: _dispatchTime,
                  ),   
                CustomTextField(hintText: 'Arrival Time (optional)',
                  controller: _arrivalTime,
                  ),   
                  Text('Seperate Comments by a Comma', style: TextStyle(color: fullWhite, fontSize: 16, fontFamily: 'inconsolata')),
                CustomTextFieldTwo(hintText: 'Description/Comments (optional)',
                  controller: _comments,
                  ),
                FormatButton( text: 'ADD',
                  color: btnBlue1,
                  fontSize: 14,
                  buttonWidth: 0.25,
                  onPressed: () { 
                    if (_formKey.currentState.validate()) {
                     _uDetails.newShipment(userID, _supplier, _customer, _vaccine, _driver, _dispatchTime, _arrivalTime, _comments, context);  
                    } },
                )
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}