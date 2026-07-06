import 'package:flutter/material.dart';
import 'package:shop_app/global_variable.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filers = const [
    "All",
    'Addidas',
    'Nike',
    'Bata',
    'Jordan',
  ];
  late String selectedFilter;
  @override
  void initState() {
    super.initState();
    selectedFilter = filers[0];
  }

  @override
  Widget build(BuildContext context) {
    //comment because i have used listview builder insate of media query
    //final size = MediaQuery.sizeOf(context);
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );

    return SafeArea(
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "Shoes\n Collection",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              itemCount: filers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 242, 242, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      side: BorderSide(
                        color: const Color.fromRGBO(245, 242, 242, 1),
                      ),

                      label: Text(filter),
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 845) {
                  return GridView.builder(
                    itemCount: products.length,

                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsPage(product: product);
                              },
                            ),
                          );
                        },
                        child: ProductCard(
                          title: product['title'] as String,
                          price: product['price'] as double,
                          image: product['imageUrl'] as String,
                          backgroundColor: index.isEven
                              ? const Color.fromRGBO(216, 240, 253, 1)
                              : const Color.fromRGBO(245, 247, 249, 1),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // commented this code because i have used the list view builder
          // Expanded(
          //   child: size.width > 845
          //       ? Expanded(
          //           child: GridView.builder(
          //             itemCount: products.length,

          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //               crossAxisCount: 2,
          //               childAspectRatio: 1.5,
          //             ),
          //             itemBuilder: (context, index) {
          //               final product = products[index];
          //               return GestureDetector(
          //                 onTap: () {
          //                   Navigator.of(context).push(
          //                     MaterialPageRoute(
          //                       builder: (context) {
          //                         return ProductDetailsPage(product: product);
          //                       },
          //                     ),
          //                   );
          //                 },
          //                 child: ProductCard(
          //                   title: product['title'] as String,
          //                   price: product['price'] as double,
          //                   image: product['imageUrl'] as String,
          //                   backgroundColor: index.isEven
          //                       ? const Color.fromRGBO(216, 240, 253, 1)
          //                       : const Color.fromRGBO(245, 247, 249, 1),
          //                 ),
          //               );
          //             },
          //           ),
          //         )
          //       : ListView.builder(
          //           itemCount: products.length,
          //           itemBuilder: (context, index) {
          //             final product = products[index];
          //             return GestureDetector(
          //               onTap: () {
          //                 Navigator.of(context).push(
          //                   MaterialPageRoute(
          //                     builder: (context) {
          //                       return ProductDetailsPage(product: product);
          //                     },
          //                   ),
          //                 );
          //               },
          //               child: ProductCard(
          //                 title: product['title'] as String,
          //                 price: product['price'] as double,
          //                 image: product['imageUrl'] as String,
          //                 backgroundColor: index.isEven
          //                     ? const Color.fromRGBO(216, 240, 253, 1)
          //                     : const Color.fromRGBO(245, 247, 249, 1),
          //               ),
          //             );
          //           },
          //         ),
          // ),
        ],
      ),
    );
  }
}
