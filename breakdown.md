# Plan: Update Test Cases for `lib/core`

## 1. Overview  
We've refactored `lib/core`—splitting DI modules, adding API module, removing `RegisterModule`—so existing tests under `test/core` are now stale. This plan atomizes the work of aligning tests with the new core structure.

---

## 2. Pre‑Mortem Analysis  
• **If DI modules aren’t tested first →** downstream tests will cascade failures.  
• **If API module test is missing →** network‑client bugs slip through.  
• **If styles/sizes/durations tests aren’t updated →** UI regressions aren’t caught.  

---

## 3. Pareto Focus (80/20)  
Prioritize DI, Routing, and Themes tests—they cover the most shared logic and prevent the largest breakages.

---

## 4. Task Breakdown  

### 4.1 Dependency Injection (DI)  
- [ ] **Remove** `test/core/di/register_module_test.dart` (obsolete)  
- [ ] **Rename & update** to `test/core/di/local_storage_module_test.dart` (done)  
- [ ] **Create** `test/core/di/injection_test.dart`  
  - Assert `configureDependencies()` registers:  
    - `SharedPreferences`  
    - `Dio` from `ApiModule`  
    - Any future feature modules (e.g. `OnboardingModule`)  
- [ ] **Verify** GetIt container resolves each lazySingleton without error  

### 4.2 API Module  
- [ ] **Create** `test/core/di/api_module_test.dart`  
  - Mock network calls via a dummy interceptor  
  - Assert `provideDio()` returns a `Dio` with at least one interceptor  
  - Simulate a request → verify `Logger` is invoked (use a spy or override logger).  

### 4.3 Routing  
- [ ] **Update** `test/core/router/app_router_test.dart`  
  - Replace any old path constants with `routes.dart` constants  
  - Add tests for `AuthGuard` redirect logic (unauthenticated → `/login`)  
  - Assert public routes still open (`'/'`, `'/onboarding'`)  

### 4.4 Styles & Colors  
- [ ] **Update** `test/core/styles/app_colors_impl_test.dart`  
  - If you generated swatches → import generated file and assert one or two shade values  
- [ ] **Create/Update** `test/core/styles/app_text_styles_impl_test.dart`  
  - Assert each `TextStyle` constant is non-null and has expected font size/weight  

### 4.5 Sizes  
- [ ] **Update** `test/core/sizes/app_sizes_impl_test.dart`  
  - If `r(px)` indexer exists → test random px values (e.g. `r(8)`, `r(16)`)  
  - Remove assertions for any removed hard‑coded getters  

### 4.6 Durations  
- [ ] **Update** `test/core/durations/app_durations_impl_test.dart`  
  - Assert each named duration (veryShort/short/medium/long) matches spec  

### 4.7 Themes  
- [ ] **Update** `test/core/themes/app_theme_test.dart`  
  - Pump a `MaterialApp(theme: AppThemeFactory.createLightTheme(...))`  
  - Assert `Theme.of(context).colorScheme.appColors.primary` matches expectation  
- [ ] **Add** test for dark theme factory  

### 4.8 Assets  
- [ ] **Update** `test/core/asset/app_image_test.dart`  
  - Mock a small vs large screen width → assert `AppImage.of(context)` returns correct factory  
  - Test `AppImage.highRes()` path  

---

## 5. CI Validation  
- [ ] After each module’s tests are updated → run `make analyze && make test`  
- [ ] Block PR merges if any core‑test failures occur  

---

## 6. Cross‑Disciplinary Review  
- Pair with a QA engineer to review test completeness  
- Run visual regression for theming and asset scenarios  

---

## 7. Next Steps  
1. Implement DI & API module tests  
2. Update routing tests  
3. Sync styles/sizes/durations/theme tests  
4. Validate asset tests  
5. Merge, then iterate any edge‑case gaps  