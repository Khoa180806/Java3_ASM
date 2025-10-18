<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : i18n_appName}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        body {
            padding-top: 20px;
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .main-content {
            min-height: calc(100vh - 300px);
            padding: 20px 0;
        }
        
        /* Language-specific font optimization */
        html[lang="vi"] {
            font-family: 'Segoe UI', 'Arial Unicode MS', sans-serif;
        }
        html[lang="en"] {
            font-family: 'Segoe UI', 'Helvetica Neue', Arial, sans-serif;
        }
        
        /* Smooth transitions for language switching */
        * {
            transition: all 0.3s ease;
        }
        
        /* Loading indicator for language switching */
        .language-loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        /* Success message for language switch */
        .language-switch-success {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1050;
            max-width: 300px;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/views/asm/common/docgia/docgiaheader.jsp"/>
    
    <!-- Include Navigation -->
    <jsp:include page="/views/asm/common/docgia/docgianav.jsp"/>
    
    <!-- Main Content -->
    <div class="container mt-4">
        <div class="row">
            <!-- Main Content Area -->
            <div class="col-md-9">
                <jsp:include page="${mainContent}" />
            </div>
            <!-- Sidebar -->
            <div class="col-md-3">
                <jsp:include page="/views/asm/common/docgia/docgiasidebar.jsp" />
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="/views/asm/common/docgia/docgiafooter.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Language Switch Enhancement -->
    <c:remove var="languageMessage" scope="session"/>
    
    <!-- Debug info (remove in production) -->
    <c:if test="${param.debug == 'true'}">
        <div class="alert alert-info mt-2">
            <small>
                <strong>Debug Info:</strong><br>
                Request URI: ${pageContext.request.requestURI}<br>
                Original URL: ${originalUrl}<br>
                Query String: ${pageContext.request.queryString}
            </small>
        </div>
    </c:if>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Language switch loading indicator
            const languageLinks = document.querySelectorAll('a[href*="/language?"]');
            languageLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    document.body.classList.add('language-loading');
                    showLanguageMessage('${isVietnamese ? "Đang chuyển đổi ngôn ngữ..." : "Switching language..."}', 'info');
                });
            });
            
            // Smooth scroll for anchor links
            const anchorLinks = document.querySelectorAll('a[href^="#"]');
            anchorLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        });
        
        // Function to show language messages
        function showLanguageMessage(message, type) {
            const alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-' + type + ' alert-dismissible fade show language-switch-success';
            alertDiv.innerHTML = '<i class="fas fa-globe me-2"></i><strong>' + message + '</strong><button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            
            document.body.appendChild(alertDiv);
            
            setTimeout(function() {
                if (alertDiv.parentNode) {
                    alertDiv.remove();
                }
            }, 3000);
        }
    </script>
</body>
</html>