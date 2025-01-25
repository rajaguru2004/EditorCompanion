// import 'package:google_generative_ai/google_generative_ai.dart';
//
// List<Content> history = [];
//
// class GetAnsFromAi {
//   // Store the conversation history
//   // final List<Content> _history = [];
//
//   Future<String?> aiChat(String prompt) async {
//     const apiKey =
//         "AIzaSyBO5By2vNskL3Ez_tpNudd74WFHBStnvXo"; // Replace with your actual API key
//
//     final model = GenerativeModel(
//       model: 'gemini-1.5-flash',
//       apiKey: apiKey,
//       generationConfig: GenerationConfig(
//         temperature: 1,
//         topK: 64,
//         topP: 0.95,
//         maxOutputTokens: 8192,
//         responseMimeType: 'text/plain',
//       ),
//       systemInstruction: Content.system(
//         'hi'
//       ),
//     );
//     history.add(
//       Content.multi([
//         TextPart(question),
//       ]),
//     );
//     final chat = model.startChat(history: history);
//     final message = question;
//     final content = Content.text(message);
//     final response = await chat.sendMessage(content);
//     history.add(
//       Content.model([
//         TextPart(response.text ?? ""),
//       ]),
//     );
//     print(response.text);
//     print(history);
//     return response.text;
//   }
// }
