<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty pageTitle ? pageTitle : 'Khoa News'}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            padding-top: 20px;
            background-color: #f8f9fa;
        }
        .main-content {
            min-height: calc(100vh - 300px);
            padding: 20px 0;
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
</body>
</html>