import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../../Models/aReclambordUser.dart';
import 'package:http/http.dart' as http;
import '../../Commons/constants.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);
  // final String title;
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  //reg controllers
  static TextEditingController regFirstNameController = TextEditingController();
  static TextEditingController regLastNameController = TextEditingController();
  static TextEditingController regUserNameController = TextEditingController();
  static TextEditingController regPasswordController = TextEditingController();
  static TextEditingController confirmPasswordController = TextEditingController();

  String selectedAccountType;
  List<String> aReclambordAccountType = <String>[
    'Billboard Customer',
    'Billboard Vendor'
  ];
  final _signUpScaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  Future<HttpResponse> _registerUser;
  
  createUser() async {
    AReclamborUser newUser = AReclamborUser(email: regUserName.controller.text, password: regPassword.controller.text);
    var url = Uri.parse(aReclamboardApiUrl + 'api/user/signup/');  
    var body = jsonEncode(newUser.toMap());
    print(body);  
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "X-CSRFToken": x_csrfToken
      },
      body: jsonEncode(newUser.toMap())
    );

    if (response.statusCode == 201) {
      _signUpScaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Woow!!Created"),
        backgroundColor: Colors.teal[900]
        ));
    }
  }

  signUpButton() {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        minWidth: double.infinity,
        height: 60,  
        elevation: 5,      
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70.0)
        ),
        color: Colors.orange[400],
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white 
          ),
        ),
        onPressed: (){
          if (_formKey.currentState.validate()) {
            //addMall();
            createUser();
          }               
        }
      ),
    );
  }

  //reg variables  
    final regFirstName = TextFormField(
      controller: regFirstNameController,
      decoration: InputDecoration(
        labelText: "First Name", hintText: "Enter first name"
      ),
      // validator: (value){
      //   if (value.isEmpty){
      //     return 'First name cannot be empty';
      //   }
      //   return null;          
      // },
    );

    final regLastName = TextFormField(
      controller: regLastNameController,
      decoration: InputDecoration(
        labelText: "Last Name", hintText: "Enter last name"
      ),
      // validator: (value){
      //   if (value.isEmpty){
      //     return 'Last name cannot be empty';
      //   }
      //   return null;          
      // },
    );

    final regUserName = TextFormField(
        controller: regUserNameController,
        decoration: InputDecoration(
          labelText: "Email", hintText: "example@gmail.com"
        ),
        validator: (value){
          if (value.isEmpty){
            return 'Username cannot be empty!';
          }
          return null;
        },
      );

  final regPassword = TextFormField(
      controller: regPasswordController,
      decoration: InputDecoration(
        labelText: "Password", hintText: "Enter password"
      ),
      validator: (value){
        if (value.isEmpty){
          return 'Password cannot be empty!';
        }
        return null;          
      },
    );

  final regConfirmPassword = TextFormField(
      controller: confirmPasswordController,
      decoration: InputDecoration(
        labelText: "Confirm Password", hintText: "Enter confirm password"
      ),
      validator: (value){
        if (value != regPasswordController.text){
            return 'Passwords does not match';
          }
        return null;          
      },
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _signUpScaffoldKey,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,        
        backgroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[ 
          Padding(
            padding: EdgeInsets.only(top:30.0, bottom: 30.0, left: 80.0, right: 80.0),
            child: Card(
              elevation: 10.0,
              child: SingleChildScrollView( 
              //elevation: 10.0,
          child: Padding(                
            //padding: EdgeInsets.all(5.0),
          padding: EdgeInsets.only(top:20.0, bottom: 20.0, left: 30.0, right: 30.0),
          child: Column(                     
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),                  
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [                  
                  Text("Create your new aReclambord account",
                  style: TextStyle(
                    fontSize: 15,
                  color:Colors.grey[700]),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150.0,
                    width: 200.0,
                    child: Image.asset(
                    "assets/addMall.png",
                    height: 100.0,
                    width: 200.0,
                  ),)
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top:5.0, bottom: 5.0, left: 60.0, right: 60.0),
                child: Form(
                key: _formKey,
                child: Column(                  
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,                  
                  children: <Widget>[                    
                    regFirstName,
                    regLastName,
                    regUserName,
                    regPassword,
                    regConfirmPassword,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        DropdownButton(
                          value: selectedAccountType,
                          isExpanded: false,
                          hint: Text(
                            'Select an account type'
                          ),
                          items: aReclambordAccountType.map((e) => DropdownMenuItem(
                            child: Text(
                              e,
                            ),
                            value: e,
                          )).toList(),
                          onChanged: (selectedValue){
                            
                            setState(() {
                              selectedAccountType = selectedValue;
                              //print('sadafa');
                              print('$selectedAccountType');
                            });
                          },
                        )
                      ],
                    ),                       
                    SizedBox(
                      height: 15.0,
                    ),
                    signUpButton(),
                  ],
                )
                ),
                ),
              
              ],
        )
          )
          ),),
            
          ),             
          
        ]
        
      ),
    );
  }    
    
}
