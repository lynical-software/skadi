import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? readMoreStyle;
  final String readMoreText;
  final String readLessText;
  final int trimLines;
  final ValueChanged<bool>? onLinkTap;

  const ReadMoreText(
    this.text, {
    required this.trimLines,
    this.style,
    this.readMoreStyle,
    this.readMoreText = "Read more",
    this.readLessText = "Read less",
    this.onLinkTap,
    super.key,
  });

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;
  //
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
    widget.onLinkTap?.call(_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final textStyle = defaultTextStyle.style.merge(widget.style);
    final linkStyle =
        widget.readMoreStyle ?? textStyle.copyWith(color: Colors.blue);

    ///
    TextSpan link = TextSpan(
      text: _readMore ? "... " : " ",
      style: textStyle,
      children: [
        TextSpan(
          text: _readMore ? widget.readMoreText : widget.readLessText,
          recognizer: TapGestureRecognizer()..onTap = _onTapLink,
          style: linkStyle.copyWith(decoration: null),
        )
      ],
    );

    //
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(text: widget.text);
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset) ?? 0;
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: textStyle,
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style: textStyle,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
