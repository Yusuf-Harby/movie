import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie/core/constants/app_assets.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm({
    required this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    super.key,
    this.onPressed,
    this.onFieldSubmitted,
    this.onChanged,
  });
  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;
  final void Function()? onPressed;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  late bool _isObscure;

  @override
  void initState() {
    _isObscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 15,
      child: TextFormField(
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        cursorHeight: 20,

        obscureText: _isObscure,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        style: Theme.of(context).textTheme.labelMedium,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: widget.onPressed,
            icon: SvgPicture.asset(AppIcons.searchRight),
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}
