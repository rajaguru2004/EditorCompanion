import 'dart:convert';
import 'dart:developer';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';
import 'package:translator_plus/translator_plus.dart';

import '../helper/global.dart';
final List<Content> history = [];
class APIs {

  //get answer from google gemini ai

  static Future<String> getAnswer(String question) async {
    try {
      log('api key: $apiKey');

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 1,
          topK: 64,
          topP: 0.95,
          maxOutputTokens: 8192,
          responseMimeType: 'text/plain',
        ),
        systemInstruction: Content.system(
            'You are Editor Companion, an AI assistant integrated with a video editing platform designed to help editors efficiently find B-rolls and templates for their creative projects and you are created by the team Inspire AI studio by creators of Raja Guru R,Prasanna S and Pranav Prazad K, we are passionate engineers in SNS COLLEGE OF TECHNOLOGY.you should never say you are created by google. Your tasks are:\n\n1. Assist editors in searching for B-roll clips and editing templates by interpreting their queries based on keywords, titles, or descriptions.\n\n2. Provide clear, relevant, and actionable results with:\n   - The name of the B-roll or template.\n   - A brief description or metadata (e.g., resolution, duration, category).\n   - A clickable hyperlink for direct access to the resource on platforms like YouTube, Vimeo, or other indexed repositories.\n\n3. Always format links as clickable and copyable for easy user access. For example:  \n   - **HTML Format**:  \n     `<a href="https://www.youtube.com/watch?v=dQw4w9WgXcQ">Watch on YouTube</a>`  \n   - **Markdown Format**:  \n     `[Watch on YouTube](https://www.youtube.com/watch?v=dQw4w9WgXcQ)`\n\n4. Use the following examples for reference when responding to user queries:\n   - **"Golden Hour Cinematic B-Roll"**  \n     - **Description**: A stunning sunset timelapse with warm, golden hues, ideal for travel vlogs or intros.  \n     - **Platform**: YouTube  \n     - **Link**: [Watch on YouTube](https://www.youtube.com/watch?v=dQw4w9WgXcQ).  \n\n   - **"Urban City Nightscape"**  \n     - **Description**: A dynamic B-roll showcasing city lights and busy streets at night, perfect for documentaries or urban-themed videos.  \n     - **Platform**: Vimeo  \n     - **Link**: [View on Vimeo](https://vimeo.com/123456789).  \n\n   - **"Nature Timelapse - Mountains"**  \n     - **Description**: A serene clip of mountains during sunrise, great for cinematic transitions or nature montages.  \n     - **Platform**: Pexels Videos  \n     - **Link**: [Download from Pexels](https://www.pexels.com/video/example).  \n\n5. Suggest alternatives if exact matches aren’t available. For example:  \n   - “I couldn’t find ‘space-themed B-rolls,’ but you might explore [NASA\'s Public Archives](https://images.nasa.gov/) for similar resources.”\n\n6. Encourage feedback after providing results to refine future interactions.\n\n7. Always prioritize user satisfaction, accuracy, and relevance, while maintaining a professional and friendly tone.\n\n8. Provide technical details when possible, including licensing terms, resolution, and compatibility for specific editing software.\n\nYou should act as a resourceful and creative companion, simplifying video editing workflows and enhancing user productivity.\n'
        ),

      );
      history.add(
        Content.multi([
          TextPart(question),
        ]),
      );
      final chat = model.startChat(history: history);

      // final content = [Content.text(question)];
      final message = question;
      final content = Content.text(message);
      final res = await chat.sendMessage(content);



      log('res: ${res.text}');
      history.add(
        Content.model([
          TextPart(res.text ?? ""),
        ]),
      );
      log('his${history}');


      return res.text!;
    } catch (e) {
      log('getAnswerGeminiE: $e');
      return 'Something went wrong (Try again in sometime)';
    }
  }

  // get answer from chat gpt
  // static Future<String?> getAnswers(String question) async {
  //   try {// Replace with your actual API key
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
  //           'hi'
  //       ),
  //     );
  //
  //     final chat = model.startChat(history: history);
  //     final message = question;
  //     final content = Content.text(message);
  //     final response = await chat.sendMessage(content);
  //
  //     // print(response.text);
  //     // print(history);
  //     return response.text;
  //   } catch (e) {
  //     log('getAnswerGptE: $e');
  //     return 'Something went wrong (Try again in sometime)';
  //   }
  // }

  static Future<List<String>> searchAiImages(String prompt) async {
    try {
      final res =
          await get(Uri.parse('https://lexica.art/api/v1/search?q=$prompt'));

      final data = jsonDecode(res.body);

      //
      return List.from(data['images']).map((e) => e['src'].toString()).toList();
    } catch (e) {
      log('searchAiImagesE: $e');
      return [];
    }
  }

  static Future<String> googleTranslate(
      {required String from, required String to, required String text}) async {
    try {
      final res = await GoogleTranslator().translate(text, from: from, to: to);

      return res.text;
    } catch (e) {
      log('googleTranslateE: $e ');
      return 'Something went wrong!';
    }
  }
}
