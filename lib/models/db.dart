class DbResult{
  bool success;
  String? error;
  int? id;

  DbResult({
    required this.success,
    this.error,
    this.id
  });
}