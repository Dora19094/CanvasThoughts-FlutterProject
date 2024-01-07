import 'dart:convert';
import 'package:canvasthoughtsflutter/models/painting.dart';
import 'package:http/http.dart' as http;
//
// Future<void> fetchSpecificPaintings() async {
//   final String tokenUrl =
//       "https://api.artsy.net/api/tokens/xapp_token?client_id=4c743e15a3e045d6555d&client_secret=fd274bac30da6c9522278bb7e09fd3a5";
//   final String apiUrl = 'https://api.artsy.net/api/search';
//
//   try {
//     final tokenResponse = await http.post(
//       Uri.parse('$tokenUrl'),
//     );
//     final Map<String, dynamic> tokenData = json.decode(tokenResponse.body);
//     final String token = tokenData['token'];
//     print('Token: $token');
//
//     final response = await http.get(
//       Uri.parse('$apiUrl?q=The+Starry+Night'),
//       headers: {'X-Xapp-Token': token},
//     );
//     print(json.decode(response.body));
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final List<dynamic> artworks = json.decode(response.body)['_embedded']['artworks'];
//
//       for (var artwork in artworks) {
//         //print(response.body);
//         final String title = artwork['title'];
//         final String artist = await extractArtistName(artwork,token);
//         final String imageUrl = artwork['_links']['thumbnail']?['href'] ?? 'No thumbnail available';
//
//         print('Title: $title');
//         print('Artist: $artist');
//         print('Image URL: $imageUrl');
//         print('---');
//       }
//     } else {
//       print('Failed to fetch paintings. Status code: ${response.statusCode}');
//     }
//   } catch (error) {
//     print('Error fetching paintings: $error');
//   }
// }
//
// Future<String> extractArtistName(dynamic artwork,String token) async{
//   try {
//     final res = await http.get(
//         Uri.parse(artwork['_links']['artists']['href']),
//         headers: {'X-Xapp-Token': token}
//     );
//     print(res);
//     if (res.statusCode == 200) {
//       final artistData = json.decode(res.body);
//       //print(artistData);
//       return artistData['_embedded']['artists'][0]['name'] ?? 'Unknown Artist';
//     }
//   } catch (error) {
//     print('Error fetching artist information: $error');
//   }
//   return 'not got';
// }

Future<List<Painting>> fetchSpecificPaintings() async {
  final String apiKey = 'mbritemitt';
  final String apiUrl = 'https://www.europeana.eu/api/v2/search.json';
  final List<Painting> results = [];

  try {
    final response = await http.get(
      Uri.parse('$apiUrl?wskey=$apiKey&query=title:"Sun"&qf=TYPE:IMAGE'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data.isEmpty) {
        throw Exception('No paintings retrieved');
      }
      final List<dynamic> items = data['items'];

      for (var item in items) {
        //print(item);
        final String title = (item['title'] as List<dynamic>?)?.first ?? 'Unknown Title';
        final String creator = (item['dcCreator'] as List<dynamic>?)?.first ?? 'Unknown Creator';
        final String imageUrl = (item['edmPreview'] as List<dynamic>?)?.first ?? 'No preview available';
        if (title != 'Unknown Title' && creator != 'Unknown Creator' && !RegExp(r'\d').hasMatch(creator)
            && imageUrl != 'No preview available' && !creator.contains("http")){
          print('Title: $title');
          print('Creator: $creator');
          print('Image URL: $imageUrl');
          print('---');
          Painting new_painting = Painting(artist: creator, title: title, imageUrl: imageUrl);
          results.add(new_painting);
        }
      }
      return results;
    } else {
      throw Exception('Failed to fetch paintings. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching data: $error');
    return results;
  }
}



void main() async {
  List<Painting> res = await fetchSpecificPaintings();
  for (var painting in res){
    print(painting.title);
  }
   print(res);
 }

