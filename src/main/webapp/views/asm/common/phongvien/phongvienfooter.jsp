<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer style="background-color: #333; color: #fff; padding: 40px 0 20px; margin-top: 30px;">
    <div style="max-width: 1200px; margin: 0 auto; display: flex; flex-wrap: wrap; justify-content: space-between; padding: 0 15px;">
        <!-- Về chúng tôi -->
        <div style="flex: 1; min-width: 250px; margin-bottom: 20px; padding: 0 15px;">
            <h3 style="color: #ffd700; margin-bottom: 15px;">${i18n_footerAboutKhoanews}</h3>
            <p>${i18n_footerAboutDesc}</p>
        </div>

        <!-- Liên kết nhanh -->
        <div style="flex: 1; min-width: 150px; margin-bottom: 20px; padding: 0 15px;">
            <h3 style="color: #ffd700; margin-bottom: 15px;">${i18n_footerQuicklinks}</h3>
            <ul style="list-style: none; padding: 0;">
                <li style="margin-bottom: 8px;"><a href="/tin-tuc" style="color: #fff; text-decoration: none;">${i18n_home}</a></li>
                <li style="margin-bottom: 8px;"><a href="/tin-tuc/thoi-su" style="color: #fff; text-decoration: none;">Thời sự</a></li>
                <li style="margin-bottom: 8px;"><a href="/tin-tuc/the-gioi" style="color: #fff; text-decoration: none;">Thế giới</a></li>
                <li style="margin-bottom: 8px;"><a href="/tin-tuc/kinh-te" style="color: #fff; text-decoration: none;">Kinh tế</a></li>
                <li><a href="/tin-tuc/lien-he" style="color: #fff; text-decoration: none;">${i18n_footerContact}</a></li>
            </ul>
        </div>

        <!-- Thông tin liên hệ -->
        <div style="flex: 1; min-width: 250px; margin-bottom: 20px; padding: 0 15px;">
            <h3 style="color: #ffd700; margin-bottom: 15px;">${i18n_footerContact}</h3>
            <p><i class="fas fa-map-marker-alt" style="margin-right: 10px;"></i> ${i18n_footerAddress}</p>
            <p><i class="fas fa-phone" style="margin-right: 10px;"></i> ${i18n_footerPhone}</p>
            <p><i class="fas fa-envelope" style="margin-right: 10px;"></i> ${i18n_footerEmail}</p>
        </div>
    </div>

    <!-- Bản quyền -->
    <div style="text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #555;">
        <p>${i18n_footerCopyright}</p>
    </div>
</footer>