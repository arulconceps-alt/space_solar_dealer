// Location data helper class
class LocationInfo {
  final int id;
  final String name;
  final String? code;

  LocationInfo({required this.id, required this.name, this.code});

  factory LocationInfo.fromJson(Map<String, dynamic> json) {
    return LocationInfo(
      id: json['id'],
      name: json['name'],
      code: json['code'],
    );
  }
}

class ProfileModel {
  final String? id;
  final String? email;
  final String? phone;
  final String? name;
  final String? status;
  final String? createdAt; // ✅ Added this field
  final LocationInfo? state; // ✅ Changed from String to LocationInfo
  final LocationInfo? district; // ✅ Changed from String to LocationInfo

  ProfileModel({
    this.id,
    this.email,
    this.phone,
    this.name,
    this.status,
    this.createdAt,
    this.state,
    this.district,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      name: json['name'],
      status: json['status'],
      createdAt: json['createdAt'],
      state: json['state'] != null ? LocationInfo.fromJson(json['state']) : null,
      district: json['district'] != null ? LocationInfo.fromJson(json['district']) : null,
    );
  }
}