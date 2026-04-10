import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});
}

class ShopState {
  final List<Product> products;
  final List<Product> drops;
  final List<CartItem> cart;
  final bool isLoading;

  const ShopState({
    this.products = const [],
    this.drops = const [],
    this.cart = const [],
    this.isLoading = false,
  });

  ShopState copyWith({
    List<Product>? products,
    List<Product>? drops,
    List<CartItem>? cart,
    bool? isLoading,
  }) {
    return ShopState(
      products: products ?? this.products,
      drops: drops ?? this.drops,
      cart: cart ?? this.cart,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  int get cartTotal =>
      cart.fold(0, (sum, item) => sum + item.quantity);
}

const _mockProducts = [
  Product(
    id: 'prod_001',
    name: 'Members-Only Hoodie',
    description:
        'Premium heavyweight cotton hoodie with embroidered crest. Limited to 200 pieces per season.',
    imageUrl: 'https://picsum.photos/seed/prod1/600/600',
    price: 185,
    originalPrice: 220,
    isLimitedDrop: true,
    dropDate: '2024-12-01T12:00:00Z',
    stock: 43,
    category: 'Apparel',
    tags: ['limited', 'apparel', 'exclusive'],
  ),
  Product(
    id: 'prod_002',
    name: 'Ceramic Ritual Mug',
    description:
        'Handcrafted ceramic mug by artisan studio. Each piece is unique with a glazed interior.',
    imageUrl: 'https://picsum.photos/seed/prod2/600/600',
    price: 48,
    isLimitedDrop: false,
    stock: 120,
    category: 'Lifestyle',
    tags: ['lifestyle', 'artisan'],
  ),
  Product(
    id: 'prod_003',
    name: 'Founders Collection Cap',
    description:
        'Structured cap with leather strap. Exclusive to founding members and early adopters.',
    imageUrl: 'https://picsum.photos/seed/prod3/600/600',
    price: 65,
    isLimitedDrop: true,
    dropDate: '2024-12-05T12:00:00Z',
    stock: 12,
    category: 'Apparel',
    tags: ['limited', 'apparel', 'founders'],
  ),
  Product(
    id: 'prod_004',
    name: 'Wellness Journal',
    description:
        'Guided journal designed with our wellness team. Premium linen cover with gold foil details.',
    imageUrl: 'https://picsum.photos/seed/prod4/600/600',
    price: 38,
    isLimitedDrop: false,
    stock: 250,
    category: 'Lifestyle',
    tags: ['wellness', 'lifestyle'],
  ),
  Product(
    id: 'prod_005',
    name: 'Signature Candle Set',
    description:
        'Three signature scents curated by our community. Soy wax, 60-hour burn time each.',
    imageUrl: 'https://picsum.photos/seed/prod5/600/600',
    price: 95,
    originalPrice: 120,
    isLimitedDrop: false,
    stock: 80,
    category: 'Home',
    tags: ['home', 'fragrance'],
  ),
];

class ShopNotifier extends StateNotifier<ShopState> {
  ShopNotifier() : super(const ShopState());

  Future<void> fetchProducts() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = ShopState(
      products: _mockProducts,
      drops: _mockProducts.where((p) => p.isLimitedDrop).toList(),
      cart: state.cart,
      isLoading: false,
    );
  }

  void addToCart(Product product) {
    final existing =
        state.cart.indexWhere((item) => item.product.id == product.id);
    if (existing >= 0) {
      final updated = List<CartItem>.from(state.cart);
      updated[existing] = CartItem(
        product: product,
        quantity: state.cart[existing].quantity + 1,
      );
      state = state.copyWith(cart: updated);
    } else {
      state = state.copyWith(
        cart: [...state.cart, CartItem(product: product, quantity: 1)],
      );
    }
  }

  void removeFromCart(String productId) {
    state = state.copyWith(
      cart: state.cart.where((item) => item.product.id != productId).toList(),
    );
  }

  void clearCart() {
    state = state.copyWith(cart: []);
  }
}

final shopProvider =
    StateNotifierProvider<ShopNotifier, ShopState>((ref) {
  return ShopNotifier();
});
