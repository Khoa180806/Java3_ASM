<%--
  Created by IntelliJ IDEA.
  User: Asus
  Date: 9/29/2025
  Time: 3:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Browser</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
        :root {
            --bg: #0f172a;
            --card: #111827;
            --muted: #94a3b8;
            --text: #e5e7eb;
            --accent: #22d3ee;
            --accent-2: #60a5fa;
            --border: #1f2937;
        }
        * { box-sizing: border-box; }
        html, body { height: 100%; }
        body {
            margin: 0;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
            background: linear-gradient(180deg, #0b1020 0%, var(--bg) 100%);
            color: var(--text);
        }
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 20px 24px;
            background: rgba(17, 24, 39, 0.8);
            border: 1px solid var(--border);
            border-radius: 14px;
            backdrop-filter: blur(8px);
            box-shadow: 0 10px 30px rgba(0,0,0,.35), inset 0 1px 0 rgba(255,255,255,.02);
        }
        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            letter-spacing: .3px;
        }
        .logo {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: linear-gradient(135deg, var(--accent), var(--accent-2));
            box-shadow: 0 8px 24px rgba(34, 211, 238, .25);
        }
        .brand h1 { margin: 0; font-size: 18px; font-weight: 700; }
        .brand span { color: var(--muted); font-weight: 500; font-size: 12px; }

        .grid {
            margin-top: 24px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 16px;
        }
        .card {
            position: relative;
            background: linear-gradient(180deg, rgba(31,41,55,.6), rgba(17,24,39,.8));
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 18px;
            transition: transform .2s ease, box-shadow .2s ease, border-color .2s ease;
            overflow: hidden;
        }
        .card:hover {
            transform: translateY(-3px);
            border-color: rgba(96,165,250,.6);
            box-shadow: 0 12px 28px rgba(0,0,0,.35);
        }
        .card h3 { margin: 0 0 8px; font-size: 16px; }
        .card p { margin: 0 0 12px; color: var(--muted); font-size: 13px; line-height: 1.4; }
        .links { display: flex; flex-wrap: wrap; gap: 8px; }
        a.btn {
            text-decoration: none;
            color: #0a0f1e;
            background: linear-gradient(135deg, var(--accent), var(--accent-2));
            border: 0;
            padding: 8px 12px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 12px;
            letter-spacing: .2px;
            transition: transform .15s ease, box-shadow .15s ease;
            box-shadow: 0 6px 18px rgba(96,165,250,.35);
        }
        a.btn:hover { transform: translateY(-1px); }
        a.btn.ghost {
            color: var(--text);
            background: transparent;
            border: 1px solid var(--border);
            box-shadow: none;
        }
        footer { margin-top: 28px; color: var(--muted); font-size: 12px; text-align: center; }
        .note { color: var(--muted); font-size: 12px; margin-top: 6px; }
        @media (max-width: 480px) { .brand h1 { font-size: 16px; } }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <div class="brand">
            <div class="logo"></div>
            <div>
                <h1>Study Browser</h1>
                <span>Điều hướng nhanh tới các Servlet</span>
            </div>
        </div>
        <div class="links">
            <a class="btn ghost" href="/Browser">/Browser</a>
            <a class="btn ghost" href="/account/login">/account/login</a>
            <a class="btn ghost" href="/home">/home</a>
            <a class="btn" href="/docgia">/docgia</a>
            <a class="btn ghost" href="/docgia/detail?id=1">/docgia/detail?id=1</a>
        </div>
    </div>

    <div class="grid">
        <div class="card">
            <h3>Lab 1</h3>
            <p>Chào, Home và URL Info.</p>
            <div class="links">
                <a class="btn" href="/hello">/hello</a>
                <a class="btn" href="/home">/home</a>
                <a class="btn" href="/url-info">/url-info</a>
            </div>
        </div>

        <div class="card">
            <h3>Lab 2</h3>
            <p>Form cập nhật, chia sẻ trang, và người dùng.</p>
            <div class="links">
                <a class="btn" href="/form/update">/form/update</a>
                <a class="btn" href="/share">/share</a>
                <a class="btn" href="/user">/user</a>
            </div>
        </div>

        <div class="card">
            <h3>Lab 3</h3>
            <p>Định dạng, tiêu đề, và quốc gia.</p>
            <div class="links">
                <a class="btn" href="/Format">/Format</a>
                <a class="btn" href="/Title">/Title</a>
                <a class="btn" href="/CountryServlet">/CountryServlet</a>
            </div>
        </div>

        <div class="card">
            <h3>Lab 4</h3>
            <p>Tính toán, đăng ký, đăng nhập, và upload file.</p>
            <div class="links">
                <a class="btn" href="/Calculate">/Calculate</a>
                <a class="btn" href="/Dangky">/Dangky</a>
                <a class="btn" href="/account/login">/account/login</a>
                <a class="btn" href="/Upload">/Upload</a>
            </div>
            <div class="note">Lưu ý: `Calculate` map `/*`, có thể cần tham số bổ sung.</div>
        </div>
        
        <div class="card">
            <h3>Lab 5</h3>
            <p>Thực hành JSP/Servlet với Form đăng nhập và xử lý dữ liệu</p>
            <div class="links">
                <a href="/login" class="btn">/login</a>
                <a href="/save" class="btn">/save</a>
                <a href="/email" class="btn">/email</a>
            </div>
        </div>

        <div class="card">
            <h3>Lab 7 - Quản lý Nhân viên & Phòng ban</h3>
            <p>Quản lý thông tin nhân viên và phòng ban.</p>
            <div class="links">
                <a class="btn" href="/employee/index">/employee/index</a>
                <a class="btn" href="/department/index">/department/index</a>
            </div>
        </div>

        <div class="card">
            <h3>Lab 8 - Đa ngôn ngữ</h3>
            <p>Trang chủ đa ngôn ngữ với i18n.</p>
            <div class="links">
                <a class="btn" href="/home/index">/home/index</a>
                <a class="btn" href="/home/about">/home/about</a>
                <a class="btn" href="/home/contact">/home/contact</a>
            </div>
        </div>

        <div class="card">
            <h3>ASM - Độc giả</h3>
            <p>Trang tin tức mẫu: danh sách và chi tiết bài viết.</p>
            <div class="links">
                <a class="btn" href="/logintintuc">Đăng nhập</a>
            </div>
        </div>

        <div class="card">
            <h3>Bài bảo vệ</h3>
            <p>Quản lý khách hàng.</p>
            <div class="links">
                <a class="btn" href="/khachhang">Quản lý khách hàng</a>
            </div>
        </div>
    </div>

    <footer>
        © 2025 Study App. Made with ❤ JSP.
    </footer>
</div>
</body>
</html>
