int selectedIndex = 0;
final now = DateTime.now();
var monthCtrl = DateTime(now.year, now.month, now.day);
List<String> category = ["Main Job", "Side Job"];
String selectedCategory = "Main Job";

class LineData {
  LineData(this.month, this.total);

  final String month;
  final double total;
}