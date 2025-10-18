package com.java3.study.asm.utils;

import jakarta.servlet.http.HttpServletRequest;
import com.java3.study.asm.controller.LanguageServlet;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;

/**
 * I18nUtils - Utility class for internationalization (i18n)
 * Provides methods to get localized messages based on current language
 * Uses caching for better performance
 */
public class I18nUtils {
    
    // Cache for properties files
    private static final ConcurrentHashMap<String, Properties> propertiesCache = new ConcurrentHashMap<>();
    
    // Properties file paths
    private static final String PROPERTIES_PATH = "/language/asm_language/global_%s.properties";
    
    // Supported languages
    private static final String VIETNAMESE = "vi";
    private static final String ENGLISH = "en";
    
    /**
     * Get localized message by key for current language in request
     * @param request HttpServletRequest to get current language
     * @param key Message key
     * @return Localized message or key if not found
     */
    public static String getMessage(HttpServletRequest request, String key) {
        String language = LanguageServlet.getCurrentLanguage(request);
        return getMessage(language, key);
    }
    
    /**
     * Get localized message by key for specific language
     * @param language Language code (vi or en)
     * @param key Message key
     * @return Localized message or key if not found
     */
    public static String getMessage(String language, String key) {
        if (key == null || key.trim().isEmpty()) {
            return "";
        }
        
        Properties properties = getProperties(language);
        if (properties != null) {
            String message = properties.getProperty(key);
            if (message != null) {
                return message;
            }
        }
        
        // Fallback: return key if message not found
        return key;
    }
    
    /**
     * Get localized message with parameters
     * @param request HttpServletRequest to get current language
     * @param key Message key
     * @param params Parameters to replace in message
     * @return Formatted localized message
     */
    public static String getMessage(HttpServletRequest request, String key, Object... params) {
        String message = getMessage(request, key);
        if (params != null && params.length > 0) {
            return String.format(message, params);
        }
        return message;
    }
    
    /**
     * Get Properties object for specific language with caching
     * @param language Language code
     * @return Properties object or null if not found
     */
    private static Properties getProperties(String language) {
        // Validate language
        if (!VIETNAMESE.equals(language) && !ENGLISH.equals(language)) {
            language = VIETNAMESE; // Default to Vietnamese
        }
        
        // Check cache first
        Properties properties = propertiesCache.get(language);
        if (properties != null) {
            return properties;
        }
        
        // Load properties file
        properties = loadProperties(language);
        if (properties != null) {
            // Cache the properties
            propertiesCache.put(language, properties);
        }
        
        return properties;
    }
    
    /**
     * Load properties file from classpath
     * @param language Language code
     * @return Properties object or null if error
     */
    private static Properties loadProperties(String language) {
        String filePath = String.format(PROPERTIES_PATH, language);
        
        try (InputStream inputStream = I18nUtils.class.getResourceAsStream(filePath)) {
            if (inputStream != null) {
                Properties properties = new Properties();
                // Load with UTF-8 encoding
                try (InputStreamReader reader = new InputStreamReader(inputStream, StandardCharsets.UTF_8)) {
                    properties.load(reader);
                }
                return properties;
            }
        } catch (IOException e) {
            System.err.println("Error loading properties file: " + filePath);
            e.printStackTrace();
        }
        
        return null;
    }
    
    /**
     * Clear properties cache (useful for development)
     */
    public static void clearCache() {
        propertiesCache.clear();
    }
    
    /**
     * Get current language display name
     * @param request HttpServletRequest
     * @return Language display name
     */
    public static String getCurrentLanguageDisplayName(HttpServletRequest request) {
        String language = LanguageServlet.getCurrentLanguage(request);
        return VIETNAMESE.equals(language) ? "Tiếng Việt" : "English";
    }
    
    /**
     * Get opposite language code (for language switcher)
     * @param request HttpServletRequest
     * @return Opposite language code
     */
    public static String getOppositeLanguage(HttpServletRequest request) {
        String language = LanguageServlet.getCurrentLanguage(request);
        return VIETNAMESE.equals(language) ? ENGLISH : VIETNAMESE;
    }
    
    /**
     * Get opposite language display name (for language switcher)
     * @param request HttpServletRequest
     * @return Opposite language display name
     */
    public static String getOppositeLanguageDisplayName(HttpServletRequest request) {
        String oppositeLanguage = getOppositeLanguage(request);
        return VIETNAMESE.equals(oppositeLanguage) ? "Tiếng Việt" : "English";
    }
    
    /**
     * Get language flag text (avoiding emoji encoding issues)
     * @param language Language code
     * @return Flag text
     */
    public static String getLanguageFlag(String language) {
        return VIETNAMESE.equals(language) ? "VI" : "EN";
    }
}
