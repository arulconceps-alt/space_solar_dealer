enum AlertType { success, failure, network, server }

class AlertState {
  final String message;
  final AlertType type;
  final DateTime timestamp; // Forces the UI to listen even if the message is identical

  AlertState({
    required this.message,
    required this.type,
    required this.timestamp,
  });
}