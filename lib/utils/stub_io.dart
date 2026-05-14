// // Stub for dart:io on Flutter Web.
// // Provides just enough API surface for the code to compile on web.
// // All methods throw UnimplementedError at runtime, but they are guarded
// // by `kIsWeb` checks and will never actually be called on web.

// class File {
//   File(String path);
//   Future<File> writeAsBytes(List<int> bytes, {bool flush = false}) =>
//       throw UnimplementedError('dart:io File is not available on web');
// }

// class Directory {
//   Directory(String path);
//   String get path => throw UnimplementedError();
//   Future<bool> exists() => Future.value(false);
//   Future<Directory> create({bool recursive = false}) =>
//       throw UnimplementedError();
// }

// abstract class Platform {
//   static bool get isAndroid => false;
//   static bool get isIOS => false;
//   static bool get isWindows => false;
//   static bool get isLinux => false;
//   static bool get isMacOS => false;
//   static bool get isFuchsia => false;
// }
