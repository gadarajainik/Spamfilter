import 'package:flutter/material.dart';
import 'package:sms/sms.dart';
import 'package:http/http.dart' as http;


void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SMS SPAM FILTER'),
    ),
  );
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Details {
  List<SmsMessage> messages;
  SmsQuery query;
  Future<List<SmsMessage>> fun() async {
    query = new SmsQuery();
    messages = await query.getAllSms;
    return messages;
  }
}


class _MyHomePageState extends State<MyHomePage> {
  List<SmsMessage> messages;
  SmsQuery query;
  String res;
  Future<void> fun() async {
    query = new SmsQuery();
    messages = await query.getAllSms;
  }

  @protected
  @mustCallSuper
  void initState() {
  print("Hiii");
  this.fun();
  }

  Widget predict(BuildContext context,String s){
    String res;
    if(s==null)
    {
      return Scaffold(
        appBar:AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title)
        ),
        body:Center(
          child:Text("Locha"),
          // child:RaisedButton(onPressed:(){Navigator.pop(context);},child: Text("Back"),),
          
        ),
      );  
    }
    else
    {
      http.get('https://7b57fe55.ngrok.io/?msg='+s).then((x) {
        print(x.body);
        res = x.body;
      });
      return Scaffold(
        appBar:AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title)
        ),
        body:Center(
          child:Text(res),
          // child:RaisedButton(onPressed:(){Navigator.pop(context);},child: Text("Back"),),
          
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    // String a="Jainik Here..";
    if(messages==null || messages.length==0)
    {
      String res="";
      http.get('https://7b57fe55.ngrok.io/?msg=Myname is jainik').then((x) {
        print(x.body);
        res = x.body;
      });
      return Scaffold(
        appBar:AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[new Icon(Icons.more_vert)],
      ),
      body:Text(res)
      );
    }
    else
    {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[new Icon(Icons.more_vert)],
        ),
        body: new ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, i) => new Column(
            children: <Widget>[
              new Divider(
                height: 10.0,
              ),
              new ListTile(
                onTap:(){
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>predict(context,messages[i].body.toString())));
                },
                leading: Icon(
                  Icons.account_circle,
                  size: 50,
                ),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      messages[i].sender.toString(),
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
                      messages[i].body.toString(),
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
}
