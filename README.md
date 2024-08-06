This is a simple cache manager for `cached_s5` libraries.

### Usage

This is a library built on [s5](https://pub.dev/packages/s5). See there for more details.

```dart
CachedS5Manager cacheManager = CachedS5Manager(s5: s5);
final Uint8List bytes = await cacheManager.getBytesFromCID("CID String"); // fetches & caches
cacheManager.clear(); // WARNING: this deletes all locally cached assets
```

### Acknowledgement

This work is supported by a [Sia Foundation](https://sia.tech/) grant
