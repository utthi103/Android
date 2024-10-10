import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class realtimedatabase extends StatefulWidget {
  const realtimedatabase({super.key});

  @override
  State<realtimedatabase> createState() => _RealtimeDatabaseState();
}

final databaseRf = FirebaseDatabase.instance.ref("product");
final ImagePicker _imagePicker = ImagePicker();

class _RealtimeDatabaseState extends State<realtimedatabase> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  String? imgUrl; // Biến để lưu URL của hình ảnh đã chọn

  Future<void> pickImage() async {
    try {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (res != null) {
        // Tải lên hình ảnh và cập nhật imgUrl
        imgUrl = await uploadImageToFirebase(File(res.path));
        setState(() {}); // Cập nhật UI
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error picking image: $e"),
        ),
      );
    }
  }

  Future<String?> uploadImageToFirebase(File image) async {
    try {
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("images/${DateTime.now().microsecondsSinceEpoch}.png");

      // Tải lên file ảnh
      await reference.putFile(image);

      // Lấy URL của ảnh đã tải lên
      return await reference
          .getDownloadURL(); // Lưu URL hình ảnh vào biến imgUrl
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Fail to upload image: $e"),
        ),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Data of Shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseRf,
              itemBuilder: (context, snapshot, animation, index) {
                String? imageUrl = snapshot.child("image").value?.toString();
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          imageUrl != null ? NetworkImage(imageUrl) : null,
                      child: imageUrl == null
                          ? const Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.grey,
                            )
                          : null,
                    ),
                    title: Text(
                      snapshot.child("name").value.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.child("category").value.toString()),
                        Text(
                          'Giá: ${snapshot.child("price").value.toString()} VND',
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Mở dialog edit
                            nameController.text =
                                snapshot.child("name").value.toString();
                            priceController.text =
                                snapshot.child("price").value.toString();
                            categoryController.text =
                                snapshot.child("category").value.toString();
                            imgUrl = snapshot
                                .child("image")
                                .value
                                ?.toString(); // Đặt URL hình ảnh

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return myDialog(
                                  context: context,
                                  name: "Update Product",
                                  address: "Update",
                                  onPressed: () async {
                                    // Chọn ảnh mới
                                    await pickImage();

                                    // Cập nhật sản phẩm
                                    await databaseRf
                                        .child(snapshot
                                            .child("id")
                                            .value
                                            .toString())
                                        .update({
                                      'category':
                                          categoryController.text.toString(),
                                      'image': imgUrl, // Cập nhật URL hình ảnh
                                      'name': nameController.text.toString(),
                                      'price': priceController.text.toString(),
                                    });

                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Product'),
                                  content: const Text(
                                      'Are you sure you want to delete this product?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        databaseRf
                                            .child(snapshot
                                                .child("id")
                                                .value
                                                .toString())
                                            .remove();
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nameController.clear();
          categoryController.clear();
          priceController.clear();
          imgUrl = null; // Reset imgUrl khi thêm sản phẩm
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return myDialog(
                context: context,
                name: "Add Product",
                address: "Add",
                onPressed: () async {
                  if (imgUrl != null) {
                    final id = DateTime.now().microsecondsSinceEpoch.toString();
                    // Lưu sản phẩm vào Firebase Realtime Database
                    await databaseRf.child(id).set({
                      'category': categoryController.text.toString(),
                      'image': imgUrl, // Lưu URL hình ảnh
                      'name': nameController.text.toString(),
                      'price': priceController.text.toString(),
                      'id': id
                    });
                    Navigator.pop(context);
                  } else {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor: Colors.red,
                    //     content: const Text("Please select an image!"),
                    //   ),
                    // );
                  }
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Dialog myDialog({
    required BuildContext context,
    required String name,
    required String address,
    required VoidCallback onPressed,
  }) {
    return Dialog(
      backgroundColor: Colors.blue[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                CircleAvatar(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ),
              ],
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Enter Product Name",
                hintText: "e.g., Dell",
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: "Enter Product Price",
                hintText: "1200000",
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Enter Category",
                hintText: "e.g., Laptop",
              ),
            ),
            GestureDetector(
              onTap: () {
                pickImage(); // Gọi hàm chọn hình ảnh
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.blue,
                size: 30,
              ),
            ),
            // Hiển thị hình ảnh nếu có
            if (imgUrl != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Image.network(
                  imgUrl!,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(address),
            ),
          ],
        ),
      ),
    );
  }
}
