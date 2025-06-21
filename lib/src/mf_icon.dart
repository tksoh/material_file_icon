import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_file_icon/src/file_icons.dart';

/// A widget that displays an icon based on the file name or extension.
class MFIcon extends StatelessWidget {
  /// Creates a widget that displays an icon based on the file name or extension.
  const MFIcon(
    this.fileName, {
    super.key,
    this.size,
    this.color,
    this.placeholder = const Icon(Icons.insert_drive_file),
  });
  final String fileName;
  final double? size;
  final Color? color;
  final Widget placeholder;

  @override
  Widget build(BuildContext context) {
    final mediaType = getType(fileName);
    if (mediaType == null) return placeholder;

    final cf = color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null;
    return SvgPicture.asset(
      'packages/material_file_icon/assets/icons/$mediaType.svg',
      width: size,
      height: size,
      placeholderBuilder: (_) => placeholder,
      colorFilter: cf,
    );
  }

  /// Get the media type by file name or extension.
  static String? getType(String fileName) {
    try {
      if (getTypeByFileName(fileName) case var icon?) return icon;
      return getTypeByExtension(fileName.split('.').last);
    } catch (_) {
      return null;
    }
  }

  static final _nameCache = <String, String>{};

  /// Get the media type by file name.
  static String? getTypeByFileName(String fileName) {
    if (_nameCache[fileName] case var name?) return name;

    for (final map in kIcons) {
      final names = map['fileNames'] as List<String>? ?? [];

      for (final name in names) {
        if (name.toLowerCase() == fileName.toLowerCase()) {
          _nameCache[fileName] = map['name'].toString();
        }
      }
    }

    return null;
  }

  static final _extCache = <String, String>{};

  /// Get the media type by file extension.
  static String? getTypeByExtension(String extension) {
    if (_extCache[extension] case var name?) return name;

    for (final map in kIcons) {
      final extensions = map['fileExtensions'] as List<String>? ?? [];

      for (final ext in extensions) {
        if (ext.toLowerCase() == extension.toLowerCase()) {
          final icon = map['name'].toString();
          _extCache[extension] = icon;
          return icon;
        }
      }
    }

    return null;
  }
}
