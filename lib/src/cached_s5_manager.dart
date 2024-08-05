import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_io/io.dart';

class CachedS5Manager {
  Directory? cacheDir;
  CachedS5Manager();
  // TODO: Add max cache size

  /// Initializes the cache dir, nothing else will work unless you do this first.
  Future<void> init() async {
    cacheDir = Directory(
        join((await getApplicationCacheDirectory()).path, "cid-cache"));
    await cacheDir?.create(recursive: true);
  }

  /// Given a [compliant](https://docs.sfive.net/spec/blobs.html) CID string, it will fetch that
  /// asset and then cache it locally.
  File? getCacheFile(String cid) {
    if (cacheDir != null) {
      return File(join(cacheDir!.path, cid));
    } else {
      return null;
    }
    // TODO: Add automatic cache prune based on max size & oldest files
  }

  /// This deletes the entire local cache.
  Future<void> clearCache() async {
    await cacheDir?.delete(recursive: true);
  }

  // TODO: Add stat function to see full size
}
