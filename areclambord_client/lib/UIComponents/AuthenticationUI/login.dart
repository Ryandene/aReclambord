import 'package:flutter/material.dart';
import 'signUp.dart';
//steppers
class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);
  // final String title;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //login controllers
  static TextEditingController userNameController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  final _loginScaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final userName = TextFormField(
        controller: userNameController,
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

  final password = TextFormField(
      controller: passwordController,
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

  addMallButton() {
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
          "Login",
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white 
          ),
        ),
        onPressed: (){
          if (_formKey.currentState.validate()) {
            //addMall();
          }               
        }
      ),
    );
  }

  signUpScreenButton() {
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
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
                );               
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _loginScaffoldKey,
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
          padding: EdgeInsets.only(top:30.0, bottom: 20.0, left: 30.0, right: 30.0),
          child: Column(                     
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),                  
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [                  
                  Text("Login to your aReclambord account",
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
                  children: <Widget>[
                    userName,
                    password,                        
                    SizedBox(
                      height: 15.0,
                    ),
                    addMallButton(),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,

                    ),)
                  ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    signUpScreenButton(),
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
