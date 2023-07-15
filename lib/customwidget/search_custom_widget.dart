import 'package:flutter/material.dart';

import '../presentation/resources/style_manager.dart';
class SearchCustomWidget extends StatelessWidget {
  const SearchCustomWidget({
    this.onChanged,
    Key? key,
    this.searchController,
  }) : super(key: key);
final Function(String)? onChanged;
final TextEditingController? searchController;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: StyleManger.headline2(fontSize: 16),
      cursorColor: Colors.black,
      keyboardType: TextInputType.text,
      onChanged:onChanged ,
      controller: searchController,
      decoration: InputDecoration(
          hintText: 'ابحث باسم الخدمة المطلوبة',
          hintStyle: StyleManger.headline2(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.search,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          prefixIconColor: Colors.grey,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )),
    );
  }
}
