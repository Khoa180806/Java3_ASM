package com.java3.study.asm.utils;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Utility class để gửi email sử dụng JavaMail API
 */
public class EmailSender {
    
    // Cấu hình email server - NÊN LƯU TRONG FILE CONFIG HOẶC ENVIRONMENT VARIABLES
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = "khoaphan180806@gmail.com"; // THAY ĐỔI
    private static final String EMAIL_PASSWORD = "cesw phji llll ykbb"; // THAY ĐỔI (sử dụng App Password)
    private static final String FROM_EMAIL = "khoaphan180806@gmail.com"; // THAY ĐỔI
    private static final String FROM_NAME = "Khoa News";
    
    /**
     * Gửi email xác nhận đăng ký
     */
    public static boolean sendSubscriptionConfirmation(String toEmail) {
        String subject = "Xác nhận đăng ký nhận tin từ Khoa News";
        String content = buildConfirmationEmailContent(toEmail);
        return sendEmail(toEmail, subject, content);
    }
    
    /**
     * Gửi thông báo tin tức mới
     */
    public static boolean sendNewsNotification(String toEmail, String newsTitle, String newsUrl) {
        String subject = "Tin mới từ Khoa News: " + newsTitle;
        String content = buildNewsNotificationContent(newsTitle, newsUrl);
        return sendEmail(toEmail, subject, content);
    }
    
    /**
     * Phương thức chính để gửi email
     */
    private static boolean sendEmail(String toEmail, String subject, String htmlContent) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        // Tạo session với authentication
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            Transport.send(message);
            System.out.println("Email đã được gửi thành công đến: " + toEmail);
            return true;
            
        } catch (Exception e) {
            System.err.println("Lỗi khi gửi email đến " + toEmail + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Tạo nội dung HTML cho email xác nhận đăng ký
     */
    private static String buildConfirmationEmailContent(String email) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #667eea 0%%, #764ba2 100%%); 
                              color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
                    .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }
                    .button { display: inline-block; padding: 12px 30px; background: #667eea; 
                              color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }
                    .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>Chào mừng đến với Khoa News!</h1>
                    </div>
                    <div class="content">
                        <h2>Xác nhận đăng ký thành công</h2>
                        <p>Xin chào,</p>
                        <p>Cảm ơn bạn đã đăng ký nhận thông báo tin tức mới nhất từ <strong>Khoa News</strong>!</p>
                        <p>Email của bạn: <strong>%s</strong></p>
                        <p>Từ giờ, bạn sẽ nhận được thông báo mỗi khi chúng tôi đăng tin tức mới.</p>
                        <p>Nếu bạn không thực hiện đăng ký này, vui lòng bỏ qua email này.</p>
                    </div>
                    <div class="footer">
                        <p>&copy; 2025 Khoa News. All rights reserved.</p>
                        <p>Email này được gửi tự động, vui lòng không trả lời.</p>
                    </div>
                </div>
            </body>
            </html>
            """.formatted(email);
    }
    
    /**
     * Tạo nội dung HTML cho email thông báo tin mới
     */
    private static String buildNewsNotificationContent(String newsTitle, String newsUrl) {
        return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <style>
                    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
                    .container { max-width: 600px; margin: 0 auto; padding: 20px; }
                    .header { background: linear-gradient(135deg, #667eea 0%%, #764ba2 100%%); 
                              color: white; padding: 30px; text-align: center; border-radius: 10px 10px 0 0; }
                    .content { background: #f9f9f9; padding: 30px; border-radius: 0 0 10px 10px; }
                    .news-title { font-size: 20px; color: #667eea; margin: 20px 0; }
                    .button { display: inline-block; padding: 12px 30px; background: #667eea; 
                              color: white; text-decoration: none; border-radius: 5px; margin: 20px 0; }
                    .footer { text-align: center; margin-top: 20px; color: #666; font-size: 12px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <div class="header">
                        <h1>📰 Tin mới từ Khoa News</h1>
                    </div>
                    <div class="content">
                        <h2>Chúng tôi vừa đăng tin mới!</h2>
                        <div class="news-title">%s</div>
                        <p>Nhấn vào nút bên dưới để đọc toàn bộ bài viết:</p>
                        <a href="%s" class="button">Đọc ngay</a>
                        <p style="margin-top: 30px; font-size: 12px; color: #666;">
                            Nếu nút không hoạt động, copy link sau vào trình duyệt:<br>
                            <a href="%s">%s</a>
                        </p>
                    </div>
                    <div class="footer">
                        <p>&copy; 2025 Khoa News. All rights reserved.</p>
                        <p>Bạn nhận email này vì đã đăng ký nhận thông báo từ Khoa News.</p>
                    </div>
                </div>
            </body>
            </html>
            """.formatted(newsTitle, newsUrl, newsUrl, newsUrl);
    }
}
