class AboutData {
  static String appName = 'Intertwined';
  static List<String> content = [
    "Built using Flutter, Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase, this mobile application uses Firebase as a backend",
    'This is an open-source project. Any and all the help is appreciable. Click the link below to find the GitHub Repository. You can also file issues or request features on the GitHub repo'
  ];
  static List<AboutLink> aboutLinks = [
    AboutLink(
      category: 'Creator',
      text: 'Madhur Maurya',
      url: 'https://github.com/emem365',
    ),
    AboutLink(
      category: 'GitHub Repo',
      text: 'emem365/intertwined',
      url: 'https://github.com/emem365/intertwined',
    ),
  ];
}

class AboutLink {
  AboutLink({
    required this.category,
    required this.text,
    required this.url,
  });
  final String category;
  final String text;
  final String url;
}
