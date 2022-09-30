import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_task_zolatte/controllers/firebaseDb.dart';

class YourDetails extends StatefulWidget {
  const YourDetails({Key? key}) : super(key: key);

  @override
  State<YourDetails> createState() => _YourDetailsState();
}

class _YourDetailsState extends State<YourDetails> {
  late FirebaseDB db;
  String baseImg="https://visualpharm.com/assets/387/Person-595b40b75ba036ed117da139.svg";
  late User user;
  Map? data={};

  @override
  void initState() {
    user=FirebaseAuth.instance.currentUser!;
    db = FirebaseDB(user.uid);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      db.data.listen((event) {

        data=event.snapshot.value as Map?;
      if(mounted){

        setState(() {}
        );
      }


      });

    });


    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    List items=[
      "Name : ${user.displayName}",
      "Email : ${user.email}",
      "Mobile : ${user.phoneNumber}",
      "Entered Mobile : ${data?["mobile"]}",
      "Entered Address : ${data?["address"]}",
      "Entered Age : ${data?["age"]}",
      "Entered Text : ${data?["freetext"]}"

    ];
    return Scaffold(
        appBar: AppBar(title: Text("Welcome",),
          leading: Container(
            margin: EdgeInsets.all(5),
            child: ClipOval(
              
              child: Image(image: NetworkImage(user.photoURL??baseImg),),
            ),
          ),
          actions: [
            IconButton(onPressed: ()async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/");
            }, icon: Icon(Icons.logout)),
            IconButton(onPressed: ()async{
              db.deleteData();
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, "/");
            }, icon: Icon(Icons.delete))
          ],
        ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, "/add",arguments: db);
      },
      child: Icon(Icons.add),),
      body: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.all(10),
              child: Text("Details",style: TextStyle(fontSize: 30,),textAlign: TextAlign.center,),
            )
            
          ]+ items.map((e){
            return Container(
              margin: EdgeInsets.all(5),
                child: Text(e,style: TextStyle(fontSize: 18),)
            );
          }).toList(),
        ),
      ),
    );
  }
}
