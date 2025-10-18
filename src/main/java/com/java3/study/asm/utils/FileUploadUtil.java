package com.java3.study.asm.utils;

import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

/**
 * Utility class để xử lý upload file
 * Hỗ trợ upload ảnh cho tin tức
 */
public class FileUploadUtil {
    
    // Thư mục lưu trữ ảnh trong webapp
    private static final String UPLOAD_DIR = "images/news";
    
    // Kích thước file tối đa: 5MB
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;
    
    // Các định dạng ảnh được phép
    private static final String[] ALLOWED_EXTENSIONS = {".jpg", ".jpeg", ".png", ".gif", ".webp"};
    
    /**
     * Upload file ảnh và trả về đường dẫn tương đối
     * 
     * @param part Part object từ multipart request
     * @param uploadPath Đường dẫn tuyệt đối đến thư mục webapp
     * @return Đường dẫn tương đối của file đã upload (VD: images/news/abc123.jpg)
     * @throws IOException Nếu có lỗi khi upload
     */
    public static String uploadImage(Part part, String uploadPath) throws IOException {
        
        // Kiểm tra part có null không
        if (part == null || part.getSize() == 0) {
            return null;
        }
        
        // Lấy tên file gốc
        String fileName = getFileName(part);
        if (fileName == null || fileName.isEmpty()) {
            throw new IOException("Không thể lấy tên file");
        }
        
        // Kiểm tra định dạng file
        if (!isValidImageFile(fileName)) {
            throw new IOException("Định dạng file không hợp lệ. Chỉ chấp nhận: " + String.join(", ", ALLOWED_EXTENSIONS));
        }
        
        // Kiểm tra kích thước file
        if (part.getSize() > MAX_FILE_SIZE) {
            throw new IOException("Kích thước file vượt quá giới hạn " + (MAX_FILE_SIZE / 1024 / 1024) + "MB");
        }
        
        // Tạo tên file mới (unique) để tránh trùng lặp
        String fileExtension = getFileExtension(fileName);
        String newFileName = UUID.randomUUID().toString() + fileExtension;
        
        // Tạo đường dẫn đầy đủ
        Path uploadDir = Paths.get(uploadPath, UPLOAD_DIR);
        
        // Tạo thư mục nếu chưa tồn tại
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        
        // Đường dẫn file đích
        Path filePath = uploadDir.resolve(newFileName);
        
        // Copy file từ input stream
        try (InputStream inputStream = part.getInputStream()) {
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
        
        // Trả về đường dẫn tương đối
        return UPLOAD_DIR + "/" + newFileName;
    }
    
    /**
     * Xóa file ảnh cũ khi cập nhật
     * 
     * @param imagePath Đường dẫn tương đối của ảnh (VD: images/news/abc123.jpg)
     * @param uploadPath Đường dẫn tuyệt đối đến thư mục webapp
     */
    public static void deleteImage(String imagePath, String uploadPath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return;
        }
        
        try {
            Path filePath = Paths.get(uploadPath, imagePath);
            Files.deleteIfExists(filePath);
        } catch (IOException e) {
            System.err.println("Lỗi khi xóa file: " + e.getMessage());
        }
    }
    
    /**
     * Lấy tên file từ Part
     */
    private static String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        if (contentDisposition != null) {
            for (String content : contentDisposition.split(";")) {
                if (content.trim().startsWith("filename")) {
                    return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
                }
            }
        }
        return null;
    }
    
    /**
     * Lấy extension của file
     */
    private static String getFileExtension(String fileName) {
        int lastIndexOf = fileName.lastIndexOf(".");
        if (lastIndexOf == -1) {
            return "";
        }
        return fileName.substring(lastIndexOf).toLowerCase();
    }
    
    /**
     * Kiểm tra file có phải là ảnh hợp lệ không
     */
    private static boolean isValidImageFile(String fileName) {
        String extension = getFileExtension(fileName);
        for (String allowedExt : ALLOWED_EXTENSIONS) {
            if (allowedExt.equalsIgnoreCase(extension)) {
                return true;
            }
        }
        return false;
    }
}
