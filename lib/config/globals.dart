// ignore: camel_case_types
class Globals {
  static final Globals _instance = Globals.internal();

  factory Globals() => _instance;

  Globals.internal();

  static const CONTACT_SELECTION = 'CONTACT_SELECTION';
  static const SELECTEDLIST = 'SELECTEDLIST';
  static const RECIVE_OPTION = 'RECIVE_OPTION';
  static const MESSAGE = 'MESSAGE';
  static const SECURITY_ALLOWED = "security_allowed";
  static const MENU_REPLY_DATA = "menu_reply_data";
  static const TEMPLATE_COUNT = "TEMPLATE_COUNT";
  static const SELECTED_TEMPLATE = "SELECTED_TEMPLATE";
  static const SELECTED_TEMPLATE_DATA = "SELECTED_TEMPLATE_DATA";
}
