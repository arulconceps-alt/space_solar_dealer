
class TimelineItemModel {
  final String title;
  final String value;
  final bool highlight;

  TimelineItemModel({
    required this.title,
    required this.value,
    this.highlight = false,
  });
}
