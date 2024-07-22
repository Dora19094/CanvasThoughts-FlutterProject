import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

String capitalize(String word) {
  if (word.isEmpty) return '';
  return word[0].toUpperCase() + word.substring(1).toLowerCase();
}

Future<List<String>> feelingsService(String prompt) async {
  String beginning =
      '''Given this paragraph,in which a person describes his thoughts about a painting,
  return exactly 3 words separated by commas, corresponding to 3 feelings this person has from this painting
  The response must be in the format: feeling1,feeling2,feeling3''';
  prompt = beginning + prompt;
  final openAI = OpenAI.instance.build(
      token: 'MY_KEY',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);
  final request = ChatCompleteText(
      messages: [Messages(role: Role.user, content: prompt)],
      maxToken: 200,
      model: GptTurbo0301ChatModel());
  final response = await openAI.onChatCompletion(request: request);
  String result = '';
  result = response!.choices[0].message!.content;
  result = result.replaceAll('.', '');
  result = result.replaceAll(' ', '');
  final splitted = result.split(',');
  final capitalizedWords = splitted.map(capitalize).toList();

  return capitalizedWords;
}

void main() async {
  String prompt =
      "Spent some time soaking in the beauty of Vincent van Gogh's 'Olive Trees.' It's like stepping into a sun-drenched dream. The colors he splashed on the canvas make those olive trees dance with life. Van Gogh's brushstrokes are full of energy, capturing the essence of a breezy day in an olive grove.";
  final response = await feelingsService(prompt);
  print(response);
  for (int i = 0; i < 3; i++) print(response[i]);
}
