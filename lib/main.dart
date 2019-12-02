import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Welcome to XATprep'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xff2B3F9F),
      ),
      body: new Container(
        color: Color(0xffD1CCCC),
        child: new Center(
          child: getListOfDecisionMaking(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(backgroundColor: Color(0xff2B3F9F),icon: Icon(Icons.dashboard), title: Text('Dashboard')),
          BottomNavigationBarItem(backgroundColor:Color(0xff2B3F9F), icon: Icon(Icons.lightbulb_outline), title: Text('Decision Making')),
          BottomNavigationBarItem(backgroundColor:Color(0xff2B3F9F),icon: Icon(Icons.account_balance), title: Text('GK')),
          BottomNavigationBarItem(backgroundColor:Color(0xff2B3F9F),icon: Icon(Icons.forum), title: Text('Forum')),

        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.white,
        backgroundColor: Colors.orange,
        type: BottomNavigationBarType.shifting,
        onTap: onItemTapped,
      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTests();
  }

  getListOfDecisionMaking(){
    switch(selectedIndex){
      case 0:{
        return ListView(
          children: <Widget>[
            Container(
              height: 180.0,
              margin: EdgeInsets.only(left:0.0, bottom: 5.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            child: Image.asset('assets/images/about.png'),
                          ),
                          Container(child: Text("About", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto'),),),

                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Center(
                            child:Container(
                              padding: const EdgeInsets.only(left:10.0, top:10.0),
                              height: 70.0,
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Text("Focus your preparation for Decision Making and GK sections for XAT 2020 with XATprep", style: TextStyle(fontSize: 16.0, height: 1.6, fontFamily: 'Roboto', color: Colors.black),),
                            ),
                          ),

                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 225.0,
              margin: EdgeInsets.only(left:0.0, bottom: 5.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0, top:10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            child: Image.asset('assets/images/decision_making.png'),
                          ),
                          Container(child: Text("Decision Making", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto'),),),

                        ],
                      ),
                      Container(
                        height: 125.0,
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                          margin: EdgeInsets.only(top: 5.0),
                          child: FutureBuilder<List<Test>>(
                            future: fetchTests(),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                return new ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return GestureDetector(
                                      onTap: (){
                                          print("welcome to Decision Making section");
                                          onCardTapped(1);
                                        },
                                      child: new Container(
//                                      width: MediaQuery.of(context).size.width * 0.6,
                                        width: 125.0,
                                        height: 125.0,
                                        margin: EdgeInsets.all(5.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: new Border.all(
                                                width: 1.0,
                                                style: BorderStyle.solid,
                                                color: Color(0xffececec),
                                            ),
                                            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),

//                                            gradient: new LinearGradient(
//                                                colors: [Colors.lightBlueAccent, Colors.blue],
////                                              begin: Alignment.centerRight,
////                                              end: new Alignment(-1.0, -1.0)
//                                                ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    image: DecorationImage(
                                                      image: new AssetImage(
                                                          'assets/images/dm_1.png'),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ),
                                              ),

                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                margin: EdgeInsets.only(left: 10.0,top: 5.0),
                                                child: Text(snapshot.data[index].name, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                                              ),
                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                margin: EdgeInsets.only(left: 10.0,top: 5.0, bottom: 5.0),
                                                child: Text("26 questions", style: TextStyle(color: Colors.blue),),
                                              ),
                                              Row()
                                            ],
                                          ),
                                        ),
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
            ),
            Container(
              height: 225.0,
              margin: EdgeInsets.only(left:0.0, bottom: 5.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0, top:10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            child: Image.asset('assets/images/gk.png'),
                          ),
                          Container(child: Text("General Knowledge", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto'),),),

                        ],
                      ),
                      Container(
                        height: 125.0,
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                          margin: EdgeInsets.only(top: 5.0),
                          child: FutureBuilder<List<Test>>(
                            future: fetchTests(),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                return new ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return new Container(
//                                      width: MediaQuery.of(context).size.width * 0.6,
                                      width: 150.0,
                                      margin: EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          print("welcome to GK section");
                                          onCardTapped(2);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            border: new Border.all(
                                              width: 2.0,
                                              style: BorderStyle.solid,
                                              color: Colors.white,
                                            ),
                                            borderRadius: new BorderRadius.all(new Radius.circular(5.0)),

                                            gradient: new LinearGradient(
                                              colors: [Colors.orangeAccent, Colors.orange],
//                                              begin: Alignment.centerRight,
//                                              end: new Alignment(-1.0, -1.0)
                                            ),
                                          ),
                                          child: Center(child: Text(snapshot.data[index].name, style: TextStyle(fontSize: 18.0, color: Colors.white),)),
                                        ),
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
            ),
            Container(
              height: 225.0,
              margin: EdgeInsets.only(left:0.0, bottom: 5.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                color: Colors.white,
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.only(left:20.0, top:10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            child: Image.asset('assets/images/forum.png'),
                          ),
                          Container(child: Text("Forum", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto'),),),

                        ],
                      ),
                      Container(
                        height: 125.0,
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                          margin: EdgeInsets.only(top: 5.0),
                          child: FutureBuilder<List<Test>>(
                            future: fetchTests(),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                return new ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index){
                                    return new Container(
//                                      width: MediaQuery.of(context).size.width * 0.6,
                                      width: 150.0,
                                      margin: EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: (){
                                          print("welcome to Forum section");
                                          onCardTapped(3);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                          color: Colors.blue,
                                          border: new Border.all(
                                            width: 2.0,
                                            style: BorderStyle.solid,
                                            color: Colors.white,
                                          ),
                                          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),

                                          gradient: new LinearGradient(
                                            colors: [Colors.grey, Colors.blueGrey],
//                                              begin: Alignment.centerRight,
//                                              end: new Alignment(-1.0, -1.0)
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(snapshot.data[index].name, style: TextStyle(fontSize: 18.0, color: Colors.black),)
                                        ),
                                      ),
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
            ),

          ],
        );
      }
      case 1:{
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
                        Container(
                          height: 50.0,
                          child: Image.asset('assets/images/decision_making.png'),
                        ),
                        Container(child: Text("Decision Making", style: TextStyle(fontSize: 22.0, fontFamily: 'Roboto'),),),

                      ],
                    ),
                    Container(
                      height: 500.0,
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      child: Container(
//                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                        margin: EdgeInsets.only(top: 5.0),
                        child: FutureBuilder<List<Test>>(
                          future: fetchTests(),
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
                                    child: new Container(
//                                      width: MediaQuery.of(context).size.width * 0.6,
                                      width: 150.0,
                                      margin: EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: new Border.all(
                                            width: 2.0,
                                            style: BorderStyle.solid,
                                            color: Colors.grey,
                                          ),
                                          borderRadius: new BorderRadius.all(new Radius.circular(5.0)),

//                                          gradient: new LinearGradient(
//                                            colors: [Colors.lightBlueAccent, Colors.blue],
////                                              begin: Alignment.centerRight,
////                                              end: new Alignment(-1.0, -1.0)
//                                          ),
                                        ),
                                        child: Center(child: Text(snapshot.data[index].name, style: TextStyle(fontSize: 18.0, color: Colors.white),)),
                                      ),
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
      case 2:{
        return Text("Welcome to GK", style: TextStyle(fontFamily: 'Roboto', fontSize: 24.0, fontWeight: FontWeight.normal));
      }
      case 3:{
        return Text("Welcome to the Forum", style: TextStyle(fontFamily: 'Roboto', fontSize: 24.0, fontWeight: FontWeight.normal));
      }
    }



  }

  Future<List<Test>> fetchTests() async {
    final response =await http.get('https://www.xatprep.com/api/get_tests.php');
    //final response = await http.get('https://jsonplaceholder.typicode.com/posts');
    print(response.body);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      print(response.body);
      Iterable list = json.decode(response.body);
      var tests = new List<Test>();
      tests = list.map((model) => Test.fromJson(model)).toList();

      return tests;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onCardTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class Test {
  final String name;


  Test({this.name});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      name: json['name'],
    );
  }
}


