import 'dart:io';

import 'package:flutter/services.dart';
import 'package:myfirstapp/services/currencyService.dart';
import 'locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();

  try {
    await setupLocator();
    runApp(MyApp());
    
  } catch (error) {
    print(error);
  }
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Валюты центрального банка РФ',
      theme: ThemeData(
        
        primarySwatch: Colors.indigo,
        
        scaffoldBackgroundColor: Colors.grey,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
   FirstPage({Key key}) : super(key:key);
  
  @override
  _FirstPageState createState() => _FirstPageState();
  
  
}

class _FirstPageState extends State<FirstPage> {
  
  @override
  void initState() {
    locator<CurrencyDataService>().data.getData().then((value){
      print(locator<CurrencyDataService>().data.charCode);
      Navigator.of(context).push(
               createRoute(),
               );
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/catjpg.png') )
          ),
        ),
    )
    );
  }
}
Route createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

class SecondPage extends StatefulWidget {
  SecondPage({Key key, this.title}) : super(key:key);
  final String title;

  @override
  _SecondPageState createState() => _SecondPageState();
  
}

class _SecondPageState extends State<SecondPage> {

  void getData() async {
    setState(() {
      locator<CurrencyDataService>().data.getData();
    });

  }
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
      },
      child : Scaffold(
        
        appBar: AppBar(
          
          title: Text('Валюты ЦБ РФ'),
          actions: [
            FlatButton(
              onPressed: getData,
              child: Icon(Icons.refresh,color: Colors.amber,),
              )
          ],
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new ListView.builder(

                 itemCount: locator<CurrencyDataService>().data.charCode.length,

                itemBuilder: (BuildContext context,int index){

                return new ListTile(

                 leading: ExcludeSemantics(

                   child:CircleAvatar(

                     backgroundColor: Colors.indigoAccent,

                      child: Text(locator<CurrencyDataService>().data.charCode[index])
                     ),
                   
                 ),
                   title: Text(locator<CurrencyDataService>().data.name[index].toString()),

                   subtitle: Text('Стоимость: '+(locator<CurrencyDataService>().data.value[index]/locator<CurrencyDataService>().data.nominal[index]).toString()),
                );
             }, 
            ),)
          ],
        ),
      ),
    )
    );
  }
}
