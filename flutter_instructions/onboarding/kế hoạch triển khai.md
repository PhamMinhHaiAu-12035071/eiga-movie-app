**Tính năng: Onboarding**

## 1. Domain Layer
- **Model:** `OnboardingInfo` (chứa thông tin cho mỗi slide: ảnh, tiêu đề, mô tả).
- **Repository Interface:** `IOnboardingRepository` với:
  - `checkIfOnboardingSeen()` (trả về bool).
  - `markOnboardingAsSeen()` (lưu cờ đã xem).

## 2. Application Layer
- **OnboardingCubit & OnboardingState:**
  - Quản lý danh sách slide (tạm thời hardcode hoặc tải từ file JSON).
  - **Logic xử lý nút `Next`:**
    - Nếu chưa đến slide cuối: chuyển sang slide tiếp theo.
    - Nếu ở slide cuối: gọi `markOnboardingAsSeen()` và điều hướng tới màn hình Home.
  - **Logic xử lý nút `Skip`:**
    - Gọi `markOnboardingAsSeen()` và chuyển đến Home.
  - **Kiểm tra trạng thái:** Khi khởi động ứng dụng, gọi `checkIfOnboardingSeen()`:
    - Nếu đã xem, đi thẳng vào Home.
    - Nếu chưa, hiển thị Onboarding.

## 3. Infrastructure Layer
- **OnboardingRepository:** Cụ thể hóa `IOnboardingRepository` sử dụng một giải pháp lưu trữ cục bộ (ví dụ: `hive`).
  - `checkIfOnboardingSeen()`: Đọc trạng thái (boolean) từ bộ nhớ cục bộ.
  - `markOnboardingAsSeen()`: Ghi giá trị `true` vào bộ nhớ cục bộ.
- *Lưu ý:* Có thể đồng bộ hoá với backend nếu cần cập nhật nội dung động trong tương lai.

## 4. Presentation Layer
- **OnboardingPage:**
  - Sử dụng `PageView` để quản lý các slide.
  - Hiển thị thanh chỉ thị (Indicator) theo số lượng slide và vị trí hiện tại.
  - Nút `NEXT` và `SKIP` kích hoạt các hành động trong `OnboardingCubit`.
- **OnboardingSlide:**
  - Hiển thị nội dung chi tiết: ảnh minh họa, tiêu đề, mô tả.
  - Tùy chọn hiển thị logo hoặc các thành phần bổ sung theo thiết kế.
- **Điều hướng:**
  - Lắng nghe trạng thái từ `OnboardingCubit`; khi hoàn thành, điều hướng sang Home.

## 5. Testing
- **Unit Tests:**
  - `OnboardingCubit`: Kiểm tra logic xử lý (next, skip, checkSeen).
  - `OnboardingRepository`: Đảm bảo việc đọc/ghi trạng thái chính xác.
- **Widget Tests:**
  - `OnboardingPage` và `OnboardingSlide`: Đảm bảo giao diện hiển thị đúng và nút nhấn hoạt động.
- **Integration Tests:**
  - Mô phỏng toàn bộ luồng Onboarding:
    - Mở app lần đầu -> hiển thị Onboarding.
    - Nhấn `Next` qua các slide -> chuyển sang Home.
    - Nhấn `Skip` -> chuyển sang Home.
    - Mở app lần thứ hai -> trực tiếp vào Home.
