class DatabaseErrorException implements Exception {
  DatabaseErrorException({
    this.message,
    this.exception,
  });
  String message;
  Exception exception;
}
