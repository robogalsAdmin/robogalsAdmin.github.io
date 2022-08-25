import 'package:robogals/models/level.dart';

/// Stores global data and settings for the application
class ProjectEnv {

  //// -- DATA --

  /// Once the levels have been loaded in from JSON, they are stored here
  static List<Level> levels = [];


  //// -- SETTINGS --
  
  /// The id of the general stem level
  static const int generalStemId = -1;

  /// The Government acknowledgement text
  static const String acknowledgement = "This project is supported by the Australian Government\nDepartment of Industry, Science and Resources through the\nWomen in STEM and Entrepreneurship program";

  /// If true, an alignment grid is show on the map page. The
  /// material objects also are outlined and slightly visible, to allow easier alignment
  static const bool showAlignmentGuide = false;


  //// -- PATHS --

  /// The url of the folder where all the PDFs are being stored. Points to ./web/ on the hosted app.
  static const String pdfUrl = "https://robogals.thewindmills.com.au/activities/";

  /// The path to the json storing the level data
  static const String levelJson = "assets/level.json";

  /// The path to the images folder
  static const String imagePath = "assets/images/";

  /// The path to the splashscreen image
  static const String splashscreenPath = "${imagePath}splashscreen.png";

  /// The path to the stacked government image
  static const String governmentStackedPath = "${imagePath}government-stacked-trans.png";

  /// The path to the logo image
  static const String logoPath = "${imagePath}logo.png";

  /// The path to the background image for the map
  static const String backgroundPath = "${imagePath}background.png";

  /// The path to the image for the map
  static const String mapPath = "${imagePath}map.png";

}
