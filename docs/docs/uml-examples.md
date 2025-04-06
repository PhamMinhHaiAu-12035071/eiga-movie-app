---
sidebar_position: 4
title: UML Diagrams
description: Examples of UML diagrams using PlantUML
---

# UML Diagrams with PlantUML

Trang này chứa các ví dụ về sơ đồ UML được vẽ bằng PlantUML và được tích hợp vào Docusaurus.

## Sequence Diagram

Dưới đây là một ví dụ về biểu đồ tuần tự (sequence diagram) mô tả quy trình đăng nhập:

```plantuml
@startuml
actor User
participant "Login Screen" as UI
participant "AuthBloc" as Bloc
participant "LoginUseCase" as UseCase
participant "AuthRepository" as Repo
participant "API Service" as API

User -> UI: Enter credentials
UI -> Bloc: LoginEvent(credentials)
Bloc -> UseCase: call(credentials)
UseCase -> Repo: login(credentials)
Repo -> API: POST /auth/login
API --> Repo: Return token
Repo --> UseCase: Return success
UseCase --> Bloc: Return success
Bloc --> UI: Emit AuthState.authenticated
UI --> User: Show success & redirect
@enduml
```

## Class Diagram

Dưới đây là ví dụ về biểu đồ lớp (class diagram) mô tả các thành phần chính trong module xác thực:

```plantuml
@startuml
package "Domain" {
  interface "AuthRepository" as AuthRepo {
    +login(credentials: AuthCredentials): Either<AuthFailure, AuthToken>
    +register(user: User, password: String): Either<AuthFailure, Unit>
    +getCurrentUser(): Either<AuthFailure, User>
    +logout(): Either<AuthFailure, Unit>
    +isAuthenticated(): bool
  }
  
  class "User" as UserEntity {
    -id: String
    -name: String
    -email: String
    +getName(): String
    +getEmail(): String
  }
  
  class "AuthCredentials" as Credentials {
    -email: String
    -password: String
  }
  
  class "AuthToken" as Token {
    -accessToken: String
    -refreshToken: String
    -expiresAt: DateTime
    +isExpired(): bool
  }
}

package "Application" {
  class "LoginUseCase" as LoginUC {
    -authRepository: AuthRepository
    +call(credentials: AuthCredentials): Either<AuthFailure, AuthToken>
  }
  
  class "AuthBloc" as Bloc {
    -loginUseCase: LoginUseCase
    -registerUseCase: RegisterUseCase
    -logoutUseCase: LogoutUseCase
    +mapEventToState(event: AuthEvent): Stream<AuthState>
  }
}

package "Infrastructure" {
  class "AuthRepositoryImpl" as RepoImpl {
    -apiClient: AuthApiClient
    -secureStorage: SecureStorage
    +login(): Either<AuthFailure, AuthToken>
    +register(): Either<AuthFailure, Unit>
    +getCurrentUser(): Either<AuthFailure, User>
    +logout(): Either<AuthFailure, Unit>
    +isAuthenticated(): bool
  }
  
  class "AuthApiClient" as ApiClient {
    +login(credentials: Map): Response
    +register(userData: Map): Response
    +getUser(token: String): Response
  }
}

package "Presentation" {
  class "LoginPage" as LoginPage {
    +build(): Widget
  }
  
  class "RegisterPage" as RegisterPage {
    +build(): Widget
  }
}

AuthRepo <|.. RepoImpl
LoginUC --> AuthRepo
Bloc --> LoginUC
LoginPage --> Bloc
RegisterPage --> Bloc
RepoImpl --> ApiClient
@enduml
```

## Activity Diagram

Dưới đây là biểu đồ hoạt động (activity diagram) mô tả quy trình xử lý đơn hàng:

```plantuml
@startuml
start
:Nhận đơn hàng mới;
if (Đơn hàng có sẵn hàng?) then (Có)
  :Xác nhận đơn hàng;
  :Chuẩn bị hàng;
  :Đóng gói đơn hàng;
else (Không)
  :Kiểm tra kho;
  if (Có thể nhập thêm?) then (Có)
    :Yêu cầu nhập thêm hàng;
    :Chờ hàng về;
    :Chuẩn bị hàng;
    :Đóng gói đơn hàng;
  else (Không)
    :Thông báo hết hàng;
    :Hủy đơn hàng;
    stop
  endif
endif

:Giao hàng;
:Cập nhật trạng thái đơn hàng;
stop
@enduml
```

## Component Diagram

Dưới đây là biểu đồ thành phần (component diagram) mô tả kiến trúc ứng dụng:

```plantuml
@startuml
package "Presentation Layer" {
  [Pages]
  [Widgets]
  [Router]
}

package "Application Layer" {
  [Blocs]
  [UseCases]
}

package "Domain Layer" {
  [Entities]
  [Repository Interfaces]
}

package "Infrastructure Layer" {
  [Repository Implementations]
  [API Clients]
  [Local Data Sources]
}

package "External Services" {
  [Backend API]
  [Local Storage]
  [Third-party Services]
}

[Pages] --> [Widgets]
[Pages] --> [Blocs]
[Router] --> [Pages]
[Blocs] --> [UseCases]
[UseCases] --> [Repository Interfaces]
[Repository Implementations] --> [Repository Interfaces]
[Repository Implementations] --> [API Clients]
[Repository Implementations] --> [Local Data Sources]
[API Clients] --> [Backend API]
[Local Data Sources] --> [Local Storage]
[API Clients] --> [Third-party Services]
@enduml
```

## Use Case Diagram

Dưới đây là biểu đồ use case mô tả các chức năng chính của người dùng:

```plantuml
@startuml
left to right direction
actor "Người dùng" as User
actor "Admin" as Admin
actor "Hệ thống" as System

rectangle "KSK App" {
  usecase "Đăng nhập" as UC1
  usecase "Đăng ký" as UC2
  usecase "Quản lý đơn hàng" as UC3
  usecase "Tạo đơn hàng mới" as UC4
  usecase "Xem lịch sử đơn hàng" as UC5
  usecase "Quản lý người dùng" as UC6
  usecase "Quản lý sản phẩm" as UC7
  usecase "Gửi thông báo" as UC8
  usecase "Đồng bộ dữ liệu" as UC9
}

User --> UC1
User --> UC2
User --> UC3
User --> UC4
User --> UC5

Admin --> UC1
Admin --> UC6
Admin --> UC7

System --> UC8
System --> UC9

UC3 <.. UC4 : <<include>>
UC3 <.. UC5 : <<include>>
@enduml
```

## ER Diagram

Dưới đây là biểu đồ thực thể quan hệ (ER Diagram) mô tả cơ sở dữ liệu:

```plantuml
@startuml
entity "User" as user {
  * id : UUID <<PK>>
  --
  * name : string
  * email : string
  * password_hash : string
  * created_at : datetime
  * updated_at : datetime
  role : string
}

entity "Order" as order {
  * id : UUID <<PK>>
  --
  * user_id : UUID <<FK>>
  * status : string
  * total : decimal
  * created_at : datetime
  * updated_at : datetime
}

entity "OrderItem" as orderItem {
  * id : UUID <<PK>>
  --
  * order_id : UUID <<FK>>
  * product_id : UUID <<FK>>
  * quantity : integer
  * price : decimal
}

entity "Product" as product {
  * id : UUID <<PK>>
  --
  * name : string
  * description : text
  * price : decimal
  * stock : integer
  * category_id : UUID <<FK>>
  * created_at : datetime
  * updated_at : datetime
}

entity "Category" as category {
  * id : UUID <<PK>>
  --
  * name : string
  * description : text
}

user ||--o{ order : places
order ||--o{ orderItem : contains
product ||--o{ orderItem : included in
category ||--o{ product : belongs to
@enduml
```

## State Diagram

Dưới đây là biểu đồ trạng thái (state diagram) mô tả vòng đời của một đơn hàng:

```plantuml
@startuml
[*] --> Created : Tạo đơn hàng mới

Created --> Confirmed : Xác nhận đơn hàng
Created --> Cancelled : Hủy đơn hàng

Confirmed --> Processing : Bắt đầu xử lý
Confirmed --> Cancelled : Hủy đơn hàng

Processing --> Shipped : Đã gửi hàng
Processing --> Cancelled : Hủy đơn hàng

Shipped --> Delivered : Đã giao hàng
Shipped --> Returned : Trả lại hàng

Delivered --> Returned : Yêu cầu trả hàng
Delivered --> Completed : Hoàn thành đơn hàng

Returned --> Refunded : Hoàn tiền

Cancelled --> [*]
Completed --> [*]
Refunded --> [*]

state Cancelled {
  [*] --> OutOfStock : Hết hàng
  [*] --> CustomerCancelled : Khách hàng hủy
  [*] --> PaymentFailed : Thanh toán thất bại
}
@enduml
```

## Deployment Diagram

Dưới đây là biểu đồ triển khai (deployment diagram) mô tả kiến trúc hệ thống:

```plantuml
@startuml
node "Client Devices" {
  [Mobile App] as mobileApp
  [Web App] as webApp
}

cloud "Cloud Services" {
  node "Google Cloud Platform" {
    node "App Engine" {
      [Backend API Server] as backend
    }
    
    node "Firebase" {
      [Authentication] as auth
      [Cloud Firestore] as firestore
      [Cloud Storage] as storage
      [Cloud Messaging] as messaging
    }
    
    database "Cloud SQL" {
      [PostgreSQL Database] as db
    }
  }
  
  node "Third-party Services" {
    [Payment Gateway] as payment
    [Analytics Service] as analytics
  }
}

mobileApp --> backend : HTTP/REST
mobileApp --> auth : Authentication
mobileApp --> messaging : Push Notifications
webApp --> backend : HTTP/REST
webApp --> auth : Authentication

backend --> db : Persist Data
backend --> firestore : Cache & Real-time Data
backend --> storage : Media Storage
backend --> payment : Process Payments
backend --> analytics : Log Events

@enduml
```

Những ví dụ trên minh họa cách bạn có thể dùng PlantUML để vẽ các loại biểu đồ UML khác nhau trong tài liệu Docusaurus của mình. 