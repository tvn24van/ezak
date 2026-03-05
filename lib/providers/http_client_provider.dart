import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

/// Safety layer reminding not to close manually the [clientProvider]
extension type AutoDisposeClient(Client client) implements Client{
  @Deprecated("AutoDisposeClient should not be closed manually")
  void close() => throw UnsupportedError("AutoDisposeClient should not be closed manually");
}

/// Http Client provider you shouldn't close yourself
final clientProvider = Provider.autoDispose.family<AutoDisposeClient, int?>((ref, retries) {
  final client = RetryClient(Client(), retries: retries?? 1);
  ref.onDispose(() => client.close());
  return AutoDisposeClient(client);
});