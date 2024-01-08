import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

Future<List<String?>> feelingsService(String prompt) async {
  String begining =  'Given this paragraph return exactly 3 words seperated by commas, corresponding to 3 feelings it portrays. ';
  prompt = begining + prompt;
  final openAI = OpenAI.instance.build(token: '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',
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),enableLog: true);
  final request = ChatCompleteText(messages: [
    Messages(role: Role.user, content: prompt)
  ], maxToken: 200, model: GptTurbo0301ChatModel());
  final response = await openAI.onChatCompletion(request: request);
  String result = '';
  result = response!.choices[0].message!.content;
  result = result.replaceAll('.', '');
  result = result.replaceAll(' ', '');
  final splitted = result.split(',');
  return splitted;
}


void main() async {
  // Example prompt
  String prompt = "Spent some time soaking in the beauty of Vincent van Gogh's 'Olive Trees.' It's like stepping into a sun-drenched dream. The colors he splashed on the canvas make those olive trees dance with life. Van Gogh's brushstrokes are full of energy, capturing the essence of a breezy day in an olive grove.";

  // Send request
  final response = await feelingsService(prompt);

  // Print the response
  for (int i = 0;i<3;i++)
    print(response[i]);

  //test();
}