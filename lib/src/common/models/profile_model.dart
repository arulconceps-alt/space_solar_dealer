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
  final String? name;
  final String? email;
  final String? phone;
  final String? status;
  final String? roleType; // ✅ ADD THIS
  final String? addressLine1;
  final String? createdAt;

  final StateModel? state;
  final DistrictModel? district;

  final DealerProfile? dealerProfile;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.status,
    this.roleType, // ✅ ADD THIS
    this.addressLine1,
    this.createdAt,
    this.state,
    this.district,
    this.dealerProfile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      status: json['status'],
      roleType: json['roleType'], // ✅ ADD THIS
      addressLine1: json['addressLine1'],
      createdAt: json['createdAt'],

      state: json['state'] != null
          ? StateModel.fromJson(json['state'])
          : null,

      district: json['district'] != null
          ? DistrictModel.fromJson(json['district'])
          : null,

      dealerProfile: json['dealerProfile'] != null
          ? DealerProfile.fromJson(json['dealerProfile'])
          : null,
    );
  }
}
class StateModel {
  final int? id;
  final String? name;

  StateModel({this.id, this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
class DistrictModel {
  final int? id;
  final String? name;

  DistrictModel({this.id, this.name});

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    return DistrictModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
class DealerProfile {
  final String? businessName;

  DealerProfile({this.businessName});

  factory DealerProfile.fromJson(Map<String, dynamic> json) {
    return DealerProfile(
      businessName: json['businessName'],
    );
  }
}