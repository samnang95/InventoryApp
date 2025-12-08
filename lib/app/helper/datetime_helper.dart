class DateTimeHelper {

  /// Input: "2025-12-19 20:51:00.000"
  /// Output: {"date": "2025-12-19", "time": "20:51"}
  static Map<String, String> splitDateTime(String dateTimeString) {
    try {
      // Remove milliseconds
      final cleaned = dateTimeString.split(".").first; // "2025-12-19 20:51:00"

      // Split date and time
      final parts = cleaned.split(" "); // ["2025-12-19", "20:51:00"]

      final date = parts[0];
      final time = parts[1].substring(0, 5); // "20:51"

      return {"date": date, "time": time};
    } catch (e) {
      return {"date": "", "time": ""};
    }
  }

}