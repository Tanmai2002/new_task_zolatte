
import 'package:firebase_database/firebase_database.dart';

class FirebaseDB{
  static FirebaseDatabase db=FirebaseDatabase.instance;
  late DatabaseReference reference;
  late String uid;
  late Stream data;
  FirebaseDB(this.uid){
    reference=db.ref(uid);
    data=reference.onValue;

  }
  Future<Map?> getData()async{
    DataSnapshot s=await reference.get();
    return s.value as Map?;
  }

  Future AddData(Map m)async{
    await reference.set(m);
  }
  Future deleteData()async{
    await reference.remove();
  }
}