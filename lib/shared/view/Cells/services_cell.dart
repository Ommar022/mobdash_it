import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/post_controller.dart';
import '../../../controller/user_controller.dart';
import '../../color.dart';
import '../../index.dart';
import '../../utils/my_custoum_button.dart';

class ServicesCell extends StatefulWidget {
  final String name;
  final String price;
  final String desc;
  final String image;
  final String file;
  final int id;

  const ServicesCell({
    super.key,
    required this.name,
    required this.desc,
    required this.image,
    required this.price,
    required this.file,
    required this.id,
  });

  @override
  _ServicesCellState createState() => _ServicesCellState();
}

class _ServicesCellState extends State<ServicesCell> {

  final _user = Get.find<UserController>(tag: 'userController');
  final _post = Get.find<PostController>(tag: 'postController');

  int _rating = 0;

  void _submitRating() {
    if (_rating == 0 ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    _post.rating(
      // comment: _commentController.text,
      // image: imageFile,
      productId: widget.id,
      userId: _user.user.value?.id ?? 1,
      rating: _rating,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rating submitted successfully')),
    );

    setState(() {
      _rating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kRquoise,
        borderRadius: BorderRadius.circular(kRadius / 1.8),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.image,
              height: 170,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: kPadding / 2),
            Padding(
              padding: const EdgeInsets.all(kPadding / 2),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: kPadding / 2),
                      Text(
                        '${widget.price}\$',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kPadding / 2),
                  Text(
                    widget.desc,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: kPadding / 2),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                index < _rating ? Icons.star : Icons.star_border,
                                color: Colors.amber,
                              ),
                              onPressed: () {
                                setState(() {
                                  _rating = index + 1;
                                });
                              },
                            );
                          }),
                        ),
                        const SizedBox(height: kPadding / 2),
                        MyCustomButton(
                          onPressed: _submitRating,
                          text: 'Add',
                          fontSize: 14,
                          height: 30,
                          radius: kRadius,
                          backgroundColor: kLightSkyBlue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
