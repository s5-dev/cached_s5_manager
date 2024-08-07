import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:s5/s5.dart';
import 'package:universal_io/io.dart';

class CachedS5Manager {
  final S5 s5;
  Directory? cacheDir;
  CachedS5Manager({required this.s5});
  // TODO: Add max cache size

  /// Initializes the cache dir, nothing else will work unless you do this first.
  Future<void> init() async {
    cacheDir = Directory(
        join((await getApplicationCacheDirectory()).path, "cid-cache"));
    await cacheDir?.create(recursive: true);
  }

  /// Given a [compliant](https://docs.sfive.net/spec/blobs.html) CID string, it fetches and
  /// caches that assets.
  /// NOTE: Because of limitations, this will skip the caching section if
  /// it is running from the web
  Future<Uint8List> getBytesFromCID(String cid) async {
    // check for local existance of the file
    if (!kIsWeb) {
      try {
        // only inits if cache dir is empty
        (cacheDir == null || !cacheDir!.existsSync()) ? await init() : null;
        File cidCache = await getCacheFile(cid);
        if (cidCache.existsSync()) {
          return cidCache.readAsBytesSync();
        } else {
          final Uint8List cidContents =
              await s5.api.downloadRawFile(CID.decode(cid).hash);
          if (cidContents.isNotEmpty) {
            await cidCache.writeAsBytes(cidContents);
            return cidContents;
          }
        }
      } catch (e) {
        print(e);
      }
    }
    // if not, return the web fetched version
    return s5.api.downloadRawFile(CID.decode(cid).hash);
  }

  /// Given a [compliant](https://docs.sfive.net/spec/blobs.html) CID string, it fetches and
  /// caches that assets.
  /// NOTE: Because of limitations, this will NOT WORK on web
  Future<File?> getFileFromCID(String cid) async {
    // check for local existance of the file
    if (!kIsWeb) {
      try {
        // only inits if cache dir is empty
        (cacheDir == null || !cacheDir!.existsSync()) ? await init() : null;
        File cidCache = await getCacheFile(cid);
        if (cidCache.existsSync()) {
          return cidCache;
        } else {
          final Uint8List cidContents =
              await s5.api.downloadRawFile(CID.decode(cid).hash);
          if (cidContents.isNotEmpty) {
            await cidCache.writeAsBytes(cidContents);
            return cidCache;
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      throw UnimplementedError();
    }
    return null;
  }

  /// Grabs the local cache file.
  Future<File> getCacheFile(String cid) async {
    if (cacheDir != null) {
      return File(join(cacheDir!.path, cid));
    } else {
      await init();
      return File(join(cacheDir!.path, cid));
    }
    // TODO: Add automatic cache prune based on max size & oldest files
  }

  /// This deletes the entire local cache.
  Future<void> clear() async {
    await cacheDir?.delete(recursive: true);
  }

  // TODO: Add stat function to see full size
}
