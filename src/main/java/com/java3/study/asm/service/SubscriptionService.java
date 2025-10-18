package com.java3.study.asm.service;

import com.java3.study.asm.dao.NewsletterDao;
import com.java3.study.asm.dao.impl.NewsletterDaoImpl;
import com.java3.study.asm.entity.Newsletter;
import com.java3.study.asm.utils.EmailSender;

import java.util.List;

/**
 * Service layer để xử lý logic nghiệp vụ cho subscription
 */
public class SubscriptionService {
    
    private final NewsletterDao newsletterDao;
    
    public SubscriptionService() {
        this.newsletterDao = new NewsletterDaoImpl();
    }
    
    /**
     * Đăng ký email nhận thông báo
     * @param email Email người đăng ký
     * @return true nếu đăng ký thành công, false nếu email đã tồn tại
     */
    public boolean subscribe(String email) {
        // Kiểm tra email đã tồn tại chưa
        Newsletter existing = newsletterDao.getByEmail(email);
        
        if (existing != null) {
            // Nếu đã tồn tại nhưng bị vô hiệu hóa, kích hoạt lại
            if (!existing.getEnabled()) {
                existing.setEnabled(true);
                newsletterDao.insert(existing); // Update lại trạng thái
                sendConfirmationEmail(email);
                return true;
            }
            // Email đã đăng ký và đang active
            return false;
        }
        
        // Tạo mới subscription
        Newsletter newsletter = new Newsletter(email, true);
        newsletterDao.insert(newsletter);
        
        // Gửi email xác nhận
        sendConfirmationEmail(email);
        
        return true;
    }
    
    /**
     * Hủy đăng ký nhận thông báo
     * @param email Email cần hủy
     */
    public void unsubscribe(String email) {
        newsletterDao.update(email); // Set enabled = false
    }
    
    /**
     * Lấy tất cả email đang active
     */
    public List<Newsletter> getAllActiveSubscribers() {
        return newsletterDao.getAll()
                .stream()
                .filter(Newsletter::getEnabled)
                .toList();
    }
    
    /**
     * Gửi thông báo tin mới đến tất cả subscribers
     * @param newsTitle Tiêu đề tin tức
     * @param newsUrl URL đến tin tức
     */
    public void notifyNewNews(String newsTitle, String newsUrl) {
        List<Newsletter> activeSubscribers = getAllActiveSubscribers();
        
        System.out.println("Đang gửi thông báo tin mới đến " + activeSubscribers.size() + " subscribers...");
        
        // Gửi email bất đồng bộ trong background thread để không block request
        new Thread(() -> {
            int successCount = 0;
            int failCount = 0;
            
            for (Newsletter subscriber : activeSubscribers) {
                boolean sent = EmailSender.sendNewsNotification(
                    subscriber.getEmail(), 
                    newsTitle, 
                    newsUrl
                );
                
                if (sent) {
                    successCount++;
                } else {
                    failCount++;
                }
                
                // Delay nhỏ giữa các email để tránh spam
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    break;
                }
            }
            
            System.out.println("Hoàn thành gửi thông báo: " + successCount + " thành công, " + failCount + " thất bại");
        }).start();
    }
    
    /**
     * Gửi email xác nhận đăng ký
     */
    private void sendConfirmationEmail(String email) {
        // Gửi trong background thread
        new Thread(() -> {
            boolean sent = EmailSender.sendSubscriptionConfirmation(email);
            if (sent) {
                System.out.println("Đã gửi email xác nhận đến: " + email);
            } else {
                System.err.println("Không thể gửi email xác nhận đến: " + email);
            }
        }).start();
    }
    
    /**
     * Kiểm tra email đã đăng ký chưa
     */
    public boolean isSubscribed(String email) {
        Newsletter newsletter = newsletterDao.getByEmail(email);
        return newsletter != null && newsletter.getEnabled();
    }
}
