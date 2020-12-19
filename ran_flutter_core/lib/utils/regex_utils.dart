class RegexUtils {
  static bool isImage(String input) {
    RegExp image = new RegExp(r"\.(png|jpg|gif|jpeg|webp)$");
    return image.hasMatch(input);
  }

  static bool isAudio(String input) {
    RegExp audio = new RegExp(
        r"\.(mp3|aac|wma|ogg|flac|ape|wav|amr|m4a|m4r|3gpp|au|caf|ac3|aiff|voc|wv|aifc|mmf)$");
    return audio.hasMatch(input);
  }
}
