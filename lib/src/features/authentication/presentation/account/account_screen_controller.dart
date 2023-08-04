import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountSreenController extends StateNotifier<AsyncValue> {
  final FakeAuthRepository fakeAuthRepository;

  AccountSreenController({required this.fakeAuthRepository})
      : super(const AsyncValue.data(null));

  Future<bool> signOut() async {
    try {
      state = const AsyncValue.loading();
      await fakeAuthRepository.signOut();
      state = const AsyncValue.data(null);
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider.autoDispose<AccountSreenController, AsyncValue>(
        (ref) {
  final fakeAuthRepository = ref.watch(fakeAuthRepositoryProvider);
  return AccountSreenController(fakeAuthRepository: fakeAuthRepository);
});
