import 'dart:convert';
import 'package:canvasthoughtsflutter/models/painting.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:http/http.dart' as http;

Future<String?> getImageUrl(String title) async {
  final apiUrl =
      'http://en.wikipedia.org/w/api.php?action=query&titles=$title&prop=pageimages&format=json&pithumbsize=320';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final pages = data['query']['pages'];

      if (pages != null && pages.isNotEmpty) {
        final pageId = pages.keys.first;
        final pageData = pages[pageId];
        print(pages);

        if (pageData['thumbnail'] != null) {
          final thumbnail = pageData['thumbnail'];

          if (thumbnail != null) {
            final imageUrl = thumbnail['source'];

            if (imageUrl != null) {
              print('Image URL: $imageUrl');
              return imageUrl;
            }
          }
        }
      }
    }
  } catch (error) {
    print('Error fetching image URL: $error');
  }

  return null;
}

Future<List<Painting>> searchSpecificPaintings(
    String artist, String paintingTitle) async {
  String prompt =
      '''Return me 6 famous paintings that are relevant to ${artist}, ${paintingTitle}. 
  The response must be in the format: title1,artist1,title2,artist2,...''';

  final openAI = OpenAI.instance.build(
      token: 'MY_KEY',
      baseOption: HttpSetup(receiveTimeout: const Duration(minutes: 5)),
      enableLog: true);
  final request = ChatCompleteText(
      messages: [Messages(role: Role.user, content: prompt)],
      maxToken: 3000,
      model: GptTurbo0301ChatModel());
  final response = await openAI.onChatCompletion(request: request);
  String result = '';
  result = response!.choices[0].message!.content;
  print(result);

  final values = result.split(',');
  final List<Painting> paintings = [];
  for (int i = 0; i < values.length; i += 2) {
    final title = values[i].trim().replaceAll('"', '');
    final artist = values[i + 1].trim().replaceAll('"', '');

    final imageUrl = await getImageUrl("$title");
    if (imageUrl == null) continue;

    paintings.add(Painting(
      title: title,
      artist: artist,
      imageUrl: imageUrl,
    ));
  }

  return paintings;
}

void main() async {
  // final paintings = await searchSpecificPaintings('Starry Night','');
  // paintings.forEach((painting) {
  //    print('Title: ${painting.title}, Artist: ${painting.artist}, Image URL: ${painting.imageUrl}');
  //  });
  getImageUrl("Mona Lisa");
}
