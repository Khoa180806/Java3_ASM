<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${i18n_appName} - I18n Demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Include Header -->
    <%@ include file="common/docgia/docgiaheader.jsp" %>
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="fas fa-globe me-2"></i>
                            ${i18n_language} Demo - Internationalization
                        </h4>
                    </div>
                    <div class="card-body">
                        <!-- Current Language Info -->
                        <div class="alert alert-info">
                            <h5><i class="fas fa-info-circle me-2"></i>Current Language Information</h5>
                            <ul class="mb-0">
                                <li><strong>Language Code:</strong> ${currentLanguage}</li>
                                <li><strong>Is Vietnamese:</strong> ${isVietnamese}</li>
                                <li><strong>Is English:</strong> ${isEnglish}</li>
                                <li><strong>Display Name:</strong> ${i18n_currentLanguageDisplay}</li>
                            </ul>
                        </div>
                        
                        <!-- Application Info -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-header">
                                        <h6 class="mb-0">${i18n_appName}</h6>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>App Name:</strong> ${i18n_appName}</p>
                                        <p><strong>App Slogan:</strong> ${i18n_appSlogan}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-header">
                                        <h6 class="mb-0">${i18n_role}</h6>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>Admin:</strong> ${i18n_roleAdmin}</p>
                                        <p><strong>Reporter:</strong> ${i18n_roleReporter}</p>
                                        <p><strong>Reader:</strong> ${i18n_roleReader}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Common Actions -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6 class="mb-0">Common Actions</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <button class="btn btn-primary w-100 mb-2">
                                                    <i class="fas fa-home me-2"></i>${i18n_home}
                                                </button>
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-info w-100 mb-2">
                                                    <i class="fas fa-newspaper me-2"></i>${i18n_news}
                                                </button>
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-success w-100 mb-2">
                                                    <i class="fas fa-plus me-2"></i>${i18n_create}
                                                </button>
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-warning w-100 mb-2">
                                                    <i class="fas fa-edit me-2"></i>${i18n_edit}
                                                </button>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <button class="btn btn-secondary w-100 mb-2">
                                                    <i class="fas fa-eye me-2"></i>${i18n_view}
                                                </button>
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-danger w-100 mb-2">
                                                    <i class="fas fa-trash me-2"></i>${i18n_delete}
                                                </button>
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-outline-primary w-100 mb-2">
                                                    <i class="fas fa-save me-2"></i>${i18n_save}
                                                </button>
                                            </div>
                                            <div class="col-md-3">
                                                <button class="btn btn-outline-secondary w-100 mb-2">
                                                    <i class="fas fa-times me-2"></i>${i18n_cancel}
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- News Related -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-header">
                                        <h6 class="mb-0">${i18n_news}</h6>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>${i18n_newsTitle}:</strong> Sample News Title</p>
                                        <p><strong>${i18n_newsAuthor}:</strong> John Doe</p>
                                        <p><strong>${i18n_newsCategory}:</strong> Technology</p>
                                        <p><strong>${i18n_newsDate}:</strong> 2024-01-01</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card h-100">
                                    <div class="card-header">
                                        <h6 class="mb-0">${i18n_users}</h6>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>${i18n_username}:</strong> admin</p>
                                        <p><strong>${i18n_fullname}:</strong> Administrator</p>
                                        <p><strong>${i18n_email}:</strong> admin@example.com</p>
                                        <p><strong>${i18n_gender}:</strong> ${i18n_male}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Messages -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6 class="mb-0">Messages</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="alert alert-success">
                                            <i class="fas fa-check-circle me-2"></i>${i18n_saveSuccess}
                                        </div>
                                        <div class="alert alert-danger">
                                            <i class="fas fa-exclamation-circle me-2"></i>${i18n_saveFailed}
                                        </div>
                                        <div class="alert alert-info">
                                            <i class="fas fa-info-circle me-2"></i>${i18n_loading}
                                        </div>
                                        <div class="alert alert-warning">
                                            <i class="fas fa-exclamation-triangle me-2"></i>${i18n_noData}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Language Switch Test -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h6 class="mb-0">Language Switch Test</h6>
                                    </div>
                                    <div class="card-body text-center">
                                        <p class="mb-3">Test the language switcher:</p>
                                        <a href="${pageContext.request.contextPath}/language?lang=vi&redirect=${pageContext.request.requestURI}" 
                                           class="btn btn-outline-primary me-2">
                                            🇻🇳 Tiếng Việt
                                        </a>
                                        <a href="${pageContext.request.contextPath}/language?lang=en&redirect=${pageContext.request.requestURI}" 
                                           class="btn btn-outline-primary">
                                            🇺🇸 English
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
