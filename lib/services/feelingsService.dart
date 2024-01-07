import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

Future<List<String>> feelings (String notes)async{
  final String apiUrl = "https://api.apilayer.com/text_to_emotion";
  final text = utf8.encode(notes);
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'apikey': 'u5STmETC3rLXyeYt9Cjafxx2ffFajkwC'},
      body: text
    ).timeout(Duration(seconds: 40));
    if(response.statusCode == 200){
      List<String> result = [];
      Map<String, dynamic> data = json.decode(response.body);
      data = Map.fromEntries(
          data.entries.toList()..sort((e2, e1) => e1.value.compareTo(e2.value)));
      int i =0;
      for ( String key in data.keys){
        if(data[key] as double>0)
          result.add(key);
        i++;
        if(i == 3)
          break;
      }
      return result;
    }
  }catch (e) {
    print('Error: $e');
    return ['Error fetching painting information'];
  }
  return [''];
}

List<String> dummy_feeling(String notes){
  return ['Happy','Excited','Worried'];
}

void test(){
  String body = '''{
    "Happy": 0.14,
    "Angry": 0.0,
    "Surprise": 0.29,
    "Sad": 0.29,
    "Fear": 0.29
  }''';
  Map<String, dynamic> data = json.decode(body);
  List<String> result = [];
  data = Map.fromEntries(
      data.entries.toList()..sort((e2, e1) => e1.value.compareTo(e2.value)));
  int i =0;
  for ( String key in data.keys){
    if(data[key] as double>0)
      result.add(key);
    i++;
    if(i == 3)
      break;
  }
  print(result);
}

void main() async{
  var result = await feelings('I am happy');
  print(result);
}