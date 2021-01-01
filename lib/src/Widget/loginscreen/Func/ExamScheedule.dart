import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class ESchedule extends StatefulWidget {
  @override
  _EScheduleState createState() {
    return _EScheduleState();
  }
}

class _EScheduleState extends State<ESchedule> {
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
      stream: FirebaseFirestore.instance.collection('Exam').snapshots(),
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
      key: ValueKey(record.Exam_id),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(

        decoration: BoxDecoration(
          border: Border.all(color: Colors.tealAccent),
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.black45,
        ),
        child: ListTile(
          title: Text('\n'+'Exam id : '+record.Exam_id,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.greenAccent),),
          subtitle: Text('\n'+'Course id : '+record.Course_id+'\n'+'Date : '+record.Date+'\n'+'Time : '+record.time+'\n'+'Duration : '+record.duration+'\n',style: TextStyle(color: Colors.orangeAccent),),
          trailing: Text('\n\n'+'Room No : '+record.Room_no,style: TextStyle(color: Colors.deepOrangeAccent),),
        ),
      ),
    );
  }
}

class Record {
  final String Exam_id;
  final String Room_no;
  final String Course_id;
  final String Date;
  final String time;
  final String duration;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['Exam_id'] != null),
        assert(map['Room_no'] != null),
        assert(map['Course_id'] != null),
        assert(map['Date'] != null),
        assert(map['time'] != null),
        assert(map['duration'] != null),
        Exam_id = map['Exam_id'],
        Room_no = map['Room_no'],
        Course_id = map['Course_id'],
        Date = map['Date'],
        time = map['time'],
        duration = map['duration'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

}