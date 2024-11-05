import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobdash_it/shared/utils/my_custoum_button.dart';
import 'package:mobdash_it/shared/utils/text_filed.dart';
import 'package:mobdash_it/shared/utils/utils.dart';
import '../../../controller/post_controller.dart';
import '../../color.dart';
import '../../index.dart';

class ServicesUpload extends StatefulWidget {
  const ServicesUpload({super.key});

  @override
  ServicesUploadState createState() => ServicesUploadState();
}

class ServicesUploadState extends State<ServicesUpload> {
  final PostController controller = Get.put(PostController());
  final TextEditingController _name = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();

  final Rx<File?> fileNameValue = Rx<File?>(null);
  final Rx<File?> imageFile = Rx<File?>(null);

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  void _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      final imageFileData = File(pickedFile.path);
      imageFile.value = imageFileData;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kLightSkyBlue,
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: kPadding * 3),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Services name',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MyTextFiled(
                        controller: _name,
                        textFiledType: '',
                        color: kRquoise,
                        height: 65,
                      ),
                      const SizedBox(height: kPadding),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Services price',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MyTextFiled(
                        controller: _price,
                        textFiledType: '',
                        textInputType: TextInputType.number,
                        color: kRquoise,
                        height: 65,
                      ),
                      const SizedBox(height: kPadding),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Services Description',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      MyTextFiled(
                        controller: _description,
                        textFiledType: '',
                        color: kRquoise,
                        height: 120,
                      ),
                      const SizedBox(height: kPadding),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Upload Photo',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Expanded(
                            child: MyCustomButton(
                              onPressed: () {
                                _getImage(ImageSource.gallery);
                              },
                              text: 'Upload Image',
                              fontSize: 11.7,
                              height: 30,
                              radius: kRadius,
                              backgroundColor: kRquoise,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                      Obx(() {
                        return imageFile.value != null
                            ? Padding(
                          padding: const EdgeInsets.only(top: kPadding),
                          child: Text(
                            'Uploaded Photo: ${imageFile.value!.path}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        )
                            : const SizedBox.shrink();
                      }),
                      const SizedBox(height: kPadding),
                    ],
                  ),
                ),
              ),
              MyCustomButton(
                onPressed: () async {
                  final image = imageFile.value;

                  if (image == null) {
                    Utils.showCustomToast(msg: 'Please upload a valid image.');
                    return;
                  }
                  if (kDebugMode) {
                    print('image in view $image');
                  }
                  await controller.createServices(
                    name: _name.text,
                    description: _description.text,
                    price: _price.text,
                    image: image,
                  );
                },
                text: 'Submit',
                fontSize: 16,
                height: 35,
                radius: kRadius,
                backgroundColor: kRquoise,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
