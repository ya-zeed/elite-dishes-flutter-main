// ignore_for_file: prefer_interpolation_to_compose_strings

class ApiPaths {
  static const String baseUrl = "https://elite.yt.sa/api/";
  static getRecipe(id) => "recipes/$id/languages";
  static getDescription(id,langId) => "recipes/$id/languages/$langId";
}
