import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  //FakeProductsRepository._();
  //static FakeProductsRepository instance = FakeProductsRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final fakeProductsRepositoryProvider = Provider<FakeProductsRepository>((ref) {
  return FakeProductsRepository();
});

final watchProductsListProvider = StreamProvider<List<Product>>((ref) {
  final fakeProductsRepository = ref.watch(fakeProductsRepositoryProvider);
  return fakeProductsRepository.watchProductsList();
});

final watchProductProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  final fakeProductsRepository = ref.watch(fakeProductsRepositoryProvider);
  return fakeProductsRepository.watchProduct(id);
});
