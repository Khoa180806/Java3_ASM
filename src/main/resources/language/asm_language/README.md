# Hệ thống Internationalization (i18n) - Khoa News

## Tổng quan

Hệ thống i18n cho phép ứng dụng Khoa News hỗ trợ đa ngôn ngữ (Tiếng Việt và English) với Jakarta EE.

## Cấu trúc Files

```
src/main/
├── java/com/java3/study/asm/
│   ├── controller/
│   │   ├── LanguageServlet.java          # Xử lý chuyển đổi ngôn ngữ
│   │   └── I18nDemoServlet.java          # Demo servlet
│   ├── filter/
│   │   └── LanguageFilter.java           # Filter tự động set i18n attributes
│   └── utils/
│       └── I18nUtils.java                # Utility class cho i18n
├── resources/language/asm_language/
│   ├── global_vi.properties              # Text tiếng Việt
│   ├── global_en.properties              # Text tiếng Anh
│   └── README.md                         # File này
└── webapp/views/asm/
    ├── common/
    │   └── language-switcher.jsp         # Component chuyển đổi ngôn ngữ
    └── i18n-demo.jsp                     # Trang demo i18n
```

## Cách sử dụng

### 1. Trong Servlet

```java
// Import
import com.java3.study.asm.controller.LanguageServlet;
import com.java3.study.asm.utils.I18nUtils;

// Lấy ngôn ngữ hiện tại
String currentLanguage = LanguageServlet.getCurrentLanguage(request);

// Kiểm tra ngôn ngữ
boolean isVietnamese = LanguageServlet.isVietnamese(request);
boolean isEnglish = LanguageServlet.isEnglish(request);

// Lấy message từ properties
String message = I18nUtils.getMessage(request, "message.key");

// Lấy message với parameters
String userMessage = I18nUtils.getMessage(request, "user.welcome", userName);
```

### 2. Trong JSP

```jsp
<%-- Sử dụng attributes được set tự động bởi LanguageFilter --%>
<h1>${i18n_appName}</h1>
<p>${i18n_appSlogan}</p>

<%-- Kiểm tra ngôn ngữ --%>
<c:if test="${isVietnamese}">
    <p>Nội dung tiếng Việt</p>
</c:if>
<c:if test="${isEnglish}">
    <p>English content</p>
</c:if>

<%-- Include language switcher --%>
<%@ include file="common/language-switcher.jsp" %>
```

### 3. Chuyển đổi ngôn ngữ

```html
<!-- Link chuyển sang tiếng Việt -->
<a href="${pageContext.request.contextPath}/language?lang=vi&redirect=${pageContext.request.requestURI}">
    🇻🇳 Tiếng Việt
</a>

<!-- Link chuyển sang English -->
<a href="${pageContext.request.contextPath}/language?lang=en&redirect=${pageContext.request.requestURI}">
    🇺🇸 English
</a>
```

## URL Structure

- `GET /language?lang=vi&redirect=<url>` - Chuyển sang tiếng Việt
- `GET /language?lang=en&redirect=<url>` - Chuyển sang English
- `GET /i18n-demo` - Trang demo i18n

## Properties Keys

### Application
- `app.name` - Tên ứng dụng
- `app.slogan` - Slogan ứng dụng

### Common Actions
- `common.home` - Trang chủ
- `common.news` - Tin tức
- `common.login` - Đăng nhập
- `common.logout` - Đăng xuất
- `common.create` - Tạo mới
- `common.edit` - Chỉnh sửa
- `common.delete` - Xóa
- `common.save` - Lưu
- `common.cancel` - Hủy

### Roles
- `role.admin` - Quản trị viên
- `role.reporter` - Phóng viên
- `role.reader` - Đọc giả

### News
- `news.title` - Tiêu đề
- `news.content` - Nội dung
- `news.author` - Tác giả
- `news.category` - Danh mục

### Users
- `user.username` - Tên đăng nhập
- `user.fullname` - Họ và tên
- `user.email` - Email
- `user.gender` - Giới tính

### Messages
- `message.save.success` - Lưu thành công
- `message.save.failed` - Lưu thất bại
- `message.no.data` - Không có dữ liệu

## Tính năng

1. **Session-based Language Persistence** - Ngôn ngữ được lưu trong session
2. **Auto-redirect** - Tự động redirect về trang hiện tại sau khi chuyển ngôn ngữ
3. **UTF-8 Encoding** - Hỗ trợ đầy đủ UTF-8
4. **Caching** - Cache properties files để tăng performance
5. **Fallback Mechanism** - Fallback về key nếu không tìm thấy message
6. **Filter Integration** - Tự động set attributes cho mọi request

## Mở rộng

### Thêm ngôn ngữ mới

1. Tạo file properties mới: `global_<language_code>.properties`
2. Cập nhật `LanguageServlet` để hỗ trợ language code mới
3. Cập nhật `language-switcher.jsp` để thêm option mới

### Thêm properties key mới

1. Thêm key vào cả `global_vi.properties` và `global_en.properties`
2. Cập nhật `LanguageFilter` nếu muốn set attribute tự động
3. Sử dụng trong JSP hoặc Servlet

## Test

- Truy cập `/i18n-demo` để test hệ thống
- Thử chuyển đổi ngôn ngữ và kiểm tra các message
- Kiểm tra session persistence bằng cách refresh trang

## Lưu ý

- Luôn set encoding UTF-8 trong servlet và JSP
- Sử dụng `LanguageFilter` để tự động set attributes
- Properties files phải có encoding UTF-8
- Test kỹ trước khi deploy production
