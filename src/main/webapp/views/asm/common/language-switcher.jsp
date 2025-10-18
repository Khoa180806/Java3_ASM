<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Language Switcher Component -->
<div class="language-switcher dropdown">
    <button class="btn btn-outline-secondary dropdown-toggle d-flex align-items-center" 
            type="button" id="languageDropdown" data-bs-toggle="dropdown" aria-expanded="false">
        <span class="me-2 fw-bold ${currentLanguage == 'vi' ? 'text-danger' : 'text-primary'}">${i18n_currentFlag}</span>
        <span class="d-none d-md-inline">${i18n_currentLanguageDisplay}</span>
        <span class="d-md-none">${currentLanguage.toUpperCase()}</span>
    </button>
    
    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="languageDropdown">
        <li>
            <h6 class="dropdown-header">
                <i class="fas fa-globe me-2"></i>${i18n_languageCurrent}
            </h6>
        </li>
        <li><hr class="dropdown-divider"></li>
        
        <!-- Vietnamese Option -->
        <li>
            <a class="dropdown-item ${currentLanguage == 'vi' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/language?lang=vi&redirect=${not empty originalUrl ? originalUrl : pageContext.request.requestURI}">
                <span class="me-2 text-danger fw-bold">VI</span>
                ${i18n_languageVietnamese}
                <c:if test="${currentLanguage == 'vi'}">
                    <i class="fas fa-check ms-auto text-success"></i>
                </c:if>
            </a>
        </li>
        
        <!-- English Option -->
        <li>
            <a class="dropdown-item ${currentLanguage == 'en' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/language?lang=en&redirect=${not empty originalUrl ? originalUrl : pageContext.request.requestURI}">
                <span class="me-2 text-primary fw-bold">EN</span>
                ${i18n_languageEnglish}
                <c:if test="${currentLanguage == 'en'}">
                    <i class="fas fa-check ms-auto text-success"></i>
                </c:if>
            </a>
        </li>
    </ul>
</div>

<style>
.language-switcher .dropdown-item {
    display: flex;
    align-items: center;
    padding: 0.5rem 1rem;
    transition: all 0.2s ease;
}

.language-switcher .dropdown-item:hover {
    background-color: #f8f9fa;
    transform: translateX(2px);
}

.language-switcher .dropdown-item.active {
    background-color: #e3f2fd;
    color: #1976d2;
    font-weight: 500;
}

.language-switcher .dropdown-toggle {
    border: 1px solid #dee2e6;
    background: white;
    color: #495057;
    font-size: 0.875rem;
    padding: 0.375rem 0.75rem;
    min-width: 80px;
}

.language-switcher .dropdown-toggle:hover {
    background-color: #f8f9fa;
    border-color: #adb5bd;
}

.language-switcher .dropdown-toggle:focus {
    box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
}

.language-switcher .dropdown-menu {
    min-width: 180px;
    border: 1px solid #dee2e6;
    box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
    border-radius: 0.375rem;
}

.language-switcher .dropdown-header {
    color: #6c757d;
    font-size: 0.875rem;
    font-weight: 600;
    margin-bottom: 0;
}

@media (max-width: 768px) {
    .language-switcher .dropdown-toggle {
        min-width: 60px;
        padding: 0.25rem 0.5rem;
    }
    
    .language-switcher .dropdown-menu {
        min-width: 160px;
    }
}
</style>
