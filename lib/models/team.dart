import 'package:equatable/equatable.dart';

class Team extends Equatable {
  final bool? isNBAFranchise;
  final String? city;
  final String? altCityName;
  final String? fullName;
  final String? tricode;
  final String? teamId;

  const Team(
      {required this.isNBAFranchise,
      required this.city,
      required this.altCityName,
      required this.fullName,
      required this.tricode,
      required this.teamId});

  @override
  List<Object?> get props =>
      [isNBAFranchise, city, altCityName, fullName, tricode, teamId];
}
