import 'package:url_launcher/url_launcher.dart';

class Command {
  static final List<String> all = [email, browser1, browser2];

  static const String email = "write email",
      browser1 = "open",
      browser2 = "go to";
}

class Utils {
  static void scanText(String rawText) {
    String text = rawText.toLowerCase();

    if (text.contains(Command.email)) {
      List<String> mailto = ["abc@gmail.com", "example@gmail.com"];
      String subject = "Test purpose";
      String body = _getTextAfterCommand(text: text, command: Command.email);

      _openEmail(mailto: mailto, subject: subject, body: body);
    } else if (text.contains(Command.browser1)) {
      String url = _getTextAfterCommand(text: text, command: Command.browser1);

      _openLink(url: url);
    } else if (text.contains(Command.browser2)) {
      String url = _getTextAfterCommand(text: text, command: Command.browser2);

      _openLink(url: url);
    }
  }

  static String _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return "";
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future _openLink({
    required String url,
  }) async {
    if (url.trim().isEmpty) {
      await _launchUrl("https://google.com");
    } else {
      await _launchUrl("https://$url");
    }
  }

  static Future _openEmail({
    required List<String> mailto,
    required String subject,
    required String body,
  }) async {
    final url =
        "mailto:${mailto[0]},${mailto[1]}?subject=${Uri.encodeFull(subject)}"
        "&body=${Uri.encodeFull(body)}";
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async => await launchUrl(Uri.parse(url));
}
