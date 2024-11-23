import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_lab_test/app_colors.dart';
import 'package:flutter_app_lab_test/app_url.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();

  // TextEditingControllers for text fields
  TextEditingController txtProductName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtCategoryID = TextEditingController();
  TextEditingController txtBarcode = TextEditingController();
  TextEditingController txtExpiredDate = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  TextEditingController txtUnitPriceIn = TextEditingController();
  TextEditingController txtUnitPriceOut = TextEditingController();

  Future<void> _createProduct({
    required String productName,
    required String description,
    required String categoryID,
    required String barcode,
    required String expiredDate,
    required String qty,
    required String unitPriceIn,
    required String unitPriceOut,
  }) async {
    var uri = Uri.parse("${AppUrl.url}insert_product.php");
    EasyLoading.show(status: 'Creating...');
    await Future.delayed(const Duration(seconds: 1));
    final response = await http.post(uri, body: {
      'ProductName': productName,
      'Description': description,
      'CategoryID': categoryID,
      'Barcode': barcode,
      'ExpiredDate': expiredDate,
      'Qty': qty,
      'UnitPriceIn': unitPriceIn,
      'UnitPriceOut': unitPriceOut,
    });
    if (!mounted) return;
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final data = jsonDecode(response.body);
      if (data['success'] == 1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${data['msg_success']}"),
          ),
        );
        // Clear the form fields upon success
        txtProductName.clear();
        txtDescription.clear();
        txtCategoryID.clear();
        txtBarcode.clear();
        txtExpiredDate.clear();
        txtQty.clear();
        txtUnitPriceIn.clear();
        txtUnitPriceOut.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${data['msg_error']}"),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to connect to server."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Product'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtProductName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Product Name!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtDescription,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Description!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtCategoryID,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category ID',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Category ID!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtBarcode,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Barcode',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Barcode!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtExpiredDate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date (YYYY-MM-DD)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Expired Date!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtQty,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Quantity!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtUnitPriceIn,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unit Price In',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Unit Price In!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: txtUnitPriceOut,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Unit Price Out',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required Unit Price Out!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 56,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createProduct(
                        productName: txtProductName.text.trim(),
                        description: txtDescription.text.trim(),
                        categoryID: txtCategoryID.text.trim(),
                        barcode: txtBarcode.text.trim(),
                        expiredDate: txtExpiredDate.text.trim(),
                        qty: txtQty.text.trim(),
                        unitPriceIn: txtUnitPriceIn.text.trim(),
                        unitPriceOut: txtUnitPriceOut.text.trim(),
                      );
                    }
                  },
                  child: const Text(
                    'Create Product',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
