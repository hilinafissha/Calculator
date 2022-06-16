import 'package:calculator/screens/calculator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obserText=true;

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x665ac18e),
                  Color(0x995ac18e),
                  Color(0xcc5ac18e),
                  Color(0xff5ac18e),
                ]
              ),
            ),
            child: ListView(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Login",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextFormField(
                      //  controller: emailController,
//                        onChanged: (value){
////                          setState(() {
////                            email = value;
////                            print(email);
////                          });
//                        },
                        validator: (value){
                          if (value == ""){
                            return "Please Fill Email";
                          } else if (!regExp.hasMatch(value!)) {
                            return "Email Is Invalid";
                          }
                          return "";
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.alternate_email),
                          hintStyle: TextStyle(color:Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                      TextFormField(
                        //controller: passwordController,
                        obscureText: obserText,
//                        onChanged: (value){
////                          setState(() {
////                            password = value;
////                            print(password);
////                          });
//                        },
                        validator: (value){
                          if (value == ""){
                            return "Please Fill Password";
                          } else if (value!.length <8) {
                            return "Password Is Too Short";
                          }
                          return "";
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: GestureDetector(
                            onTap: () {

                              setState(() {
                                obserText=!obserText;
                              });
                              FocusScope.of(context).unfocus();
                            },
                            child: Icon(
                              obserText==true?Icons.visibility:Icons.visibility_off,color:Colors.black,),
                          ),
                          hintStyle: TextStyle(color:Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),

                      Container(
                        height: 45,
                        width: double.infinity,
                        child: ElevatedButton(
                            child: Text("Login"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black ,
                              shape: StadiumBorder(),
                            ),
                            onPressed: () {
                              login(
                                emailController.text,
                                passwordController.text
                              );
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
                            }),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
  void login(String email, String password) async{
    if (_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Calculator(),
        ),
        ),


      }).catchError((e)
          {
            Fluttertoast.showToast(msg: e.message);
          }

      )  ;
    }
  }
}
