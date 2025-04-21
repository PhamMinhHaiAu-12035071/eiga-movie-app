# Task Breakdown: Onboarding Feature - Landscape Layout Support

## Overview
**Goal:** Refactor the existing `onboarding` feature's **presentation layer** to support both portrait and landscape orientations using `flutter_screenutil`. Create a new landscape layout based on the visual elements of the provided portrait screenshot.

**❗ Key Constraints:**
-   **Scope:** This update focuses **exclusively** on adapting the UI layout for different orientations. **No changes** should be made to the existing business logic (`application/cubit`), data handling (`infrastructure`), domain models (`domain`), or navigation (`core/router`).
-   **Backward Compatibility:** The existing portrait layout is functioning correctly. This refactor **must ensure** the portrait view remains **exactly the same** visually and functionally after the changes. Regression testing for the portrait view is crucial.

## 1. Refactor Existing Presentation Layer (`lib/features/onboarding/presentation/`)

-   **Task 1.1: Create Base Onboarding Page Structure**
    -   Modify `onboarding_page.dart`.
    -   Implement `ScreenUtilInit` at the appropriate level if not already done (likely in `app.dart` or `main_*.dart`).
    -   In the `build` method of `OnboardingPage`, use `ScreenUtil().orientation` to determine the current orientation.
    -   Create placeholders for two new widgets: `OnboardingPortraitView` and `OnboardingLandscapeView`.
    -   Conditionally render `OnboardingPortraitView` or `OnboardingLandscapeView` based on the detected orientation.

-   **Task 1.2: Extract Portrait Logic**
    -   Create a new file: `presentation/widgets/onboarding_portrait_view.dart`.
    -   Define a `StatelessWidget` named `OnboardingPortraitView`.
    -   Move all existing UI code from the current `OnboardingPage`'s `build` method (which handles the portrait layout) into the `build` method of `OnboardingPortraitView`.
    -   Ensure `OnboardingPortraitView` receives any necessary state or callbacks from `OnboardingPage` (e.g., Cubit state, button press handlers).
    -   Update `OnboardingPage` to use `OnboardingPortraitView` when in portrait mode.

## 2. Implement Landscape Layout (`lib/features/onboarding/presentation/widgets/`)

-   **Task 2.1: Design Landscape Layout Analysis**
    -   Analyze the portrait screenshot elements: Large icon in a circle, "EIGA" title, "CINEMA UI KIT." subtitle, "ONBOARDING" title, description text, page indicator dots, "Next" button, "Skip" button.
    -   Plan the landscape layout: Suggestion: Use a `Row`. Left side: Icon in a circle. Right side: Stacked column with Titles, Description, Page Indicator, Buttons. Ensure responsive spacing using `ScreenUtil` (.w, .h, .sp).

-   **Task 2.2: Create Landscape View Widget**
    -   Create a new file: `presentation/widgets/onboarding_landscape_view.dart`.
    -   Define a `StatelessWidget` named `OnboardingLandscapeView`.
    -   Ensure it receives the same state/callbacks as `OnboardingPortraitView`.

-   **Task 2.3: Implement Landscape Left Column (Icon)**
    -   In `OnboardingLandscapeView`, start with a `Row`.
    -   Add the icon component (same as in portrait) to the left side of the `Row`. Use `ScreenUtil` for sizing and padding appropriate for landscape. Consider using `Expanded` or fixed width (`.w`).

-   **Task 2.4: Implement Landscape Right Column (Text & Controls)**
    -   Add a `Column` or `Expanded` widget to the right side of the `Row`.
    -   Add the "EIGA", "CINEMA UI KIT.", "ONBOARDING" titles, and description text. Use `ScreenUtil` for font sizes (`.sp`) and spacing (`.h`). Ensure text alignment and wrapping are appropriate.
    -   Add the page indicator dots. Use `ScreenUtil` for sizing and spacing.
    -   Add the "Next" and "Skip" buttons. Use `ScreenUtil` for button sizing, padding, and font sizes. Arrange them appropriately (e.g., in a `Row` or `Column` at the bottom of the right side).

-   **Task 2.5: Integrate Landscape View**
    -   Update `OnboardingPage` to use the newly created `OnboardingLandscapeView` when in landscape mode.

## 3. State Management & Logic (`lib/features/onboarding/application/cubit/`)

-   **Task 3.1: Review Onboarding Cubit/State (No Changes Expected)**
    -   Check `onboarding_cubit.dart` and `onboarding_state.dart`.
    -   Verify if any state properties or logic are specific to the portrait layout. (Unlikely, but good to check).
    -   Ensure the existing Cubit provides all necessary data (e.g., current page index, total pages) for both layouts.
    -   **Crucial:** **Do not modify** the Cubit logic. This task is for verification only.

## 4. Testing

-   **Task 4.1: Update Existing Widget Tests & Add Regression Tests**
    -   Review widget tests for `OnboardingPage`.
    -   Update tests to account for the new structure (checking for `OnboardingPortraitView` or `OnboardingLandscapeView` based on simulated orientation).
    -   **Add specific regression tests** for the `OnboardingPortraitView` to ensure it renders **identically** to the previous implementation under various conditions and screen sizes (simulated in portrait).
    -   Use testing utilities to simulate different screen sizes and orientations for both views.

-   **Task 4.2: Write Widget Test for `OnboardingPortraitView`**
    -   Create `onboarding_portrait_view_test.dart`.
    -   Write tests to verify all UI elements render correctly with mock data/state.
    -   Test button interactions if any logic resides directly within this widget.

-   **Task 4.3: Write Widget Test for `OnboardingLandscapeView`**
    -   Create `onboarding_landscape_view_test.dart`.
    -   Write tests to verify all UI elements render correctly in the landscape arrangement with mock data/state.
    -   Test element positioning and responsiveness (using different simulated screen sizes) specifically for the **landscape layout**.
    -   Test button interactions in the landscape view.

## 5. Documentation & Cleanup

-   **Task 5.1: Add Code Comments**
    -   Add `///` comments to the new widgets (`OnboardingPortraitView`, `OnboardingLandscapeView`) explaining their purpose.
    -   Comment on the orientation switching logic in `OnboardingPage`.
-   **Task 5.2: Update Feature README**
    -   If `features/onboarding/README.md` exists, update it to mention the support for both orientations.
-   **Task 5.3: Code Review & Formatting**
    -   Run `dart format .`
    -   Run `flutter analyze` to catch any issues.
    -   Perform a self-review or peer review focusing on layout consistency and responsiveness.