part of 'new_register_bloc.dart';

enum NewRegisterStatus { initial, loading, success, failure }

class NewRegisterState extends Equatable {
  final NewRegisterStatus status;
  final String message;

  final List<String> states;
  final List<String> districts;

  final String? selectedState;
  final String? selectedDistrict;

  // ✅ ADD THIS (missing)
  final List<Map<String, dynamic>> searchResults;

  const NewRegisterState({
    this.status = NewRegisterStatus.initial,
    this.message = '',
    this.states = const [],
    this.districts = const [],
    this.selectedState,
    this.selectedDistrict,
    this.searchResults = const [], // ✅ keep
  });

  factory NewRegisterState.initial() {
    return const NewRegisterState();
  }

  NewRegisterState copyWith({
    NewRegisterStatus? status,
    String? message,
    List<String>? states,
    List<String>? districts,
    String? selectedState,
    String? selectedDistrict,
    List<Map<String, dynamic>>? searchResults,
  }) {
    return NewRegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
      states: states ?? this.states,
      districts: districts ?? this.districts,
      selectedState: selectedState ?? this.selectedState,
      selectedDistrict: selectedDistrict ?? this.selectedDistrict,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    states,
    districts,
    selectedState,
    selectedDistrict,
    searchResults, // ✅ ADD THIS
  ];
}