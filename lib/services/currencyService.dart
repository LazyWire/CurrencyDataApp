import 'package:myfirstapp/helpers/dataHelper.dart';

class CurrencyDataService {
  CurrencyData data;
  CurrencyDataService(){
    this.data = CurrencyData();
    // this.data.getData();
    // print(this.data.charCode);
  }

  Future<void> getData() async {
    return data;
  }
}