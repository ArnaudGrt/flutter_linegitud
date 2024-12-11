import 'package:linegitud/models/user.dart';

class DbResult{
  bool success;
  String? error;
  int? id;
  CleanUser? user;

  DbResult({
    required this.success,
    this.error,
    this.id,
    this.user
  });
}