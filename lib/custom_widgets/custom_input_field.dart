import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../constants/color_const.dart';
import '../utils/common_style.dart';

/// 1
class CustomInputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool suffixIcon;
  final bool? isDense;
  final Widget? prefixIcon;

  final bool obscureText;
  TextInputType? keyboardType;
  final TextEditingController? controller;

  CustomInputField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.validator,
      this.keyboardType,

      this.suffixIcon = false,
      this.isDense,
      this.prefixIcon,
      this.controller,
      this.obscureText = false})
      : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width * 0.99,
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: CommonStyle.black12Bold()),
          ),
          SizedBox(
            height: 2.sp,
          ),
          Container(
            height: 33.sp,
            child: TextFormField(
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              style: CommonStyle.black12Normal(),
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                hintStyle: CommonStyle.grey12Normal(),
                hintText: widget.hintText,
                suffixIcon: widget.suffixIcon
                    ? IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.remove_red_eye
                              : Icons.visibility_off_outlined,
                          color: AppColor.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
                prefixIcon: widget.prefixIcon,
                contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColor.primary),
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: BorderSide(width: 2, color: AppColor.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: BorderSide(width: 1, color: AppColor.primary),
                ),
              ),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}

///2

class CustomInputField2 extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? isDense;
  final bool? readOnly;
  final Widget? prefixIcon;
  final bool obscureText;
  final int? maxLines;
  void Function()? onTap;
  TextInputType? keyboardType;
  final TextEditingController? controller;

  CustomInputField2(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.validator,
      this.keyboardType,
      this.maxLines,
      this.suffixIcon,
      this.isDense,
      this.readOnly,
      this.prefixIcon,
      this.controller,
      this.onTap,
      this.obscureText = false})
      : super(key: key);

  @override
  State<CustomInputField2> createState() => _CustomInputField2State();
}

class _CustomInputField2State extends State<CustomInputField2> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width * 0.99,
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.labelText, style: CommonStyle.black12Bold()),
          ),
          SizedBox(
            height: 2.sp,
          ),
          Container(
            height: widget.maxLines != null ? null : 33.sp,
            child: TextFormField(
              readOnly: widget.readOnly ?? false,
              maxLines: widget.maxLines ?? 1,
              onTap: widget.onTap,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              style: CommonStyle.black12Normal(),
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                hintStyle: CommonStyle.grey12Normal(),
                // isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                // suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                //     maxHeight: 33
                // ): null,
                contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColor.primary),
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: BorderSide(width: 2, color: AppColor.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.sp)),
                  borderSide: BorderSide(width: 1, color: AppColor.primary),
                ),
              ),
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}

///3

class CustomInputFieldSearch extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? isDense;
  final bool? readOnly;
  final Widget? prefixIcon;
  final bool obscureText;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
   final void Function()? onTap;
  final TextEditingController? controller;

  CustomInputFieldSearch(
      {Key? key,
      required this.labelText,
      required this.hintText,
      this.validator,
      this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.isDense,
      this.readOnly,
      this.onChanged,
      this.prefixIcon,
      this.controller,
      this.obscureText = false})
      : super(key: key);

  @override
  State<CustomInputFieldSearch> createState() => _CustomInputFieldSearchState();
}

class _CustomInputFieldSearchState extends State<CustomInputFieldSearch> {
  //
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width * 0.99,
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: [
          Container(
            height: 33.sp,
            child: TextFormField(
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              controller: widget.controller,
              readOnly: widget.readOnly!,
              onTap: widget.onTap,
              style: CommonStyle.black12Normal(),
              obscureText: (widget.obscureText && _obscureText),
              decoration: InputDecoration(
                hintStyle: CommonStyle.grey12Normal(),
                // isDense: (widget.isDense != null) ? widget.isDense : false,
                hintText: widget.hintText,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                // suffixIconConstraints: (widget.isDense != null) ? const BoxConstraints(
                //     maxHeight: 33
                // ): null,
                contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: AppColor.primary),
                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                  borderSide: BorderSide(width: 2, color: AppColor.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                  borderSide: BorderSide(width: 1, color: AppColor.primary),
                ),
              ),
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
