package com.java3.study.asm.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;

import com.java3.study.asm.controller.LanguageServlet;
import com.java3.study.asm.utils.I18nUtils;

import java.io.IOException;

/**
 * LanguageFilter - Filter để tự động khởi tạo ngôn ngữ và set attributes cho JSP
 * Chạy trước mọi request để đảm bảo i18n attributes luôn có sẵn
 */
@WebFilter("/*")
public class LanguageFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        
        // Set character encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        // Get current language
        String currentLanguage = LanguageServlet.getCurrentLanguage(httpRequest);
        
        // Set language attributes for JSP
        request.setAttribute("currentLanguage", currentLanguage);
        request.setAttribute("isVietnamese", LanguageServlet.isVietnamese(httpRequest));
        request.setAttribute("isEnglish", LanguageServlet.isEnglish(httpRequest));
        
        // Set original URL for language switcher if not already set
        if (request.getAttribute("originalUrl") == null) {
            String originalUrl = getOriginalServletUrl(httpRequest);
            request.setAttribute("originalUrl", originalUrl);
        }
        
        // Set common i18n attributes
        setCommonI18nAttributes(httpRequest);
        
        // Continue with the request
        chain.doFilter(request, response);
    }
    
    /**
     * Set common i18n attributes that are frequently used in JSP
     * @param request HttpServletRequest
     */
    private void setCommonI18nAttributes(HttpServletRequest request) {
        // Application info
        request.setAttribute("i18n_appName", I18nUtils.getMessage(request, "app.name"));
        request.setAttribute("i18n_appSlogan", I18nUtils.getMessage(request, "app.slogan"));
        
        // Common actions
        request.setAttribute("i18n_home", I18nUtils.getMessage(request, "common.home"));
        request.setAttribute("i18n_news", I18nUtils.getMessage(request, "common.news"));
        request.setAttribute("i18n_categories", I18nUtils.getMessage(request, "common.categories"));
        request.setAttribute("i18n_users", I18nUtils.getMessage(request, "common.users"));
        request.setAttribute("i18n_login", I18nUtils.getMessage(request, "common.login"));
        request.setAttribute("i18n_logout", I18nUtils.getMessage(request, "common.logout"));
        request.setAttribute("i18n_search", I18nUtils.getMessage(request, "common.search"));
        request.setAttribute("i18n_create", I18nUtils.getMessage(request, "common.create"));
        request.setAttribute("i18n_edit", I18nUtils.getMessage(request, "common.edit"));
        request.setAttribute("i18n_delete", I18nUtils.getMessage(request, "common.delete"));
        request.setAttribute("i18n_view", I18nUtils.getMessage(request, "common.view"));
        request.setAttribute("i18n_back", I18nUtils.getMessage(request, "common.back"));
        request.setAttribute("i18n_save", I18nUtils.getMessage(request, "common.save"));
        request.setAttribute("i18n_cancel", I18nUtils.getMessage(request, "common.cancel"));
        request.setAttribute("i18n_submit", I18nUtils.getMessage(request, "common.submit"));
        request.setAttribute("i18n_update", I18nUtils.getMessage(request, "common.update"));
        
        // Header
        request.setAttribute("i18n_welcome", I18nUtils.getMessage(request, "header.welcome"));
        request.setAttribute("i18n_profile", I18nUtils.getMessage(request, "header.profile"));
        request.setAttribute("i18n_settings", I18nUtils.getMessage(request, "header.settings"));
        request.setAttribute("i18n_language", I18nUtils.getMessage(request, "header.language"));
        
        // Navigation
        request.setAttribute("i18n_dashboard", I18nUtils.getMessage(request, "nav.dashboard"));
        request.setAttribute("i18n_manageNews", I18nUtils.getMessage(request, "nav.manage.news"));
        request.setAttribute("i18n_manageCategories", I18nUtils.getMessage(request, "nav.manage.categories"));
        request.setAttribute("i18n_manageUsers", I18nUtils.getMessage(request, "nav.manage.users"));
        request.setAttribute("i18n_manageNewsletter", I18nUtils.getMessage(request, "nav.manage.newsletter"));
        request.setAttribute("i18n_myNews", I18nUtils.getMessage(request, "nav.my.news"));
        request.setAttribute("i18n_createNews", I18nUtils.getMessage(request, "nav.create.news"));
        request.setAttribute("i18n_latestNews", I18nUtils.getMessage(request, "nav.latest.news"));
        request.setAttribute("i18n_popularNews", I18nUtils.getMessage(request, "nav.popular.news"));
        
        // Roles
        request.setAttribute("i18n_roleAdmin", I18nUtils.getMessage(request, "role.admin"));
        request.setAttribute("i18n_roleReporter", I18nUtils.getMessage(request, "role.reporter"));
        request.setAttribute("i18n_roleReader", I18nUtils.getMessage(request, "role.reader"));
        
        // News
        request.setAttribute("i18n_newsTitle", I18nUtils.getMessage(request, "news.title"));
        request.setAttribute("i18n_newsContent", I18nUtils.getMessage(request, "news.content"));
        request.setAttribute("i18n_newsCategory", I18nUtils.getMessage(request, "news.category"));
        request.setAttribute("i18n_newsAuthor", I18nUtils.getMessage(request, "news.author"));
        request.setAttribute("i18n_newsDate", I18nUtils.getMessage(request, "news.date"));
        request.setAttribute("i18n_newsStatus", I18nUtils.getMessage(request, "news.status"));
        request.setAttribute("i18n_newsImage", I18nUtils.getMessage(request, "news.image"));
        request.setAttribute("i18n_readMore", I18nUtils.getMessage(request, "news.read.more"));
        request.setAttribute("i18n_newsViewCount", I18nUtils.getMessage(request, "news.viewCount"));
        request.setAttribute("i18n_newsViews", I18nUtils.getMessage(request, "news.views"));
        
        // Subscription
        request.setAttribute("i18n_subscriptionSuccess", I18nUtils.getMessage(request, "subscription.success"));
        request.setAttribute("i18n_subscriptionError", I18nUtils.getMessage(request, "subscription.error"));
        request.setAttribute("i18n_subscriptionInfo", I18nUtils.getMessage(request, "subscription.info"));
        request.setAttribute("i18n_subscriptionTitle", I18nUtils.getMessage(request, "subscription.title"));
        request.setAttribute("i18n_subscriptionEmailLabel", I18nUtils.getMessage(request, "subscription.email.label"));
        request.setAttribute("i18n_subscriptionEmailPlaceholder", I18nUtils.getMessage(request, "subscription.email.placeholder"));
        request.setAttribute("i18n_subscriptionSubmit", I18nUtils.getMessage(request, "subscription.submit"));
        
        // Sidebar
        request.setAttribute("i18n_sidebarMostViewed", I18nUtils.getMessage(request, "sidebar.mostViewed"));
        request.setAttribute("i18n_sidebarLatestNews", I18nUtils.getMessage(request, "sidebar.latestNews"));
        request.setAttribute("i18n_sidebarRecentlyViewed", I18nUtils.getMessage(request, "sidebar.recentlyViewed"));
        
        // Categories
        request.setAttribute("i18n_categoryName", I18nUtils.getMessage(request, "category.name"));
        request.setAttribute("i18n_categoryDescription", I18nUtils.getMessage(request, "category.description"));
        
        // Users
        request.setAttribute("i18n_username", I18nUtils.getMessage(request, "user.username"));
        request.setAttribute("i18n_password", I18nUtils.getMessage(request, "user.password"));
        request.setAttribute("i18n_fullname", I18nUtils.getMessage(request, "user.fullname"));
        request.setAttribute("i18n_email", I18nUtils.getMessage(request, "user.email"));
        request.setAttribute("i18n_phone", I18nUtils.getMessage(request, "user.phone"));
        request.setAttribute("i18n_role", I18nUtils.getMessage(request, "user.role"));
        request.setAttribute("i18n_gender", I18nUtils.getMessage(request, "user.gender"));
        request.setAttribute("i18n_male", I18nUtils.getMessage(request, "user.male"));
        request.setAttribute("i18n_female", I18nUtils.getMessage(request, "user.female"));
        
        // Messages
        request.setAttribute("i18n_noData", I18nUtils.getMessage(request, "message.no.data"));
        request.setAttribute("i18n_loading", I18nUtils.getMessage(request, "message.loading"));
        request.setAttribute("i18n_saveSuccess", I18nUtils.getMessage(request, "message.save.success"));
        request.setAttribute("i18n_saveFailed", I18nUtils.getMessage(request, "message.save.failed"));
        
        // Footer
        request.setAttribute("i18n_footerAboutTitle", I18nUtils.getMessage(request, "footer.about.title"));
        request.setAttribute("i18n_footerAboutDescription", I18nUtils.getMessage(request, "footer.about.description"));
        request.setAttribute("i18n_footerAboutKhoanews", I18nUtils.getMessage(request, "footer.about.khoanews"));
        request.setAttribute("i18n_footerAboutDesc", I18nUtils.getMessage(request, "footer.about.desc"));
        request.setAttribute("i18n_footerQuicklinks", I18nUtils.getMessage(request, "footer.quicklinks"));
        request.setAttribute("i18n_footerContact", I18nUtils.getMessage(request, "footer.contact"));
        request.setAttribute("i18n_footerPrivacy", I18nUtils.getMessage(request, "footer.privacy"));
        request.setAttribute("i18n_footerTerms", I18nUtils.getMessage(request, "footer.terms"));
        request.setAttribute("i18n_footerCopyright", I18nUtils.getMessage(request, "footer.copyright"));
        request.setAttribute("i18n_footerAddress", I18nUtils.getMessage(request, "footer.address"));
        request.setAttribute("i18n_footerPhone", I18nUtils.getMessage(request, "footer.phone"));
        request.setAttribute("i18n_footerEmail", I18nUtils.getMessage(request, "footer.email"));
        
        // Language switcher
        request.setAttribute("i18n_currentLanguageDisplay", I18nUtils.getCurrentLanguageDisplayName(request));
        request.setAttribute("i18n_oppositeLanguage", I18nUtils.getOppositeLanguage(request));
        request.setAttribute("i18n_oppositeLanguageDisplay", I18nUtils.getOppositeLanguageDisplayName(request));
        request.setAttribute("i18n_currentFlag", I18nUtils.getLanguageFlag(LanguageServlet.getCurrentLanguage(request)));
        request.setAttribute("i18n_oppositeFlag", I18nUtils.getLanguageFlag(I18nUtils.getOppositeLanguage(request)));
        
        // Language names for dropdown
        request.setAttribute("i18n_languageCurrent", I18nUtils.getMessage(request, "language.current"));
        request.setAttribute("i18n_languageVietnamese", I18nUtils.getMessage(request, "language.vietnamese"));
        request.setAttribute("i18n_languageEnglish", I18nUtils.getMessage(request, "language.english"));
        
        // Form labels
        request.setAttribute("i18n_formId", I18nUtils.getMessage(request, "form.id"));
        request.setAttribute("i18n_formTitle", I18nUtils.getMessage(request, "form.title"));
        request.setAttribute("i18n_formContent", I18nUtils.getMessage(request, "form.content"));
        request.setAttribute("i18n_formCategory", I18nUtils.getMessage(request, "form.category"));
        request.setAttribute("i18n_formImage", I18nUtils.getMessage(request, "form.image"));
        request.setAttribute("i18n_formViewCount", I18nUtils.getMessage(request, "form.viewCount"));
        request.setAttribute("i18n_formPostedDate", I18nUtils.getMessage(request, "form.postedDate"));
        request.setAttribute("i18n_formRequired", I18nUtils.getMessage(request, "form.required"));
        request.setAttribute("i18n_formOptional", I18nUtils.getMessage(request, "form.optional"));
        
        // Page titles for CRUD
        request.setAttribute("i18n_pageCreateNews", I18nUtils.getMessage(request, "page.create.news"));
        request.setAttribute("i18n_pageEditNews", I18nUtils.getMessage(request, "page.edit.news"));
        request.setAttribute("i18n_pageViewNews", I18nUtils.getMessage(request, "page.view.news"));
        request.setAttribute("i18n_pageNewsList", I18nUtils.getMessage(request, "page.news.list"));
        
        // Table headers
        request.setAttribute("i18n_tableId", I18nUtils.getMessage(request, "table.id"));
        request.setAttribute("i18n_tableImage", I18nUtils.getMessage(request, "table.image"));
        request.setAttribute("i18n_tableTitle", I18nUtils.getMessage(request, "table.title"));
        request.setAttribute("i18n_tableAuthor", I18nUtils.getMessage(request, "table.author"));
        request.setAttribute("i18n_tablePostedDate", I18nUtils.getMessage(request, "table.postedDate"));
        request.setAttribute("i18n_tableViewCount", I18nUtils.getMessage(request, "table.viewCount"));
        request.setAttribute("i18n_tableFeatured", I18nUtils.getMessage(request, "table.featured"));
        request.setAttribute("i18n_tableActions", I18nUtils.getMessage(request, "table.actions"));
        request.setAttribute("i18n_tableNoImage", I18nUtils.getMessage(request, "table.noImage"));
        request.setAttribute("i18n_tableNoData", I18nUtils.getMessage(request, "table.noData"));
        
        // Actions & Status
        request.setAttribute("i18n_actionView", I18nUtils.getMessage(request, "action.view"));
        request.setAttribute("i18n_actionEdit", I18nUtils.getMessage(request, "action.edit"));
        request.setAttribute("i18n_actionDelete", I18nUtils.getMessage(request, "action.delete"));
        request.setAttribute("i18n_actionYes", I18nUtils.getMessage(request, "action.yes"));
        request.setAttribute("i18n_actionNo", I18nUtils.getMessage(request, "action.no"));
        request.setAttribute("i18n_actionConfirmDelete", I18nUtils.getMessage(request, "action.confirm.delete"));
        
        // Empty States
        request.setAttribute("i18n_emptyNewsTitle", I18nUtils.getMessage(request, "empty.news.title"));
        request.setAttribute("i18n_emptyNewsDescription", I18nUtils.getMessage(request, "empty.news.description"));
        request.setAttribute("i18n_emptyNewsAction", I18nUtils.getMessage(request, "empty.news.action"));
        
        // Form Options
        request.setAttribute("i18n_formSelectCategory", I18nUtils.getMessage(request, "form.select.category"));
        request.setAttribute("i18n_formSelectChoose", I18nUtils.getMessage(request, "form.select.choose"));
        
        // Buttons
        request.setAttribute("i18n_buttonBack", I18nUtils.getMessage(request, "button.back"));
        request.setAttribute("i18n_buttonSave", I18nUtils.getMessage(request, "button.save"));
        request.setAttribute("i18n_buttonCancel", I18nUtils.getMessage(request, "button.cancel"));
        request.setAttribute("i18n_buttonSubmit", I18nUtils.getMessage(request, "button.submit"));
        request.setAttribute("i18n_buttonUpdate", I18nUtils.getMessage(request, "button.update"));
        request.setAttribute("i18n_buttonCreate", I18nUtils.getMessage(request, "button.create"));
        request.setAttribute("i18n_buttonBackShort", I18nUtils.getMessage(request, "button.back.short"));
        
        // File Upload
        request.setAttribute("i18n_fileAcceptHint", I18nUtils.getMessage(request, "file.accept.hint"));
        request.setAttribute("i18n_fileCurrentImage", I18nUtils.getMessage(request, "file.current.image"));
        request.setAttribute("i18n_filePreview", I18nUtils.getMessage(request, "file.preview"));
        
        // Form Fields
        request.setAttribute("i18n_formAuthor", I18nUtils.getMessage(request, "form.author"));
        request.setAttribute("i18n_formFeatured", I18nUtils.getMessage(request, "form.featured"));
        request.setAttribute("i18n_formName", I18nUtils.getMessage(request, "form.name"));
        request.setAttribute("i18n_formDescription", I18nUtils.getMessage(request, "form.description"));
        
        // Category
        request.setAttribute("i18n_categoryManage", I18nUtils.getMessage(request, "category.manage"));
        request.setAttribute("i18n_categoryAdd", I18nUtils.getMessage(request, "category.add"));
        request.setAttribute("i18n_categoryEdit", I18nUtils.getMessage(request, "category.edit"));
        request.setAttribute("i18n_categoryView", I18nUtils.getMessage(request, "category.view"));
        request.setAttribute("i18n_categoryId", I18nUtils.getMessage(request, "category.id"));
        request.setAttribute("i18n_categoryName", I18nUtils.getMessage(request, "category.name"));
        request.setAttribute("i18n_categoryDescription", I18nUtils.getMessage(request, "category.description"));
        request.setAttribute("i18n_emptyCategoryTitle", I18nUtils.getMessage(request, "empty.category.title"));
        request.setAttribute("i18n_emptyCategoryDescription", I18nUtils.getMessage(request, "empty.category.description"));
        request.setAttribute("i18n_emptyCategoryAction", I18nUtils.getMessage(request, "empty.category.action"));
    }
    
    /**
     * Get original servlet URL from request
     * @param request HttpServletRequest
     * @return Original servlet URL
     */
    private String getOriginalServletUrl(HttpServletRequest request) {
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String queryString = request.getQueryString();
        
        // If it's a JSP file, try to determine the original servlet URL
        if (requestURI.endsWith(".jsp")) {
            // For template.jsp, we can't determine the original servlet, so return a generic URL
            return contextPath + "/";
        }
        
        // For servlet URLs, return the full URL with query string
        String originalUrl = requestURI;
        if (queryString != null && !queryString.isEmpty()) {
            originalUrl += "?" + queryString;
        }
        
        return originalUrl;
    }
    
    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
