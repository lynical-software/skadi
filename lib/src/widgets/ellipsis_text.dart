import 'package:flutter/material.dart';

import '../provider/skadi_provider.dart';

class EllipsisText extends StatelessWidget {
  ///
  final dynamic text;

  ///
  final TextStyle? style;

  ///
  final int? maxLines;

  ///
  final StrutStyle? strutStyle;

  ///
  final TextDirection? textDirection;

  ///
  final TextAlign? textAlign;

  ///
  final Locale? locale;

  ///
  final bool? softWrap;

  ///A text shown when text is null
  final String? emptyText;

  ///Nullable Text with Ellipsis as default overflow
  const EllipsisText(
    this.text, {
    Key? key,
    this.maxLines,
    this.style,
    this.textAlign,
    this.emptyText,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.softWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SkadiProvider? skadiProvider = SkadiProvider.of(context);
    String replacement = emptyText ?? skadiProvider?.ellipsisText ?? "";
    int setMaxLines = maxLines ?? skadiProvider?.ellipsisTextMaxLines ?? 1;
    final s = style ?? const TextStyle();
    return Text(
      text == null ? replacement : text.toString(),
      style: s.copyWith(height: 1.2),
      maxLines: setMaxLines,
      strutStyle: strutStyle,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
