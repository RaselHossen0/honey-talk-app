import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
import 'package:tingle/utils/color.dart';
import 'package:tingle/utils/utils.dart';

class FullScreenPostPreview extends StatefulWidget {
  // final List<PostPreviewModel> posts;
  final List<PostImage?> posts;
  final int initialIndex;

  const FullScreenPostPreview({
    super.key,
    required this.posts,
    required this.initialIndex,
  });

  @override
  State<FullScreenPostPreview> createState() => _FullScreenPostPreviewState();
}

class _FullScreenPostPreviewState extends State<FullScreenPostPreview> {
  late PageController _controller;
  // int currentPage = 0;
  num currentPage = 0;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
    currentPage = widget.initialIndex;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.posts.length,
            onPageChanged: (value) {
              currentPage = value;
              setState(() {});
            },
            itemBuilder: (context, index) {
              final post = widget.posts[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: post!.url!,
                    width: Get.width,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                      color: AppColor.primary,
                      strokeWidth: 2.0,
                      backgroundColor: AppColor.white,
                    )),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                  // const SizedBox(height: 16),
                  16.height
                ],
              );
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: AppColor.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            bottom: 40,
            // left: 20,
            left: 0,
            right: 0,
            child: DotsIndicator(
              dotsCount: widget.posts.length,
              position: currentPage.toDouble(),
              decorator: DotsDecorator(
                color: AppColor.white,
                activeColor: AppColor.primary,
                size: const Size.square(8.0),
                activeSize: const Size(15.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Model for Post Preview
class PostPreviewModel {
  final String imageUrl;
  final String username;
  final String description;

  PostPreviewModel({
    required this.imageUrl,
    required this.username,
    required this.description,
  });
}
