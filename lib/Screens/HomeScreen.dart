import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_task_zolatte/controllers/firebaseDb.dart';
import 'package:new_task_zolatte/widgets/myInputForm.dart';

class AddDetails extends StatefulWidget {

  AddDetails();

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  late TextEditingController mobile,address,freetext;
  // late FirebaseDB db;
  int age=18;
  String btnText="Add";
  late FirebaseDB db;

  void InitializeTextFromDB()async{
    Map? m=await db.getData();
    if(m!=null){
      mobile.text=m["mobile"].toString();
      address.text=m["address"].toString();
      freetext.text=m["freetext"].toString();
      age=int.parse(m["age"].toString());
      btnText="Update";
      setState(() {

      });
    }
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      db=ModalRoute.of(context)?.settings.arguments as FirebaseDB;

      InitializeTextFromDB();
    });
    // TODO: implement initState
    mobile = TextEditingController();
    address = TextEditingController();
    freetext = TextEditingController();

    super.initState();
  }
  @override
  void dispose() {
    mobile.dispose();
    address.dispose();
    freetext.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  final formGlobalKey = GlobalKey < FormState > ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen"),

      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formGlobalKey,
            child: Column(
              children: [
                Text("Enter Details",style: TextStyle(fontSize: 30),),

                MyFormText(onChanged: (s){}, hint: "Mobile", icon: Icon(Icons.phone),validator: (mobile){
                  if((mobile?.length??0)==10){
                    return null;
                  }
                  return "Enter a Valid Mobile Number";
                },type: TextInputType.phone,controller: mobile,),
                MyFormText(onChanged: (s){}, hint: "Address", icon: Icon(Icons.place),maxLines: 3,validator: (add){
                  if(add==null || add.isEmpty || add.length<10){
                    return "Enter Valid Address";

                  }
                  return null;
                },controller: address,),
                Row(
                  children: [
                    Container(
                      width: 125,
                      margin: EdgeInsets.all(10),
                      child: DropdownButtonFormField<int>(

                          decoration: InputDecoration(
                              hintText: "Age",
                              prefixIcon: Icon(Icons.numbers),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              )
                          ),
                          value: age,

                          items: [for (int i=18;i<120;i++) i].map((e) {
                            return DropdownMenuItem<int>(child: Text("$e",style: TextStyle(color: Colors.black),),value: e,);
                          }).toList(), onChanged: (int? s){
                            age=s??0;
                      }),
                    ),
                  ],
                ),
                MyFormText(onChanged: (x){}, hint: "Enter Text", icon: Icon(Icons.text_fields),maxLines: 4,controller:freetext,),
                ElevatedButton(onPressed: (){
                  if(formGlobalKey.currentState!.validate()){
                    formGlobalKey.currentState!.save();
                    Map m={
                      "address":address.value.text,
                      "mobile":mobile.value.text,
                      "freetext":freetext.value.text,
                      "age":"$age",
                    };
                    db.AddData(m);
                    Navigator.pop(context);

                    print("Done0");
                    print(address.value);
                    print(mobile.value);
                    print(freetext.value);
                    print(age);
                  }
                }, child: Text(btnText))

              ],
            ),
          ),
        ),
      ),
    );
  }
}
