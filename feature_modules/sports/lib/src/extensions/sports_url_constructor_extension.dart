extension UrlConstructorExtension on String {
  String _convertTitleToUrl(String title) {
    const replacements = {
      "ä": "ae",
      "ü": "ue",
      "ö": "oe",
      "®": "_",
      "&": "_und_",
      "(": "_",
      ")": "_",
      "/": "_",
      "ß": "ss",
      ",": "_",
      ".": "_",
    };

    String parsedTitle = title.replaceAllMapped(
      RegExp(replacements.keys.map(RegExp.escape).join("|")),
      (match) => replacements[match.group(0)]!,
    );

    return parsedTitle.replaceAll(" ", "_");
  }

  String constructSportsUrl(String title) {
    return "${this}_${_convertTitleToUrl(title)}.html";
  }
}
