# tridivya_spritual_wellness_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

## Sprint 3 — Clean Architecture & Hive Auth (what I implemented)

This project was updated to follow a feature-based Clean Architecture layout and adds a local authentication flow backed by Hive (Hive DB).

Summary of changes:

- Added Hive service + constants (`lib/core/services/hive/hive_service.dart`, `lib/core/constants/hive_table_constant.dart`).
- Implemented Auth feature using Clean Architecture:
  - Domain: `features/auth/domain` (entities, repositories, usecases)
  - Data: `features/auth/data` (Hive model, datasource, repository)
  - Presentation: `features/auth/presentation` (view model, pages)
- Added routing using `AppRouter` and centralized routes in `lib/app/routes/app_router.dart`.
- Tests:
  - Unit/in-memory tests: `test/features/auth/auth_repository_test.dart`
  - Hive integration test: `test/features/auth/hive_integration_test.dart`
- CI/analysis: project is analyzer-clean and tests pass locally.

### Setup / developer notes

1. Install packages:

```bash
flutter pub get
```

2. Generate Hive adapters (only if you modify hive models):

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Run tests:

```bash
flutter test
```

4. On first run ensure Hive is initialized in `main.dart` (already wired to call `HiveService().init()`);
   during testing a temp directory is used so it won't contaminate your production DB.

---

If you want, I can now push the final cleanup & docs commit to `sprint-three` (I already pushed earlier commits 1–9). Reply `push` to approve or `hold` to review locally first.
