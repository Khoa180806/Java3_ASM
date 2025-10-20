<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<%-- Sử dụng contextPath từ servlet hoặc fallback detection --%>
<c:choose>
    <c:when test="${not empty contextPath}">
        <%-- Servlet đã set contextPath --%>
        <c:set var="currentContext" value="${contextPath}" />
    </c:when>
    <c:otherwise>
        <%-- Fallback: tự động phát hiện từ URL --%>
        <c:set var="requestURI" value="${pageContext.request.requestURI}" />
        <c:set var="currentContext" value="${requestURI.contains('/quanli/') ? 'quanli/news' : 'phongvien'}" />
    </c:otherwise>
</c:choose>

<c:set var="baseUrl" value="${pageContext.request.contextPath}/${currentContext}" />

<%-- Context detection completed --%>

<!-- Main CRUD Content -->
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-newspaper me-2"></i>
                    <c:choose>
                        <c:when test="${action == 'create'}">${i18n_pageCreateNews}</c:when>
                        <c:when test="${action == 'edit'}">${i18n_pageEditNews}</c:when>
                        <c:when test="${action == 'view'}">${i18n_pageViewNews}</c:when>
                        <c:otherwise>${i18n_pageNewsList}</c:otherwise>
                    </c:choose>
                </h5>
            </div>
            <div class="card-body">
                
                <!-- List View -->
                <c:if test="${action == 'list' || empty action}">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="mb-0">${i18n_pageNewsList}</h6>
                        <a href="${baseUrl}/new" class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i> ${i18n_pageCreateNews}
                        </a>
                    </div>
                    
                    <c:choose>
                        <c:when test="${not empty newsList}">
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>${i18n_tableId}</th>
                                            <th>${i18n_tableImage}</th>
                                            <th>${i18n_tableTitle}</th>
                                            <th>${i18n_tableAuthor}</th>
                                            <th>${i18n_tablePostedDate}</th>
                                            <th>${i18n_tableViewCount}</th>
                                            <th>${i18n_tableFeatured}</th>
                                            <th>${i18n_tableActions}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="news" items="${newsList}">
                                            <tr>
                                                <td><strong>${news.id}</strong></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty news.image}">
                                                            <c:choose>
                                                                <c:when test="${news.image.startsWith('http://') || news.image.startsWith('https://')}">
                                                                    <img src="${news.image}" alt="News Image" class="news-image">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img src="${pageContext.request.contextPath}/${news.image}" alt="News Image" class="news-image">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="bg-light d-flex align-items-center justify-content-center news-image">
                                                                <i class="fas fa-image text-muted"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <strong>${news.title}</strong>
                                                    <br>
                                                    <small class="text-muted">
                                                        ${news.content.length() > 100 ? news.content.substring(0, 100).concat('...') : news.content}
                                                    </small>
                                                </td>
                                                <td>${news.author}</td>
                                                <td>
                                                    <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info">${news.viewCount}</span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${news.home}">
                                                            <span class="badge bg-success">
                                                                <i class="fas fa-check"></i> ${i18n_actionYes}
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">
                                                                <i class="fas fa-times"></i> ${i18n_actionNo}
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="action-buttons">
                                                    <a href="${baseUrl}/view?id=${news.id}" 
                                                       class="btn btn-info btn-sm" title="${i18n_actionView}">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${baseUrl}/edit?id=${news.id}" 
                                                       class="btn btn-warning btn-sm" title="${i18n_actionEdit}">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button onclick="confirmDelete('${news.id}', '${news.title}', '${baseUrl}')" 
                                                            class="btn btn-danger btn-sm" title="${i18n_actionDelete}">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <i class="fas fa-newspaper fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">${i18n_emptyNewsTitle}</h5>
                                <p class="text-muted">${i18n_emptyNewsDescription}</p>
                                <a href="${baseUrl}/new" class="btn btn-primary">
                                    <i class="fas fa-plus me-1"></i> ${i18n_emptyNewsAction}
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                
                <!-- Create/Edit Form -->
                <c:if test="${action == 'create' || action == 'edit'}">
                    <form method="post" 
                          action="${baseUrl}/${action == 'edit' ? 'update' : 'new'}"
                          enctype="multipart/form-data"
                          onsubmit="return validateForm()">
                        
                        <c:if test="${action == 'edit'}">
                            <input type="hidden" name="id" value="${news.id}">
                        </c:if>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="newsId" class="form-label">
                                        ${i18n_formId} <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="newsId" name="id" 
                                           value="${news.id}" ${action == 'edit' ? 'readonly' : ''} required
                                           minlength="3" maxlength="20"
                                           oninput="validateNewsId(this)">
                                    <div class="form-text">ID tin tức (3-20 ký tự)</div>
                                    <div id="newsIdError" class="invalid-feedback"></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="categoryId" class="form-label">${i18n_formCategory}</label>
                                    <select class="form-select" id="categoryId" name="categoryId">
                                        <option value="">${i18n_formSelectCategory}</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}" ${news.categoryId == category.id ? 'selected' : ''}>
                                                ${category.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="newsTitle" class="form-label">
                                ${i18n_formTitle} <span class="text-danger">*</span>
                            </label>
                            <input type="text" class="form-control" id="newsTitle" name="title" 
                                   value="${news.title}" required minlength="5" maxlength="200"
                                   oninput="validateNewsTitle(this)">
                            <div id="newsTitleError" class="invalid-feedback"></div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="newsContent" class="form-label">
                                ${i18n_formContent} <span class="text-danger">*</span>
                            </label>
                            <textarea class="form-control" id="newsContent" name="content" rows="8" required
                                      minlength="10" oninput="validateNewsContent(this)">${news.content}</textarea>
                            <div id="newsContentError" class="invalid-feedback"></div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="newsImage" class="form-label">${i18n_formImage}</label>
                                    <input type="file" class="form-control" id="newsImage" name="imageFile" 
                                           accept="image/*" onchange="previewImage(this)">
                                    <small class="text-muted">${i18n_fileAcceptHint}</small>
                                    
                                    <%-- Hidden field để giữ đường dẫn ảnh cũ khi edit --%>
                                    <c:if test="${action == 'edit' && not empty news.image}">
                                        <input type="hidden" name="oldImage" value="${news.image}">
                                    </c:if>
                                </div>
                                
                                <%-- Preview ảnh --%>
                                <div class="mb-3">
                                    <c:if test="${action == 'edit' && not empty news.image}">
                                        <div id="imagePreview">
                                            <p class="text-muted mb-2">${i18n_fileCurrentImage}:</p>
                                            <c:choose>
                                                <c:when test="${news.image.startsWith('http://') || news.image.startsWith('https://')}">
                                                    <img src="${news.image}" 
                                                         alt="Current image" 
                                                         class="img-thumbnail" 
                                                         style="max-width: 300px; max-height: 200px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/${news.image}" 
                                                         alt="Current image" 
                                                         class="img-thumbnail" 
                                                         style="max-width: 300px; max-height: 200px;">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:if>
                                    <c:if test="${action == 'create'}">
                                        <div id="imagePreview" style="display: none;">
                                            <p class="text-muted mb-2">${i18n_filePreview}:</p>
                                            <img id="previewImg" src="" alt="Preview" 
                                                 class="img-thumbnail" 
                                                 style="max-width: 300px; max-height: 200px;">
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="newsAuthor" class="form-label">${i18n_formAuthor}</label>
                                    <input type="text" class="form-control" id="newsAuthor" name="author" 
                                           value="${news.author}">
                                </div>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="viewCount" class="form-label">${i18n_formViewCount}</label>
                                    <input type="number" class="form-control" id="viewCount" name="viewCount" 
                                           value="${news.viewCount}" min="0">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <div class="form-check mt-4">
                                        <input class="form-check-input" type="checkbox" id="newsHome" name="home" 
                                               ${news.home ? 'checked' : ''}>
                                        <label class="form-check-label" for="newsHome">
                                            ${i18n_formFeatured}
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between">
                            <a href="${baseUrl}" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-1"></i> ${i18n_buttonBackShort}
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-1"></i> 
                                ${action == 'edit' ? i18n_buttonUpdate : i18n_buttonCreate}
                            </button>
                        </div>
                    </form>
                </c:if>
                
                <!-- View Detail -->
                <c:if test="${action == 'view'}">
                    <div class="row">
                        <div class="col-md-8">
                            <h2 class="mb-3">${news.title}</h2>
                            
                            <div class="mb-3">
                                <small class="text-muted">
                                    <i class="fas fa-user me-1"></i> ${news.author} | 
                                    <i class="fas fa-calendar me-1"></i> 
                                    <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/> | 
                                    <i class="fas fa-eye me-1"></i> ${news.viewCount} lượt xem
                                </small>
                            </div>
                            
                            <c:if test="${not empty news.image}">
                                <div class="mb-4">
                                    <c:choose>
                                        <c:when test="${news.image.startsWith('http://') || news.image.startsWith('https://')}">
                                            <img src="${news.image}" alt="${news.title}" class="img-fluid rounded">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/${news.image}" alt="${news.title}" class="img-fluid rounded">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            
                            <div class="news-content">
                                <p style="white-space: pre-wrap;">${news.content}</p>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="card">
                                <div class="card-header">
                                    <h6 class="mb-0">${i18n_pageViewNews}</h6>
                                </div>
                                <div class="card-body">
                                    <table class="table table-sm">
                                        <tr>
                                            <td><strong>${i18n_tableId}:</strong></td>
                                            <td>${news.id}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>${i18n_tableTitle}:</strong></td>
                                            <td>${news.title}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>${i18n_formCategory}:</strong></td>
                                            <td>${news.categoryId}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>${i18n_tableAuthor}:</strong></td>
                                            <td>${news.author}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>${i18n_tablePostedDate}:</strong></td>
                                            <td>
                                                <fmt:formatDate value="${news.postedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>${i18n_tableViewCount}:</strong></td>
                                            <td>${news.viewCount}</td>
                                        </tr>
                                        <tr>
                                            <td><strong>${i18n_tableFeatured}:</strong></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${news.home}">
                                                        <span class="badge bg-success">${i18n_actionYes}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">${i18n_actionNo}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    <div class="d-grid gap-2">
                                        <a href="${baseUrl}/edit?id=${news.id}" 
                                           class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit me-1"></i> ${i18n_actionEdit}
                                        </a>
                                        <button onclick="confirmDelete('${news.id}', '${news.title}', '${baseUrl}')" 
                                                class="btn btn-danger btn-sm">
                                            <i class="fas fa-trash me-1"></i> ${i18n_actionDelete}
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-4">
                        <a href="${baseUrl}" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i> ${i18n_buttonBack}
                        </a>
                    </div>
                </c:if>
                
            </div>
        </div>
    </div>
</div>