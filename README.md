This is a simple cache manager for `cached_s5` libraries.

Ex:

```dart
CachedS5Manager cacheManager = CachedS5Manager();
cacheManager.init(); // IMPORTANT: all other functions will silently fail if you forget this
cacheManager.clearCache(); // WARNING: this deletes all locally cached assets
```
