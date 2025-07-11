import 'package:flutter/material.dart';
import 'package:flutter_application_2/base/cm_text.dart';

class CommonButton extends StatelessWidget {
  // final Widget child;
  final String textButton;
  final Color? color;
  final double? width;
  final double? height;
  final String? urlImage;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;
  final VoidCallback voidCallback;

  const CommonButton({
    Key? key,
    required this.textButton,
    required this.voidCallback,
    this.color,
    this.width,
    this.height,
    this.urlImage,
    this.borderRadius = 8.0,
    this.padding,
    this.border,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isUrl = false;
    if (urlImage != null) {
      isUrl =
          urlImage!.startsWith('http://') || urlImage!.startsWith('https://');
    }
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Container(
        width: width ?? 160,
        height: height ?? 48,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: BoxDecoration(
          color: color ?? const Color(0xFF16A34A), // Màu xanh lá
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          boxShadow: boxShadow,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (urlImage != null)
              SizedBox(
                width: 25,
                height: 25,
                child: isUrl
                    ? Image.network(
                        urlImage!,
                      )
                    : Image.asset(
                        urlImage!,
                        fit: BoxFit.cover,
                      ),
              ),
            const SizedBox(
              width: 10,
            ),
            CmText(text: textButton),
          ],
        ),
      ),
    );
  }
}
