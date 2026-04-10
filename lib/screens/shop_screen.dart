import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/shop_provider.dart';
import '../widgets/product_card.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    ref.read(shopProvider.notifier).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final shop = ref.watch(shopProvider);

    final filteredProducts = _filter == 'all'
        ? shop.products
        : _filter == 'drops'
            ? shop.drops
            : shop.products
                .where((p) => p.category.toLowerCase() == _filter)
                .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            // Header with cart
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shop',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Stack(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.shopping_bag_outlined,
                            size: 22, color: Colors.white),
                      ),
                      if (shop.cartTotal > 0)
                        Positioned(
                          top: 2,
                          right: 2,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC8A97E),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${shop.cartTotal}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Filter tabs
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                children:
                    ['all', 'drops', 'apparel', 'lifestyle', 'home'].map(
                  (type) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () => setState(() => _filter = type),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: _filter == type
                                ? const Color(0xFFC8A97E)
                                : const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (type == 'drops')
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(
                                    Icons.local_fire_department,
                                    size: 12,
                                    color: _filter == type
                                        ? Colors.black
                                        : const Color(0xFFC8302E),
                                  ),
                                ),
                              Text(
                                type[0].toUpperCase() + type.substring(1),
                                style: TextStyle(
                                  color: _filter == type
                                      ? Colors.black
                                      : Colors.white
                                          .withValues(alpha: 0.6),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),

            // Products grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.58,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: filteredProducts[index],
                    onPress: () => context.push(
                        '/product/${filteredProducts[index].id}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
