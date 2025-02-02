import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackbourak/screens/connexion.dart';

import '../Shared/SharedFunctions.dart';
// import 'package:file_picker/file_picker.dart';

class OrganisationInscPage extends StatefulWidget {
  OrganisationInscPage({Key? key}) : super(key: key);

  @override
  State<OrganisationInscPage> createState() => _OrganisationInscPageState();
}

class _OrganisationInscPageState extends State<OrganisationInscPage> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  bool hidePassword = true;
  bool hidep = true;
  bool checked = false;

  String _email="";
  String _password1="";
  String _password2="";
  String _name="";
  int _number=0;

  Future<void> _signUpMailPassword() async {
      try {

          if (_password1 != _password2){
              SharedFunctions.showingToast("Mots de passe non pas identiques");
          }else{
              if (_name==""){
                  SharedFunctions.showingToast("Veuillez entrer votre nom");
              }else{

                          if (_number == 0){
                              SharedFunctions.showingToast("Veuillez entrer votre numero de telephone");
                          }else{
                              SharedFunctions.showLoaderDialog(context);

                              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: _email,
                                  password: _password1
                              );

                              FirebaseFirestore.instance.collection("users").doc(userCredential.user?.uid).set({
                                  'password': _password1,
                                  'name' : _name,
                                  'phone' : _number,
                                  'email' : _email,
                                  'isOrg' : true,
                              });

                              Navigator.pop(context);
                              Navigator.pop(context);
                          }
                      }


          }



      } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
              SharedFunctions.showingToast('The password provided is too weak.');
              print(e.code);
          } else if (e.code == 'email-already-in-use') {
              SharedFunctions.showingToast('The account already exists for that email.');
              print(e.code);
          }

          Navigator.pop(context);
      } catch (e) {
          SharedFunctions.showingToast(e.toString());
          print(e);

          Navigator.pop(context);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        backgroundColor: Theme.of(context).primaryColor,
        body: SingleChildScrollView(
            child: Column(
                children: <Widget>[
                    Stack(
                        children: <Widget>[
                            Container(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15,),
                                margin: EdgeInsets.symmetric(vertical: 80, horizontal: 20,),
                                child: Form(
                                    key: globalFormKey,
                                    child: Column(
                                        children: <Widget>[
                                            SizedBox(height: 10),
                                            Container(
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                    onPressed: (){
                                                        Navigator.pop(context);
                                                    },
                                                    icon : Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF757575),),
                                                ),
                                            ),
                                            Text(
                                                "Inscription",
                                                style: Theme.of(context).textTheme.headline2,
                                            ),
                                            SizedBox(
                                                height: 80,
                                            ),
                                            new TextFormField(
                                                keyboardType: TextInputType.text,
                                                // validator: (input) => input.isEmpty || !input.contains("@")
                                                //     ? "enter a valid eamil"
                                                //     : null,
                                                decoration: new InputDecoration(
                                                    hintText: "Nom de l'organisation",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20,),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(0xFF757575),
                                                        ),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black,),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                ),
                                                onChanged: (v){
                                                    _name = v;
                                                },
                                            ),
                                            SizedBox(height: 10,),
                                            new TextFormField(
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: new InputDecoration(
                                                    hintText: "Adresse Email",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20,),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(0xFF757575),
                                                        ),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black,),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                ),
                                                onChanged: (v){
                                                    _email = v;
                                                },
                                            ),
                                            SizedBox(height: 10,),
                                            new TextFormField(
                                                keyboardType: TextInputType.number,
                                                decoration: new InputDecoration(
                                                    hintText: "N° de téléphone",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20,),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(0xFF757575),
                                                        ),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black,),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                ),
                                                onChanged: (v){
                                                    _number = int.parse(v);
                                                },
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color(0xFF757575),
                                                    ),
                                                    borderRadius: BorderRadius.all(Radius.circular(50),),
                                                ),
                                                child: FloatingActionButton.extended(
                                                    label: Text(
                                                        'Upload agrement',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.w500,
                                                            color: Color(0xFF757575),
                                                            letterSpacing: 0.0
                                                        )
                                                    ),
                                                    icon : Icon(
                                                        Icons.attach_file_rounded,
                                                        color: Color(0xFF757575),
                                                    ),
                                                    onPressed: () async {
                                                        // final result = await FilePicker.platform.pickFiles();
                                                    },
                                                    backgroundColor: Colors.white,
                                                ),
                                            ),
                                            SizedBox(height: 10,),
                                            new TextFormField(
                                                keyboardType: TextInputType.text,
                                                // validator: (input?) => input.length < 8
                                                //     ? "Password must contains at least 8 characters"
                                                //     : null,
                                                obscureText: hidePassword,
                                                decoration: new InputDecoration(
                                                    hintText: "Mot de passe",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20,),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(0xFF757575),
                                                        ),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black,),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                            setState((){
                                                                hidePassword = !hidePassword;
                                                            });
                                                        },
                                                        color: Colors.black.withOpacity(0.4),
                                                        icon: Icon(
                                                            hidePassword?
                                                            Icons.visibility_off: Icons.visibility
                                                        ),
                                                    ),
                                                ),
                                                onChanged: (v){
                                                    _password1 = v;
                                                },
                                            ),
                                            SizedBox(height: 10,),
                                            new TextFormField(
                                                keyboardType: TextInputType.text,
                                                // validator: (input?) => input.length < 8
                                                //     ? "Password must contains at least 8 characters"
                                                //     : null,
                                                obscureText: hidep,
                                                decoration: new InputDecoration(
                                                    hintText: "Confirmer Mot de passe",
                                                    hintStyle: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w500,
                                                    ),
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20,),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(0xFF757575),
                                                        ),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.black,),
                                                        borderRadius: BorderRadius.circular(23.5)
                                                    ),
                                                    suffixIcon: IconButton(
                                                        onPressed: () {
                                                            setState((){
                                                                hidep = !hidep;
                                                            });
                                                        },
                                                        color: Colors.black.withOpacity(0.4),
                                                        icon: Icon(
                                                            hidep?
                                                            Icons.visibility_off: Icons.visibility
                                                        ),
                                                    ),
                                                ),
                                                onChanged: (v){
                                                    _password2 = v;
                                                },
                                            ),
                                            SizedBox(height: 10,),
                                            Container(
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                        Checkbox(
                                                            value: checked,
                                                            onChanged: (value) {
                                                                setState((){
                                                                checked = value ?? false;
                                                                });
                                                            },
                                                        ),
                                                        Container(
                                                            child: Text(
                                                                "J’accepte les conditions générales d’utilisation",
                                                                style: TextStyle(
                                                                    fontFamily: 'Poppins',
                                                                    color: Color(0xFF343434),
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight.w500,
                                                                )
                                                            ),
                                                        ),
                                                    ],
                                                ),
                                            ),
                                            SizedBox(height: 20,),
                                            FlatButton(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 20,
                                                ),
                                                onPressed: checked ? () {
                                                    _signUpMailPassword();
                                                } : null,
                                                child: Text(
                                                    "Inscription",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: checked ? Colors.white : Color(0xFF343434),
                                                        fontFamily: 'Poppins',
                                                        fontWeight: FontWeight.w700,
                                                    ),
                                                ),
                                                color: !checked ? Color(0xFF757575) : Color(0xFFE32929),
                                                shape: StadiumBorder(),
                                            ),
                                            SizedBox(height: 20,),
                                            TextButton(
                                                onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => ConnexionPage()
                                                        ),
                                                    );
                                                },
                                                child: Text(
                                                    "Vous avez déjà un compte?\n Connectez-vous!",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Theme.of(context).accentColor,
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ],
            ),
        ),
    );
  }
}