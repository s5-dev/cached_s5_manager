## 1.2.3

- chore: specify webs support in pubspec

## 1.2.2

- fix: make sure init() is skipped on web to not get unimplemented errors

## 1.2.1

- Add check to make sure cacheDir exists before creating CID file.

## 1.2.0

- Add function `getFileFromCID` for larger files that shouldn't be handled in memory.

## 1.1.0

- Remove redundant arguments in `getBytesFromCID`.

## 1.0.0

- Migrate to downloading from S5 directly in this codebase with `getBytesFromCID`
- Refactor `clearCache()` to `clear()`.

## 0.0.2

- Update metadata.

## 0.0.1

- Initial version.
