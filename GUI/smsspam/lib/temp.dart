import 'package:flutter/material.dart';
// import 'package:sms/sms.dart';
// import 'package:http/http.dart' as http;


void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(title: 'SMS SPAM FILTER'),
    ),
  );
}

// class Details {
//   List<SmsMessage> messages;
//   SmsQuery query;
//   Future<List<SmsMessage>> fun() async {
//     query = new SmsQuery();
//     messages = await query.getAllSms;
//     return messages;
//   }
// }

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  Widget predict(BuildContext context,String s){
    return Scaffold(
      body:Center(
        child:RaisedButton(onPressed:(){Navigator.pop(context);},child: Text(s),),
        
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    String a="Jainik Here..";
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[new Icon(Icons.more_vert)],
      ),
      body: new ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) => new Column(
          children: <Widget>[
            new Divider(
              height: 10.0,
            ),
            new ListTile(
              onTap:(){
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>predict(context,a)));
              },
              leading: Icon(
                Icons.account_circle,
                size: 50,
              ),
              title: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    "Sender",
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  new Text(
                    "SPAM/HAM",
                    style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                  )
                ],
              ),
              subtitle: new Container(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: new Text(
                    "Message...",
                    maxLines: 1,
                  )),
            )
          ],
        ),
        //     children: new List.generate(messages.length, (int index) {
        //   return new ListTile(

        //     leading: Icon(Icons.account_circle),
        //     title: Text(messages[index].sender),
        //     subtitle: new Text(
        //       messages[index].body,
        //       maxLines: 1,
        //     ),
        //     // title: Text(check(messages[index].body)as String),
        //   );
        // })
      ),
    );
  }
}