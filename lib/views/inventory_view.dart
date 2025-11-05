import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/product_controller.dart';
import '../services/product_service.dart';
import '../models/product_model.dart';
import '../core/layout/responsive_scaffold.dart';
import '../core/utils/responsive_helper.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({super.key});

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  final nameCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  int _currentIndex = 1;

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
    if (index == 0) Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductController(),
      child: Consumer<ProductController>(
        builder: (context, controller, _) {
          final isDesktop = ResponsiveHelper.isDesktop(context);
          final padding = ResponsiveHelper.horizontalPadding(context);

          return ResponsiveScaffold(
            title: 'Gestión de Inventario',
            currentIndex: _currentIndex,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SizedBox(
                        width: isDesktop ? 200 : double.infinity,
                        child: TextField(
                            controller: nameCtrl,
                            decoration:
                                const InputDecoration(labelText: 'Nombre')),
                      ),
                      SizedBox(
                        width: isDesktop ? 120 : double.infinity,
                        child: TextField(
                            controller: qtyCtrl,
                            decoration:
                                const InputDecoration(labelText: 'Cantidad')),
                      ),
                      SizedBox(
                        width: isDesktop ? 150 : double.infinity,
                        child: TextField(
                            controller: priceCtrl,
                            decoration:
                                const InputDecoration(labelText: 'Precio')),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final name = nameCtrl.text.trim();
                          final qty = int.tryParse(qtyCtrl.text.trim()) ?? 0;
                          final price =
                              double.tryParse(priceCtrl.text.trim()) ?? 0.0;

                          if (name.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Debes escribir un nombre de producto')),
                            );
                            return;
                          }

                          final p = ProductService.createNew(name, qty, price);
                          controller.addProduct(p);

                          nameCtrl.clear();
                          qtyCtrl.clear();
                          priceCtrl.clear();
                        },
                        child: const Text('Agregar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (context, i) {
                        final p = controller.products[i];
                        return Card(
                          child: ListTile(
                            title: Text(p.name),
                            subtitle: Text(
                                'Cantidad: ${p.quantity} | Precio: \$${p.price.toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => controller.removeProduct(p.id),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
