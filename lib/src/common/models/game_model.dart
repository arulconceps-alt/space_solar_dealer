import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final String state;
  final String price;
  final String hours;
  final String minutes;
  final String seconds;
  final String image;

  const GameModel({
    required this.state,
    required this.price,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.image,
  });

  GameModel copyWith({
    String? state,
    String? price,
    String? hours,
    String? minutes,
    String? seconds,
    String? image,
  }) {
    return GameModel(
      state: state ?? this.state,
      price: price ?? this.price,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      image: image ?? this.image,
    );
  }

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      state: json['state'] ?? '',
      price: json['price'] ?? '',
      hours: json['hours'] ?? '',
      minutes: json['minutes'] ?? '',
      seconds: json['seconds'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "state": state,
    "price": price,
    "hours": hours,
    "minutes": minutes,
    "seconds": seconds,
    "image": image,
  };

  factory GameModel.empty() {
    return const GameModel(
      state: '',
      price: '',
      hours: '',
      minutes: '',
      seconds: '',
      image: '',
    );
  }

  @override
  List<Object> get props => [state, price, hours, minutes, seconds, image];
}

class LotteryHistoryModel extends Equatable {
  final String state;
  final String date;
  final String time;
  final String a;
  final String b;
  final String c;

  const LotteryHistoryModel({
    required this.state,
    required this.date,
    required this.time,
    required this.a,
    required this.b,
    required this.c,
  });

  LotteryHistoryModel copyWith({
    String? state,
    String? date,
    String? time,
    String? a,
    String? b,
    String? c,
  }) {
    return LotteryHistoryModel(
      state: state ?? this.state,
      date: date ?? this.date,
      time: time ?? this.time,
      a: a ?? this.a,
      b: b ?? this.b,
      c: c ?? this.c,
    );
  }

  factory LotteryHistoryModel.fromJson(Map<String, dynamic> json) {
    return LotteryHistoryModel(
      state: json['state'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      a: json['a'] ?? '',
      b: json['b'] ?? '',
      c: json['c'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "state": state,
    "date": date,
    "time": time,
    "a": a,
    "b": b,
    "c": c,
  };

  factory LotteryHistoryModel.empty() {
    return const LotteryHistoryModel(
      state: '',
      date: '',
      time: '',
      a: '',
      b: '',
      c: '',
    );
  }

  @override
  List<Object> get props => [state, date, time, a, b, c];
}

class LotteryWinnerModel extends Equatable {
  final String playerId;
  final String location;
  final String prize;
  final String avatarPath;

  const LotteryWinnerModel({
    required this.playerId,
    required this.location,
    required this.prize,
    required this.avatarPath,
  });

  LotteryWinnerModel copyWith({
    String? playerId,
    String? location,
    String? prize,
    String? avatarPath,
  }) {
    return LotteryWinnerModel(
      playerId: playerId ?? this.playerId,
      location: location ?? this.location,
      prize: prize ?? this.prize,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }

  factory LotteryWinnerModel.fromJson(Map<String, dynamic> json) {
    return LotteryWinnerModel(
      playerId: json['playerId'] ?? '',
      location: json['location'] ?? '',
      prize: json['prize'] ?? '',
      avatarPath: json['avatarPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'playerId': playerId,
    'location': location,
    'prize': prize,
    'avatarPath': avatarPath,
  };

  factory LotteryWinnerModel.empty() {
    return const LotteryWinnerModel(
      playerId: '',
      location: '',
      prize: '',
      avatarPath: '',
    );
  }

  @override
  List<Object> get props => [playerId, location, prize, avatarPath];
}

class LotteryQuickActionModel extends Equatable {
  final String title;
  final String subtitle;
  final String iconPath;

  const LotteryQuickActionModel({
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });

  LotteryQuickActionModel copyWith({
    String? title,
    String? subtitle,
    String? iconPath,
  }) {
    return LotteryQuickActionModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      iconPath: iconPath ?? this.iconPath,
    );
  }

  factory LotteryQuickActionModel.fromJson(Map<String, dynamic> json) {
    return LotteryQuickActionModel(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      iconPath: json['iconPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'iconPath': iconPath,
  };

  factory LotteryQuickActionModel.empty() {
    return const LotteryQuickActionModel(title: '', subtitle: '', iconPath: '');
  }

  @override
  List<Object> get props => [title, subtitle, iconPath];
}

class LotteryFeatureModel extends Equatable {
  final String label;
  final String imagePath;

  const LotteryFeatureModel({required this.label, required this.imagePath});

  LotteryFeatureModel copyWith({String? label, String? imagePath}) {
    return LotteryFeatureModel(
      label: label ?? this.label,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  factory LotteryFeatureModel.fromJson(Map<String, dynamic> json) {
    return LotteryFeatureModel(
      label: json['label'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'label': label, 'imagePath': imagePath};

  factory LotteryFeatureModel.empty() {
    return const LotteryFeatureModel(label: '', imagePath: '');
  }

  @override
  List<Object> get props => [label, imagePath];
}
