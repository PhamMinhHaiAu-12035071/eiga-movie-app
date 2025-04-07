# Checklist Công Việc: Tính Năng Onboarding

- [ ] **Core**
    - [ ] Cài đặt các thư viện cần thiết: `flutter_bloc`, `get_it`, `injectable`, `hive`, `hive_flutter`, `build_runner` (nếu chưa có).
    - [ ] Cấu hình `hive` trong `main()` hoặc `bootstrap.dart`.
    - [ ] Đăng ký `OnboardingRepository` và `OnboardingCubit` vào hệ thống DI (`lib/core/di/injection.dart` hoặc tương đương) và chạy `build_runner`.

- [ ] **Domain** (`lib/features/onboarding/domain/`)
    - [ ] Tạo model `OnboardingInfo` (`models/onboarding_info.dart`) chứa các thuộc tính: `imagePath` (String), `title` (String), `description` (String).
    - [ ] Định nghĩa interface `IOnboardingRepository` (`repositories/i_onboarding_repository.dart`) với các phương thức:
        - `Future<bool> checkIfOnboardingSeen()`
        - `Future<void> markOnboardingAsSeen()`

- [ ] **Infrastructure** (`lib/features/onboarding/infrastructure/`)
    - [ ] Implement `OnboardingRepository` (`repositories/onboarding_repository_impl.dart`) kế thừa từ `IOnboardingRepository`:
        - Sử dụng `hive` để đọc/ghi giá trị boolean (`_onboardingSeenKey`) vào một Box.
        - Implement `checkIfOnboardingSeen()`: Đọc giá trị từ Hive Box.
        - Implement `markOnboardingAsSeen()`: Ghi giá trị `true` vào Hive Box.

- [ ] **Application** (`lib/features/onboarding/application/`)
    - [ ] Tạo `OnboardingState` (`cubit/onboarding_state.dart`) sử dụng `freezed` (hoặc class thường):
        - `OnboardingInitial`
        - `OnboardingLoadSuccess` (chứa `List<OnboardingInfo>` và `currentPageIndex`)
        - `OnboardingComplete` (trạng thái báo hiệu hoàn thành/skip)
    - [ ] Tạo `OnboardingCubit` (`cubit/onboarding_cubit.dart`) kế thừa từ `Cubit<OnboardingState>`:
        - Inject `IOnboardingRepository`.
        - Tạo danh sách `List<OnboardingInfo>` (tạm thời hardcode hoặc từ file JSON/asset).
        - Implement phương thức `loadOnboardingData()`: Phát ra `OnboardingLoadSuccess` với danh sách slide và index = 0.
        - Implement phương thức `checkIfAlreadySeen()`: Gọi `repository.checkIfOnboardingSeen()`. Nếu `true`, phát ra `OnboardingComplete`. Nếu `false`, gọi `loadOnboardingData()`.
        - Implement phương thức `nextPage(int currentIndex, int totalPages)`:
            - Nếu `currentIndex < totalPages - 1`: Phát ra `OnboardingLoadSuccess` với `currentPageIndex` tăng lên 1.
            - Nếu `currentIndex == totalPages - 1`: Gọi `markAsSeen()` và phát ra `OnboardingComplete`.
        - Implement phương thức `skipOnboarding()`: Gọi `markAsSeen()` và phát ra `OnboardingComplete`.
        - Implement phương thức `markAsSeen()`: Gọi `repository.markOnboardingAsSeen()`.

- [ ] **Presentation** (`lib/features/onboarding/presentation/`)
    - [ ] Tạo widget `OnboardingSlide` (`widgets/onboarding_slide.dart`):
        - Nhận vào `OnboardingInfo`.
        - Hiển thị ảnh (`imagePath`), tiêu đề (`title`), mô tả (`description`).
    - [ ] Tạo `OnboardingPage` (`pages/onboarding_page.dart`):
        - Sử dụng `BlocProvider` để cung cấp `OnboardingCubit`.
        - Sử dụng `BlocConsumer` hoặc `BlocListener` để lắng nghe `OnboardingState`:
            - Khi state là `OnboardingComplete`, điều hướng sang màn hình Home (sử dụng `auto_route` hoặc `Navigator`).
        - Sử dụng `PageView.builder` để hiển thị các `OnboardingSlide` dựa trên `List<OnboardingInfo>` từ state.
        - Lấy `PageController` để theo dõi trang hiện tại.
        - Hiển thị nút `NEXT`:
            - Text thay đổi thành "GET STARTED" hoặc tương tự ở slide cuối.
            - Gọi `cubit.nextPage()` khi nhấn.
        - Hiển thị nút `SKIP`: Gọi `cubit.skipOnboarding()` khi nhấn.
        - Hiển thị thanh chỉ thị (Indicator - có thể dùng package `dots_indicator` hoặc tự vẽ) dựa trên số lượng slide và `currentPageIndex`.
    - [ ] Cập nhật router (`lib/core/router/app_router.dart`) để thêm `OnboardingPage`.
    - [ ] Logic khởi động ứng dụng: Trong màn hình Splash hoặc màn hình đầu tiên, gọi `context.read<OnboardingCubit>().checkIfAlreadySeen()` để quyết định điều hướng vào Onboarding hay Home.

- [ ] **Testing** (`test/features/onboarding/`)
    - [ ] Viết Unit Tests cho `OnboardingRepositoryImpl` (`infrastructure/repositories/onboarding_repository_impl_test.dart`) sử dụng `mocktail` để mock Hive Box.
    - [ ] Viết Unit Tests cho `OnboardingCubit` (`application/cubit/onboarding_cubit_test.dart`) sử dụng `bloc_test` và mock `IOnboardingRepository`.
    - [ ] Viết Widget Tests cho `OnboardingPage` (`presentation/pages/onboarding_page_test.dart`): Mock `OnboardingCubit`, kiểm tra UI hiển thị đúng, tương tác nút NEXT/SKIP.
    - [ ] Viết Widget Tests cho `OnboardingSlide` (`presentation/widgets/onboarding_slide_test.dart`): Kiểm tra hiển thị nội dung.
    - [ ] (Tùy chọn) Viết Integration Test mô phỏng luồng hoàn chỉnh: Mở app -> Thấy Onboarding -> Next/Skip -> Đến Home -> Mở lại app -> Vào thẳng Home.
