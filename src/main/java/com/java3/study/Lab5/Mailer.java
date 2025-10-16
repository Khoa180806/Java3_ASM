package com.java3.study.Lab5;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class Mailer {
    public static boolean send(String from, String to, String subject, String body) {
        // Thông số kết nối GMail
        Properties props = new Properties();
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.host", "smtp.gmail.com");
        props.setProperty("mail.smtp.port", "587");
// Đăng nhập GMail
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                String username = "khoaphan180806@gmail.com";
                String password = "jfyb dsqg vngk gcay";
                return new PasswordAuthentication(username, password);
            }
        });
        try {
            // Tạo mail
            MimeMessage mail = new MimeMessage(session);
            mail.setFrom(new InternetAddress(from));
            mail.setRecipients(Message.RecipientType.TO, to);
            mail.setSubject(subject, "utf-8");
            mail.setText(body, "utf-8", "html");
            mail.setReplyTo(mail.getFrom());
            // Gửi mail
            Transport.send(mail);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
