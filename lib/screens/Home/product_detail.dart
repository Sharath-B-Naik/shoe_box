import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import 'data.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: Constants.images.first,
                  ),
                ),
              ],
            ),
            _detailWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.orange,
        label: Row(
          children: [
            const Text(
              "Add to cart",
            ),
            const SizedBox(width: 20),
            Icon(Icons.shopping_basket, color: Theme.of(context).floatingActionButtonTheme.backgroundColor),
          ],
        ),
      ),
    );
  }

  Widget _detailWidget() {
    return DraggableScrollableSheet(
      maxChildSize: .8,
      initialChildSize: .4,
      minChildSize: .4,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(bottom: 0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("NIKE AIR MAX 200"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "\$ ",
                            ),
                            Text(
                              "240",
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.star, color: Colors.yellow, size: 17),
                            Icon(Icons.star, color: Colors.yellow, size: 17),
                            Icon(Icons.star, color: Colors.yellow, size: 17),
                            Icon(Icons.star, color: Colors.yellow, size: 17),
                            Icon(Icons.star_border, size: 17),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Available Size",
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      10,
                      (index) => Chip(label: Text("${index + 5}")),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Available Color",
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ...[
                      Colors.yellow,
                      Colors.lightBlue,
                      Colors.black,
                      Colors.red,
                      Colors.blueAccent,
                    ].map(
                      (item) => _colorWidget(item, isSelected: true),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(AppData.description * 5),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _colorWidget(Color color, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: CircleAvatar(
        radius: 12,
        backgroundColor: color.withOpacity(0.3),
        child: Icon(isSelected ? Icons.check_circle : Icons.circle, color: color, size: 18),
      ),
    );
  }
}
