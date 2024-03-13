import 'package:flutter_yt/Services/get_video_tags.dart';
import 'package:flutter_yt/Utils/yt_api_key.dart';
import 'package:youtube_data_api/youtube_data_api.dart';

class VideoControllers {
  Future<String> fetchRecommendedVideos(String videoId) async {
    final tag = await getVideoTags(videoId);
    try {
      YoutubeDataApi youtubeDataApi = YoutubeDataApi();

      if (tag != null) {
        final vidoes = await youtubeDataApi.fetchSearchVideo(tag, apiKey);

        if (vidoes.isNotEmpty) {
          return vidoes[0].videoId;
        } else {
          return '';
        }
      } else {
        return '';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
