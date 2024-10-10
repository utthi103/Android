import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class realtimedatabase extends StatefulWidget {
  const realtimedatabase({super.key});

  @override
  State<realtimedatabase> createState() => _RealTimedatabaseState();
}

final databaseRf = FirebaseDatabase.instance.ref("product");

class _RealTimedatabaseState extends State<realtimedatabase> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Data of shop",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
            query: databaseRf,
            itemBuilder: (context, snapshot, animation, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.child("image_url").value.toString()),
                    child: snapshot.child("image_url").value == null
                        ? Text((index + 1).toString())
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
                        'Giá: ${snapshot.child("price").value.toString()} VND', // Thêm đơn vị tiền tệ ở đây
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
// Thay thế PopupMenuButton bằng Row trong trailing của ListTile
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Mở dialog edit
                          nameController.text =
                              snapshot.child("name").value.toString();
                          priceController.text =
                              snapshot.child("price").value.toString();
                          categoryController.text =
                              snapshot.child("category").value.toString();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return mydialog(
                                context: context,
                                name: "Update product",
                                address: "Update",
                                onPressed: () {
                                  databaseRf
                                      .child(
                                          snapshot.child("id").value.toString())
                                      .update({
                                    'category':
                                        categoryController.text.toString(),
                                    'image': "sahd",
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
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Hiển thị hộp thoại xác nhận trước khi xóa
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Product'),
                                content: const Text(
                                    'Are you sure you want to delete this product?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Cancel'),
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
                                    child: Text('Delete'),
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
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nameController.clear();
          categoryController.clear();
          imagController.clear();
          priceController.clear();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return mydialog(
                  context: context,
                  name: "Add product",
                  address: "Add",
                  onPressed: () {
                    final id = DateTime.now().microsecondsSinceEpoch.toString();
                    databaseRf.child(id).set({
                      'category': categoryController.text.toString(),
                      'image': "sahd",
                      'name': nameController.text.toString(),
                      'price': priceController.text.toString(),
                      'id': id
                    });
                    Navigator.pop(context);
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Dialog mydialog({
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
                labelText: "Enter name product",
                hintText: "eg. Dell",
              ),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: "Enter price product",
                hintText: "1200000",
              ),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Enter category",
                hintText: "eg. Máy tính",
              ),
            ),
            // TextField(
            //   controller: addressController,
            //   decoration: const InputDecoration(
            //     labelText: "Enter the Address",
            //     hintText: "eg. NewYork",
            //   ),
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(address),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
