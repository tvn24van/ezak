import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

class DebugLoggingQueryExecutor extends QueryExecutor{

  final QueryExecutor inner;

  DebugLoggingQueryExecutor(this.inner);

  static QueryExecutor wrap(QueryExecutor inner) {
    if(!kDebugMode) return inner;
    if (inner is DatabaseConnection) {
      return inner.withExecutor(DebugLoggingQueryExecutor(inner.executor));
    } else {
      return DebugLoggingQueryExecutor(inner);
    }
  }

  Future<T> _log<T>(String content, Future<T> Function() inner, List<Object?> parameters)async{
    try {
      debugPrint('q: $content\np: $parameters');
      return await inner();
    } catch (e) {
      rethrow;
    }
  }

  @override
  QueryExecutor beginExclusive() {
    return inner.beginExclusive();
  }

  @override
  TransactionExecutor beginTransaction() {
    return inner.beginTransaction();
  }

  @override
  SqlDialect get dialect => inner.dialect;

  @override
  Future<bool> ensureOpen(QueryExecutorUser user) {
    return inner.ensureOpen(user);
  }

  @override
  Future<void> runBatched(BatchedStatements statements) {
    return inner.runBatched(statements);
  }

  @override
  Future<void> runCustom(String statement, [List<Object?>? args]) {
    return inner.runCustom(statement, args);
  }

  @override
  Future<int> runDelete(String statement, List<Object?> args) {
    return inner.runDelete(statement, args);
  }

  @override
  Future<int> runInsert(String statement, List<Object?> args) {
    return inner.runInsert(statement, args);
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(String statement, List<Object?> args) {
    return _log(statement, ()=> inner.runSelect(statement, args), args);
  }

  @override
  Future<int> runUpdate(String statement, List<Object?> args) {
    return inner.runUpdate(statement, args);
  }

}