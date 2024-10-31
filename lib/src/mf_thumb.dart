import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';

import '../material_file_icon.dart';

/// A widget that shows a thumbnail of a file.
///
/// It attempts to read the file as image and then uses [MFIcon] to show the
/// file icon.
class MFThumb extends StatefulWidget {
  /// Creates a widget that shows a thumbnail of a file.
  const MFThumb(
    this.file, {
    super.key,
    this.size,
    this.color,
    this.placeholder = const Icon(Icons.insert_drive_file),
  });
  final XFile file;
  final double? size;
  final Color? color;
  final Widget placeholder;

  @override
  State<MFThumb> createState() => _MFThumbState();
}

class _MFThumbState extends State<MFThumb> {
  late final _future = widget.file.readAsBytes();

  Widget get _fileIcon => MFIcon(
        widget.file.name,
        size: widget.size,
        color: widget.color,
        placeholder: widget.placeholder,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 20,
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return _fileIcon;

          return Image.memory(
            snapshot.data!,
            errorBuilder: (_, e, s) => _fileIcon,
          );
        },
      ),
    );
  }
}
