import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobdash_it/controller/post_controller.dart';
import 'package:mobdash_it/shared/color.dart';
import 'package:mobdash_it/shared/index.dart';
import 'package:mobdash_it/shared/utils/my_custoum_button.dart';
import '../shared/view/Cells/hardware_cell.dart';
import '../shared/view/Cells/services_cell.dart';
import '../shared/view/Cells/software_cell.dart';
import '../shared/view/uploads/hardware_upload.dart';
import '../shared/view/uploads/services_upload.dart';
import '../shared/view/uploads/software_upload.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _postController = Get.find<PostController>(tag: 'postController');
  final softWare = true.obs;
  final hardWere = false.obs;
  final services = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kLightSkyBlue,
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              const SizedBox(height: kPadding * 3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: MyCustomButton(
                      onPressed: () {
                        softWare.value = true;
                        hardWere.value = false;
                        services.value = false;
                        _postController.getPosts(postType: 'software');
                      },
                      text: 'Software',
                      fontSize: 14,
                      height: 30,
                      radius: kRadius,
                      backgroundColor: kRquoise,
                    ),
                  ),
                  const SizedBox(width: kPadding),
                  Expanded(
                    child: MyCustomButton(
                      onPressed: () {
                        softWare.value = false;
                        hardWere.value = true;
                        services.value = false;
                        _postController.getPosts(postType: 'hardware');
                      },
                      text: 'Hardware',
                      fontSize: 14,
                      height: 30,
                      radius: kRadius,
                      backgroundColor: kRquoise,
                    ),
                  ),
                  const SizedBox(width: kPadding),
                  Expanded(
                    child: MyCustomButton(
                      onPressed: () {
                        softWare.value = false;
                        hardWere.value = false;
                        services.value = true;
                        _postController.getServices();
                      },
                      text: 'Services',
                      fontSize: 14,
                      height: 30,
                      radius: kRadius,
                      backgroundColor: kRquoise,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: kPadding),
                      Obx(() {
                        if (softWare.value) {
                          return software();
                        } else if (hardWere.value) {
                          return hardware();
                        } else if (services.value) {
                          return servicesWidget();
                        } else {
                          return Container();
                        }
                      }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget software() {
    return Column(
      children: [
        MyCustomButton(
          onPressed: () {
            Get.to(() => const SoftwareUpload());
          },
          text: 'Upload Project',
          fontSize: 14,
          height: 30,
          radius: kRadius,
          backgroundColor: kRquoise,
        ),
        const SizedBox(height: kPadding),
        Obx(() {
          final posts = _postController.posts;
          if (posts.isEmpty) {
            return const Center(child: Text('No software posts available.'));
          }
          final reversedPosts = posts.reversed.toList();
          return Column(
            children: reversedPosts
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final post = entry.value;
              final id = entry.value.id;
              return Column(
                children: [
                  SoftwareCell(
                    id: id,
                    name: post.title,
                    file: post.attatchmentUrl,
                    desc: post.description ?? '',
                    image: post.imagePath,
                  ),
                  if (index < reversedPosts.length - 1) const SizedBox(height: kPadding),
                ],
              );
            }
            ).toList(),
          );
        }
        ),
      ],
    );
  }

  Widget hardware() {
    return Column(
      children: [
        MyCustomButton(
          onPressed: () {
            Get.to(() => const HardwareUpload());
          },
          text: 'Upload Item',
          fontSize: 14,
          height: 30,
          radius: kRadius,
          backgroundColor: kRquoise,
        ),
        const SizedBox(height: kPadding),
        Obx(() {
          final posts = _postController.posts;
          if (posts.isEmpty) {
            return const Center(child: Text('No hardware posts available.'));
          }
          final reversedPosts = posts.reversed.toList();
          return Column(
            children: reversedPosts
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final post = entry.value;
              final id = entry.value.id;
              return Column(
                children: [
                  HardwareCell(
                    id: id,
                    name: post.title,
                    desc: post.description ?? '',
                    file: post.attatchmentUrl,
                    image: post.imagePath,
                    price: post.price.toString(),
                  ),
                  if (index < reversedPosts.length - 1) const SizedBox(height: kPadding),
                ],
              );
            }
            ).toList(),
          );
        }
        ),
      ],
    );
  }

  Widget servicesWidget() {
    return Column(
      children: [
        MyCustomButton(
          onPressed: () {
            Get.to(() => const ServicesUpload());
          },
          text: 'Offer Service',
          fontSize: 14,
          height: 30,
          radius: kRadius,
          backgroundColor: kRquoise,
        ),
        const SizedBox(height: kPadding),
        Obx(() {
          final posts = _postController.posts;
          if (posts.isEmpty) {
            return const Center(child: Text('No services posts available.'));
          }
          final reversedPosts = posts.reversed.toList();
          return Column(
            children: reversedPosts
                .asMap()
                .entries
                .map((entry) {
              final index = entry.key;
              final post = entry.value;
              final id = entry.value.id;
              return Column(
                children: [
                  ServicesCell(
                    id: id,
                    name: post.title,
                    desc: post.description ?? '',
                    file: post.attatchmentUrl,
                    image: post.imagePath,
                    price: post.price.toString(),
                  ),
                  if (index < reversedPosts.length - 1) const SizedBox(height: kPadding),
                ],
              );
            }
            ).toList(),
          );
        }
        ),
      ],
    );
  }
}
