import 'dart:convert';
import 'package:flutter/material.dart';
import 'exam_message.dart';
import 'package:http/http.dart' as http;

class DMLandingPage extends StatefulWidget {
  @override
  _DMLandingPageState createState() => _DMLandingPageState();
}

class _DMLandingPageState extends State<DMLandingPage> {
  @override
  Widget build(BuildContext context) {
    final ExamMessage args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(" Decision Making Section"),
        backgroundColor: Color(0xff2B3F9F),
      ),
      body:
      new Container(
        color: Color(0xffD1CCCC),
        child: new Center(
          child: getListOfDecisionMaking(),
        ),
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<List<Caselet>> fetchDMCaselets() async {
    final response =await http.get('http://www.xatprep.com/api/get_dm_qns.php?tid=1');
    //final response = await http.get('https://jsonplaceholder.typicode.com/posts');
    print(response.body);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print(response.body);
      Iterable list = json.decode(response.body);
      var caselets = new List<Caselet>();
      caselets = list.map((model) => Caselet.fromJson(model)).toList();

      return caselets;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void onCardTapped(int index) {
    setState(() {
//      selectedIndex = index;
    });
  }

  getListOfDecisionMaking(){
        return ListView(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
              color: Colors.white,
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.only(left:20.0, top:10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(child: Text("Decision Making Section", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto'),),),

                      ],
                    ),
                    Container(
                      height: 500.0,
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                        margin: EdgeInsets.only(top: 5.0),
                        child: FutureBuilder<List<Caselet>>(
                          future: fetchDMCaselets(),
                          builder: (context,snapshot){
                            if(snapshot.hasData){
                              return new ListView.builder(
                                itemCount:snapshot.data.length,
                                itemBuilder: (BuildContext context, int index){
                                  return GestureDetector(
                                    onTap: (){
                                      print("welcome to Decision Making section1");
                                      onCardTapped(1);
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Image.asset('assets/images/decision_making.png'),
                                      ),
                                      title: Text(snapshot.data[index].name, style: TextStyle(color: Colors.black, )),
                                      subtitle: Text("Attempt Now", style: TextStyle(color: Colors.blue, )),
                                      trailing: Icon(Icons.keyboard_arrow_right),
                                      onTap: () {
//                                        print('horse');
//                                        Navigator.pushNamed(context, '/second');
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context)=>DMLandingPage(),
                                                settings: RouteSettings(
                                                  arguments: ExamMessage(snapshot.data[index].grp_count.toString(), snapshot.data[index].name),
                                                )));
                                      },
                                      selected: true,
                                    ),
                                  );
                                },
                              );
                            }else{
                              return
                                Center(
                                  child: CircularProgressIndicator(),
                                );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        );

  }

}

class Caselet {
  final int tid;
  final int gid;
  final String name;
  final int grp_count;

  Caselet({this.tid, this.gid,this.name,this.grp_count});

  factory Caselet.fromJson(Map<String, dynamic> json) {
    return Caselet(
      tid: json['tid'],
      gid: json['gid'],
      name: json['name'],
      grp_count: json['grp_count'],
    );
  }
}