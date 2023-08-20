import 'package:cached_network_image/cached_network_image.dart';
import 'package:shoe_box/constants/constants.dart';
import 'package:shoe_box/screens/Home/product_detail.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  static const String routename = 'home-page';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/icons/amazon-icon.svg',
                height: 20,
              ),
            ),
            IconButton(
              onPressed: () {},
              splashRadius: 20,
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.2, 0.9],
                            colors: [Colors.white, Colors.black],
                          ).createShader(bounds);
                        },
                        child: CarouselSlider.builder(
                          itemCount: Constants.images.length,
                          itemBuilder: (context, index, realIndex) {
                            return CachedNetworkImage(
                              imageUrl: Constants.images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                          options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            autoPlayAnimationDuration: const Duration(milliseconds: 400),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Trending now",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Most searched",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.amber,
                      label: Text(
                        "Trending",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(Constants.images.length, (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const ProductDetailPage();
                            },
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: Constants.images[index],
                                fit: BoxFit.cover,
                                height: 70,
                                width: 70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Brand",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "User's favorite",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(Constants.images.length, (index) {
                    return InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: Constants.images[index],
                                fit: BoxFit.cover,
                                height: 70,
                                width: 70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Brand",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "User's favorite",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(Constants.images.length, (index) {
                    return InkWell(
                      onTap: () {},
                      child: SizedBox(
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                imageUrl: Constants.images[index],
                                fit: BoxFit.cover,
                                height: 70,
                                width: 70,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Brand",
                              style: Theme.of(context).textTheme.labelMedium!,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
