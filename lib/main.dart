import 'dart:async';

import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:new_task_zolatte/Screens/YourDetails.dart';
import 'Screens/HomeScreen.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      routes: {
        '/': (context)=>MyHomePage(),
        '/home': (context)=>YourDetails(),
        "/add" :(context)=>AddDetails()
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StreamSubscription? x;
  Future<void> initializeFireBase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    x=FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {

        Navigator.pushReplacementNamed(context, "/home");

      }
    });
}

@override
  void dispose() {
    // TODO: implement dispose
  x?.cancel();

    super.dispose();
  }


void signInWithGoogle()async{
      final GoogleSignInAccount? acc=await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await acc?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
       FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  void initState() {
    // TODO: implement initState
    initializeFireBase();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(onPressed: (){

          signInWithGoogle();
        }, child: Text("Sign Up With Google"),

        ),
      ),
    );
  }
}

