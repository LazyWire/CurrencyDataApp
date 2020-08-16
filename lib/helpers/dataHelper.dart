import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyData {
  CurrencyData(){
    getData();
  }
  Map someData;
  List<String> charCode = []; 
  List<int> nominal = []; 
  List<String> name = [];
  List<double> value = []; 
  String url = 'https://www.cbr-xml-daily.ru/daily_json.js';
  
  Future<void> getData() async{
    var response = await http.get(this.url);
    someData = jsonDecode(response.body)["Valute"];
    
    this.charCode = [];
    this.nominal= [];
    this.name = [];
    this.value = [];      
    
    someData = jsonDecode(response.body)["Valute"];
    someData.forEach((k,v) => this.charCode.add(v['CharCode']));
    someData.forEach((k,v) => this.nominal.add(v['Nominal']));
    someData.forEach((k,v) => this.value.add(v['Value']));
    someData.forEach((k,v) => this.name.add(v['Name']));

  }
}