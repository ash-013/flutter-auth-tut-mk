import 'package:flutter/material.dart';

class CustomTexfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Icon prefixIcon;
  const CustomTexfield(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.obscureText,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        cursorColor: Theme.of(context).colorScheme.primary,
        controller: controller,
        obscureText: obscureText,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.surface,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w300,
              fontStyle: FontStyle.normal),
        ),
      ),
    );
  }
}
