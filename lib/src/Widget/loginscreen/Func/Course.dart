import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class CDetails extends StatefulWidget {
  @override
  _CDetailsState createState() {
    return _CDetailsState();
  }
}

class _CDetailsState extends State<CDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time Table'),backgroundColor: Color(0xFF26667d),),
      body: new Container(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color(0xFF003142),
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 20)
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF143642), Color(0xFF26667d)],
              )
          ),
          child: _buildBody(context),
        ),
      ),

    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Course').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.Course_id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(

        decoration: BoxDecoration(
          border: Border.all(color: Colors.pinkAccent),
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.black45,
        ),
        child: ListTile(
          title: Text('\n'+'Course Name : '+record.Course_name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.greenAccent),),
          subtitle: Text('\n'+'Course id : '+record.Course_id+'\n'+'Credits : '+record.Credits+'\n',style: TextStyle(color: Colors.orangeAccent),),
          trailing: Text('\n\n'+'Semester : '+record.Semester,style: TextStyle(color: Colors.deepOrangeAccent),),
        ),
      ),
    );
  }
}

class Record {
  final String Course_name;
  final String Credits;
  final String Course_id;
  final String Semester;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Course_id'] != null),
        assert(map['Course_name'] != null),
        assert(map['Credits'] != null),
        assert(map['Semester'] != null),
        Course_id = map['Course_id'],
        Course_name = map['Course_name'],
        Credits = map['Credits'],
        Semester = map['Semester'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

}