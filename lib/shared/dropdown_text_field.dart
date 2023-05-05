import 'package:canteen_owner_app/core/constants/app_fonts.dart';
import 'package:canteen_owner_app/model/category_model.dart';
import 'package:flutter/material.dart';

class DropDownTextField<T> extends StatelessWidget {
  const DropDownTextField({
    super.key,
    required this.hintText,
    required this.options,
    required this.value,
    required this.onChanged,
  });

  final String hintText;
  final List<CategoryModel> options;
  final CategoryModel? value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 5),
      constraints: const BoxConstraints(minHeight: 54),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 1,
          )
        ],
      ),
      child: Center(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<CategoryModel>(
            isDense: false,
            isExpanded: true,
            hint: Text(
              hintText,
              style: AppFonts.kFont12ptGrey,
            ),
            underline: const SizedBox(),
            //selected value
            value: value,
            //onchanged function
            onChanged: (value) =>onChanged(value),
            borderRadius: BorderRadius.circular(10),
            elevation: 2,
            items: options.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.categoryName ??''),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
