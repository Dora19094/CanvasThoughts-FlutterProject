import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

Future<String> searchPaintingInfo(String title, String artist) async {
  final String apiUrl =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&list=search&utf8=1&srsearch=$title $artist';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Accept': 'application/json'},
    ).timeout(Duration(seconds: 40));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final searchResults = data['query']['search'];

      if (searchResults.isNotEmpty) {
        final firstResult = searchResults[0];
        final pageTitle = firstResult['title'];

        return await getPaintingInfo(pageTitle);
      } else {
        return 'Painting not found on Wikipedia';
      }
    } else {
      print('Failed to search for painting information');
      return 'Failed to search for painting information';
    }
  } catch (e) {
    print('Error: $e');
    return 'Error fetching painting information';
  }
}

Future<String> getPaintingInfo(String pageTitle) async {
  final String apiUrl =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts&titles=$pageTitle&utf8=1&exintro=1';

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {'Accept': 'application/json'},
  ).timeout(Duration(seconds: 40));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final pages = data['query']['pages'];
    final firstPageKey = pages.keys.first;
    final paintingInfo = pages[firstPageKey];

    String extractedText =
        paintingInfo['extract']  ?? 'Painting information not available';

    var document = parse(extractedText);
    extractedText = document.body?.text ?? extractedText;
    extractedText = extractedText.trimLeft();

    return extractedText;
  } else {
    print('Failed to load painting information');
    return 'Failed to load painting information';
  }
}
