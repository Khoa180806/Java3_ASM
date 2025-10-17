package com.java3.study.asm.utils;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

public class UploadFileHelper {
    
    private static final String[] ALLOWED_EXTENSIONS = {"jpg", "jpeg", "png", "gif", "webp"};
    
    /**
     * Upload file to server and return the relative path
     * @param filePart The file part from the request
     * @param uploadPath The absolute path to the upload directory
     * @param uploadDir The relative path for URL generation
     * @return The relative path of the uploaded file or null if upload failed
     */
    public static String uploadFile(Part filePart, String uploadPath, String uploadDir) {
        try {
            // Create upload directory if it doesn't exist
            File uploadDirFile = new File(uploadPath);
            if (!uploadDirFile.exists()) {
                uploadDirFile.mkdirs();
            }
            
            // Get file information
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Validate file extension
            if (!isValidExtension(fileName)) {
                return null;
            }
            
            // Generate unique file name
            String fileExtension = getFileExtension(fileName);
            String newFileName = UUID.randomUUID().toString() + "." + fileExtension;
            
            // Save file to server
            Path filePath = Paths.get(uploadPath, newFileName);
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, filePath, StandardCopyOption.REPLACE_EXISTING);
            }
            
            // Return the relative path for database storage
            return uploadDir + "/" + newFileName;
            
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Check if the file has a valid extension
     */
    private static boolean isValidExtension(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return false;
        }
        
        String fileExtension = getFileExtension(fileName).toLowerCase();
        
        for (String ext : ALLOWED_EXTENSIONS) {
            if (ext.equalsIgnoreCase(fileExtension)) {
                return true;
            }
        }
        
        return false;
    }
    
    /**
     * Get file extension from file name
     */
    private static String getFileExtension(String fileName) {
        if (fileName == null || fileName.lastIndexOf(".") == -1) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
    
    /**
     * Delete a file from the server
     * @param filePath The absolute path to the file
     * @return true if deletion was successful, false otherwise
     */
    public static boolean deleteFile(String filePath) {
        if (filePath == null || filePath.trim().isEmpty()) {
            return false;
        }
        
        try {
            Path path = Paths.get(filePath);
            return Files.deleteIfExists(path);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
