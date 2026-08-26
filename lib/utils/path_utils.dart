class PathUtils {
  static String extractFileName(String filePath) {
    return filePath.split('/').last;
  }
}
