class AvailableDate {
  final String date;
  final String dayLabel;
  final String dayNumber;
  final String monthLabel;
  final bool isAvailable;

  AvailableDate({
    required this.date,
    required this.dayLabel,
    required this.dayNumber,
    required this.monthLabel,
    required this.isAvailable,
  });

  factory AvailableDate.fromJson(Map<String, dynamic> json) {
    return AvailableDate(
      date: json['date'] ?? '',
      dayLabel: json['day_label'] ?? '',
      dayNumber: json['day_number'] ?? '',
      monthLabel: json['month_label'] ?? '',
      isAvailable: json['is_available'] ?? false,
    );
  }
}

class AvailableTimeSlot {
  final String time;
  final String label;
  final bool available;

  AvailableTimeSlot({
    required this.time,
    required this.label,
    required this.available,
  });

  factory AvailableTimeSlot.fromJson(Map<String, dynamic> json) {
    return AvailableTimeSlot(
      time: json['time'],
      label: json['label'],
      available: json['available'] ?? false,
    );
  }
}
