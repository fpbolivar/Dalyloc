import 'package:flutter/material.dart';

Widget customDropdownButton({
  required DropdownButton dropdownButton,
  required String? title,
  required String? description,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Title
      // (title != null)
      //     ? Text(title,
      //         style: TextStyle(
      //           fontSize: 14,
      //           color: Colors.grey,
      //           fontWeight: FontWeight.w400,
      //         ))
      //     : const SizedBox(),
      // SizedBox(height: (title != null) ? 4 : 0),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.grey),
          color: Colors.white,
        ),
        child: dropdownButton,
      ),
      // Description
      // (description == null)
      //     ? const SizedBox()
      //     : Text(
      //         description,
      //         style: TextStyle(
      //           fontSize: 11,
      //           color: Colors.grey,
      //           fontWeight: FontWeight.w400,
      //         ),
      //       ),
    ],
  );
}
