# Changelog

## 0.4.0
* Fixed invalid retrieval of media file names.
* Added missing homepage, repository & topics in `pubspec.yaml`. 

Thanks to Satoshi Ogata.

## 0.3.0
* Added `MFThumb` that tries to load an image thumbnail from a [XFile] and fallbacks to `MFIcon`.

## 0.2.0
* Added `MFIcon.placeholder` in case the media type is not found.
* Exposed `MFIcon.getType`, `MFIcon.getTypeByExtension`, `MFIcon.getTypeByFileName` static methods.
* Now caches the media type of the file for better performance.

## 0.1.0

* Initial release.
