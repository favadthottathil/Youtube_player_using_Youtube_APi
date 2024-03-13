import 'dart:convert';

import 'package:flutter_yt/Utils/extract_keywords.dart';
import 'package:flutter_yt/Utils/get_hash_tag.dart';
import 'package:flutter_yt/Utils/yt_api_key.dart';
import 'package:http/http.dart' as http;

Future<String?> getVideoTags(String videoId) async {
  final apiEndPoint = 'https://www.googleapis.com/youtube/v3/videos?key=$apiKey&fields=items(snippet(title,description,tags))&part=snippet&id=$videoId';

  try {
    final res = await http.get(Uri.parse(apiEndPoint));

    if (res.statusCode == 200) {
      dynamic resData = jsonDecode(res.body);

      final hashtag = extractFirstHashtag(resData['items'][0]['snippet']['description']);

      if (hashtag == null) {
        List? tags = resData['items'][0]['snippet']['tags'];

        if (tags == null) {
          return extractKeywords(resData['items'][0]['snippet']['title']);
        } else {
          return tags[0];
        }
      } else {
        return hashtag;
      }
    } else {
      throw 'error';
    }
  } catch (e) {
    throw e.toString();
  }
}
