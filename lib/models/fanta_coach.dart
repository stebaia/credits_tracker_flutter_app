import 'package:equatable/equatable.dart';

class FantaCoach extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String teamName;
  final int credits;

  const FantaCoach(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.teamName,
      required this.credits});

  FantaCoach.fromJson(Map<String, dynamic> json) : this(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      teamName: json["teamName"],
      credits: json["credits"]
  );

  @override
  List<Object?> get props => [id, firstName, lastName, teamName, credits];
}
