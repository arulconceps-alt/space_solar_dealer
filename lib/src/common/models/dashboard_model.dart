class DashboardModel {
  final int totalPanelsSold;
  final int totalCustomers;
  final int activeWarranty;
  final TicketStats tickets;
  final List<RecentActivity> recentActivities;

  DashboardModel({
    required this.totalPanelsSold,
    required this.totalCustomers,
    required this.activeWarranty,
    required this.tickets,
    required this.recentActivities,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      totalPanelsSold: json['totalPanelsSold'] ?? 0,
      totalCustomers: json['totalCustomers'] ?? 0,
      activeWarranty: json['activeWarranty'] ?? 0,
      tickets: TicketStats.fromJson(json['tickets'] ?? {}),
      recentActivities: (json['recentActivities'] as List?)
        ?.map((e) => RecentActivity.fromJson(e))
        .toList() ??
    [],
    );
  }
}

class TicketStats {
  final int total;
  final int open;
  final int pending;
  final int inProgress;
  final int completed;

  TicketStats({
    required this.total,
    required this.open,
    required this.pending,
    required this.inProgress,
    required this.completed,
  });

  factory TicketStats.fromJson(Map<String, dynamic> json) {
    return TicketStats(
      total: json['total'] ?? 0,
      open: json['open'] ?? 0,
      pending: json['pending'] ?? 0,
      inProgress: json['inProgress'] ?? 0,
      completed: json['completed'] ?? 0,
    );
  }
}
class RecentActivity {
  final String id; 
  final String title;
  final String ticketNumber;
  final String status;
  final String createdAt;
  final String customerName;

  RecentActivity({
    required this.id,
    required this.title,
    required this.ticketNumber,
    required this.status,
    required this.createdAt,
    required this.customerName,
  });

  factory RecentActivity.fromJson(Map<String, dynamic> json) {
    return RecentActivity(
      id: json['id'] ?? '', 
      title: json['title'] ?? '',
      ticketNumber: json['ticketNumber'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      customerName: json['customer']?['name'] ?? '',
    );
  }
}