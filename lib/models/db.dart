import 'package:linegitud/models/user.dart';

class DbResult{
  bool success;
  String? error;

  DbResult({
    required this.success,
    this.error,
  });
}

class DbResultId extends DbResult{
  int id;

  DbResultId({
    required super.success,
    super.error,
    required this.id
  });
}

class DbResultUser extends DbResult{
  CleanUser user;

  DbResultUser({
    required super.success,
    super.error,
    required this.user
  });
}