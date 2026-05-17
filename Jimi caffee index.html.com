
# Create a professional dark-mode restaurant website with landing page, dashboard, and contact form

html_content = '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Noir Bistro | Fine Dining Experience</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-primary: #0a0a0f;
            --bg-secondary: #12121a;
            --bg-card: #1a1a24;
            --bg-hover: #22222e;
            --text-primary: #f0f0f5;
            --text-secondary: #a0a0b0;
            --text-muted: #6b6b7b;
            --accent: #c9a96e;
            --accent-hover: #d4b87a;
            --accent-glow: rgba(201, 169, 110, 0.15);
            --border: rgba(255,255,255,0.06);
            --success: #4ade80;
            --danger: #f87171;
            --warning: #fbbf24;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
        }

        h1, h2, h3, h4 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        /* ===== NAVIGATION ===== */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            background: rgba(10, 10, 15, 0.85);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            padding: 0 5%;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            color: var(--accent);
            text-decoration: none;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .nav-links {
            display: flex;
            gap: 2.5rem;
            list-style: none;
        }

        .nav-links a {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            transition: color 0.3s;
            position: relative;
        }

        .nav-links a:hover, .nav-links a.active {
            color: var(--accent);
        }

        .nav-links a::after {
            content: '';
            position: absolute;
            bottom: -6px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--accent);
            transition: width 0.3s;
        }

        .nav-links a:hover::after, .nav-links a.active::after {
            width: 100%;
        }

        .nav-cta {
            background: var(--accent);
            color: var(--bg-primary);
            padding: 0.6rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.3s;
        }

        .nav-cta:hover {
            background: var(--accent-hover);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(201, 169, 110, 0.3);
        }

        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            color: var(--text-primary);
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* ===== HERO SECTION ===== */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            padding: 100px 5% 80px;
            background: 
                radial-gradient(ellipse at 20% 50%, rgba(201, 169, 110, 0.08) 0%, transparent 50%),
                radial-gradient(ellipse at 80% 50%, rgba(201, 169, 110, 0.05) 0%, transparent 50%),
                var(--bg-primary);
        }

        .hero-content {
            max-width: 900px;
            z-index: 2;
        }

        .hero-subtitle {
            color: var(--accent);
            font-size: 0.9rem;
            letter-spacing: 4px;
            text-transform: uppercase;
            margin-bottom: 1.5rem;
            font-weight: 500;
        }

        .hero h1 {
            font-size: clamp(2.5rem, 6vw, 5rem);
            line-height: 1.1;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, var(--text-primary) 0%, var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .hero p {
            font-size: 1.15rem;
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto 2.5rem;
            line-height: 1.8;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-primary {
            background: var(--accent);
            color: var(--bg-primary);
            padding: 1rem 2.5rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary:hover {
            background: var(--accent-hover);
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(201, 169, 110, 0.3);
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-primary);
            padding: 1rem 2.5rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            border: 1px solid var(--border);
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-secondary:hover {
            border-color: var(--accent);
            color: var(--accent);
            transform: translateY(-3px);
        }

        /* Floating elements */
        .floating-dish {
            position: absolute;
            width: 280px;
            height: 280px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(201, 169, 110, 0.1) 0%, transparent 70%);
            animation: float 6s ease-in-out infinite;
        }

        .floating-dish:nth-child(1) {
            top: 15%;
            left: 5%;
            animation-delay: 0s;
        }

        .floating-dish:nth-child(2) {
            bottom: 20%;
            right: 8%;
            width: 200px;
            height: 200px;
            animation-delay: 2s;
        }

        .floating-dish:nth-child(3) {
            top: 50%;
            right: 15%;
            width: 150px;
            height: 150px;
            animation-delay: 4s;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(5deg); }
        }

        /* ===== SECTIONS COMMON ===== */
        section {
            padding: 100px 5%;
        }

        .section-header {
            text-align: center;
            margin-bottom: 4rem;
        }

        .section-header h2 {
            font-size: clamp(2rem, 4vw, 3rem);
            margin-bottom: 1rem;
            color: var(--text-primary);
        }

        .section-header p {
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto;
            font-size: 1.1rem;
        }

        .section-label {
            color: var(--accent);
            font-size: 0.85rem;
            letter-spacing: 3px;
            text-transform: uppercase;
            margin-bottom: 1rem;
            display: block;
            font-weight: 600;
        }

        /* ===== FEATURES ===== */
        .features {
            background: var(--bg-secondary);
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .feature-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 2.5rem;
            transition: all 0.4s;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, transparent, var(--accent), transparent);
            opacity: 0;
            transition: opacity 0.4s;
        }

        .feature-card:hover {
            transform: translateY(-8px);
            border-color: rgba(201, 169, 110, 0.2);
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
        }

        .feature-card:hover::before {
            opacity: 1;
        }

        .feature-icon {
            width: 60px;
            height: 60px;
            background: var(--accent-glow);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.5rem;
            font-size: 1.5rem;
            color: var(--accent);
        }

        .feature-card h3 {
            font-size: 1.4rem;
            margin-bottom: 0.8rem;
            color: var(--text-primary);
        }

        .feature-card p {
            color: var(--text-secondary);
            line-height: 1.7;
            font-size: 0.95rem;
        }

        /* ===== MENU PREVIEW ===== */
        .menu-preview {
            background: var(--bg-primary);
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .menu-item {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.4s;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            border-color: rgba(201, 169, 110, 0.2);
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }

        .menu-item-image {
            height: 200px;
            background: linear-gradient(135deg, #1a1a24 0%, #2a2a3a 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: var(--accent);
            position: relative;
            overflow: hidden;
        }

        .menu-item-image::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 60%;
            background: linear-gradient(to top, var(--bg-card), transparent);
        }

        .menu-item-content {
            padding: 1.5rem;
        }

        .menu-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .menu-item h3 {
            font-size: 1.2rem;
            color: var(--text-primary);
        }

        .menu-price {
            color: var(--accent);
            font-weight: 700;
            font-size: 1.1rem;
        }

        .menu-item p {
            color: var(--text-secondary);
            font-size: 0.9rem;
            line-height: 1.6;
        }

        .menu-tag {
            display: inline-block;
            background: var(--accent-glow);
            color: var(--accent);
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-top: 1rem;
        }

        /* ===== DASHBOARD SECTION ===== */
        .dashboard-section {
            background: var(--bg-secondary);
            padding: 100px 5%;
        }

        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .dashboard-header h2 {
            font-size: 2rem;
        }

        .dashboard-tabs {
            display: flex;
            gap: 0.5rem;
            background: var(--bg-card);
            padding: 0.4rem;
            border-radius: 12px;
            border: 1px solid var(--border);
        }

        .dashboard-tab {
            padding: 0.6rem 1.2rem;
            border-radius: 8px;
            border: none;
            background: transparent;
            color: var(--text-secondary);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 0.9rem;
        }

        .dashboard-tab.active {
            background: var(--accent);
            color: var(--bg-primary);
        }

        .dashboard-tab:hover:not(.active) {
            color: var(--text-primary);
            background: var(--bg-hover);
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.5rem;
            transition: all 0.3s;
        }

        .stat-card:hover {
            border-color: rgba(201, 169, 110, 0.2);
            transform: translateY(-3px);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
        }

        .stat-icon.gold { background: var(--accent-glow); color: var(--accent); }
        .stat-icon.green { background: rgba(74, 222, 128, 0.1); color: var(--success); }
        .stat-icon.red { background: rgba(248, 113, 113, 0.1); color: var(--danger); }
        .stat-icon.blue { background: rgba(96, 165, 250, 0.1); color: #60a5fa; }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.3rem;
        }

        .stat-change {
            font-size: 0.85rem;
            font-weight: 600;
        }

        .stat-change.positive { color: var(--success); }
        .stat-change.negative { color: var(--danger); }

        /* Charts Area */
        .dashboard-row {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .dashboard-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 1.5rem;
        }

        .dashboard-card h3 {
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* Chart */
        .chart-container {
            height: 280px;
            position: relative;
        }

        .chart-bars {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            height: 220px;
            padding: 0 0.5rem;
            gap: 0.8rem;
        }

        .chart-bar-group {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }

        .chart-bar {
            width: 100%;
            max-width: 40px;
            background: linear-gradient(to top, var(--accent), rgba(201, 169, 110, 0.3));
            border-radius: 6px 6px 0 0;
            transition: all 0.3s;
            position: relative;
        }

        .chart-bar:hover {
            filter: brightness(1.2);
        }

        .chart-bar::after {
            content: attr(data-value);
            position: absolute;
            top: -25px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.75rem;
            color: var(--accent);
            font-weight: 600;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .chart-bar:hover::after {
            opacity: 1;
        }

        .chart-label {
            font-size: 0.75rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        /* Table */
        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th {
            text-align: left;
            padding: 1rem;
            color: var(--text-secondary);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border);
        }

        .data-table td {
            padding: 1rem;
            color: var(--text-primary);
            font-size: 0.9rem;
            border-bottom: 1px solid var(--border);
        }

        .data-table tr:hover td {
            background: var(--bg-hover);
        }

        .status-badge {
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .status-badge.completed {
            background: rgba(74, 222, 128, 0.15);
            color: var(--success);
        }

        .status-badge.pending {
            background: rgba(251, 191, 36, 0.15);
            color: var(--warning);
        }

        .status-badge.cancelled {
            background: rgba(248, 113, 113, 0.15);
            color: var(--danger);
        }

        /* Recent Activity */
        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.8rem;
            border-radius: 10px;
            transition: background 0.3s;
        }

        .activity-item:hover {
            background: var(--bg-hover);
        }

        .activity-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent), #8b7355);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: white;
            font-size: 0.9rem;
            flex-shrink: 0;
        }

        .activity-content {
            flex: 1;
        }

        .activity-text {
            color: var(--text-primary);
            font-size: 0.9rem;
            margin-bottom: 0.2rem;
        }

        .activity-time {
            color: var(--text-muted);
            font-size: 0.8rem;
        }

        /* ===== CONTACT SECTION ===== */
        .contact-section {
            background: var(--bg-primary);
            padding: 100px 5%;
        }

        .contact-container {
            max-width: 1100px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1.2fr;
            gap: 4rem;
            align-items: start;
        }

        .contact-info h2 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .contact-info > p {
            color: var(--text-secondary);
            margin-bottom: 2.5rem;
            line-height: 1.8;
        }

        .contact-details {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .contact-detail {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
        }

        .contact-detail-icon {
            width: 50px;
            height: 50px;
            background: var(--accent-glow);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent);
            font-size: 1.2rem;
            flex-shrink: 0;
        }

        .contact-detail h4 {
            font-size: 1rem;
            margin-bottom: 0.3rem;
            color: var(--text-primary);
        }

        .contact-detail p {
            color: var(--text-secondary);
            font-size: 0.95rem;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .social-link {
            width: 45px;
            height: 45px;
            border-radius: 12px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.3s;
            font-size: 1.1rem;
        }

        .social-link:hover {
            background: var(--accent);
            color: var(--bg-primary);
            border-color: var(--accent);
            transform: translateY(-3px);
        }

        /* Contact Form */
        .contact-form {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 2.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
            font-weight: 500;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 1rem;
            background: var(--bg-primary);
            border: 1px solid var(--border);
            border-radius: 10px;
            color: var(--text-primary);
            font-size: 1rem;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px var(--accent-glow);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }

        .submit-btn {
            width: 100%;
            padding: 1rem;
            background: var(--accent);
            color: var(--bg-primary);
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .submit-btn:hover {
            background: var(--accent-hover);
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(201, 169, 110, 0.3);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        /* Form Success Message */
        .form-success {
            display: none;
            text-align: center;
            padding: 3rem 2rem;
        }

        .form-success i {
            font-size: 4rem;
            color: var(--success);
            margin-bottom: 1rem;
        }

        .form-success h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .form-success p {
            color: var(--text-secondary);
        }

        /* ===== FOOTER ===== */
        footer {
            background: var(--bg-secondary);
            border-top: 1px solid var(--border);
            padding: 60px 5% 30px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 3rem;
            margin-bottom: 3rem;
        }

        .footer-brand .logo {
            margin-bottom: 1rem;
            display: inline-block;
        }

        .footer-brand p {
            color: var(--text-secondary);
            line-height: 1.7;
            font-size: 0.95rem;
        }

        .footer-column h4 {
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            font-size: 1rem;
        }

        .footer-column ul {
            list-style: none;
        }

        .footer-column li {
            margin-bottom: 0.8rem;
        }

        .footer-column a {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s;
        }

        .footer-column a:hover {
            color: var(--accent);
        }

        .footer-bottom {
            border-top: 1px solid var(--border);
            padding-top: 2rem;
            text-align: center;
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        /* ===== SCROLL ANIMATIONS ===== */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.8s ease;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 1024px) {
            .dashboard-row {
                grid-template-columns: 1fr;
            }
            .contact-container {
                grid-template-columns: 1fr;
            }
            .footer-content {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 768px) {
            .nav-links {
                display: none;
            }
            .mobile-menu-btn {
                display: block;
            }
            .hero h1 {
                font-size: 2.5rem;
            }
            .form-row {
                grid-template-columns: 1fr;
            }
            .footer-content {
                grid-template-columns: 1fr;
                text-align: center;
            }
            .dashboard-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        /* Smooth scroll */
        html {
            scroll-behavior: smooth;
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar">
        <a href="#" class="logo">Noir Bistro</a>
        <ul class="nav-links">
            <li><a href="#home" class="active">Home</a></li>
            <li><a href="#features">About</a></li>
            <li><a href="#menu">Menu</a></li>
            <li><a href="#dashboard">Dashboard</a></li>
            <li><a href="#contact">Contact</a></li>
        </ul>
        <a href="#contact" class="nav-cta">Reserve Table</a>
        <button class="mobile-menu-btn"><i class="fas fa-bars"></i></button>
    </nav>

    <!-- Hero Section -->
    <section class="hero" id="home">
        <div class="floating-dish"></div>
        <div class="floating-dish"></div>
        <div class="floating-dish"></div>
        <div class="hero-content">
            <span class="hero-subtitle">Fine Dining Experience</span>
            <h1>Where Culinary Art Meets Elegance</h1>
            <p>Experience an unforgettable journey of flavors crafted by our award-winning chefs. Every dish tells a story of passion, precision, and perfection.</p>
            <div class="hero-buttons">
                <a href="#menu" class="btn-primary"><i class="fas fa-utensils"></i> Explore Menu</a>
                <a href="#contact" class="btn-secondary"><i class="fas fa-calendar"></i> Book a Table</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features" id="features">
        <div class="section-header fade-in">
            <span class="section-label">Why Choose Us</span>
            <h2>An Experience Like No Other</h2>
            <p>We combine exceptional cuisine with impeccable service to create moments that linger in memory.</p>
        </div>
        <div class="features-grid">
            <div class="feature-card fade-in">
                <div class="feature-icon"><i class="fas fa-star"></i></div>
                <h3>Award-Winning Chefs</h3>
                <p>Our culinary team brings decades of experience from Michelin-starred kitchens around the world, crafting dishes that push boundaries.</p>
            </div>
            <div class="feature-card fade-in">
                <div class="feature-icon"><i class="fas fa-leaf"></i></div>
                <h3>Farm-to-Table Fresh</h3>
                <p>We partner with local organic farms to source the freshest seasonal ingredients, ensuring every bite bursts with natural flavor.</p>
            </div>
            <div class="feature-card fade-in">
                <div class="feature-icon"><i class="fas fa-wine-glass"></i></div>
                <h3>Curated Wine Collection</h3>
                <p>Our sommelier has hand-selected over 500 wines from the world's finest vineyards to perfectly complement your dining experience.</p>
            </div>
            <div class="feature-card fade-in">
                <div class="feature-icon"><i class="fas fa-music"></i></div>
                <h3>Ambient Atmosphere</h3>
                <p>Immerse yourself in our carefully designed space featuring soft jazz, warm lighting, and intimate seating arrangements.</p>
            </div>
        </div>
    </section>

    <!-- Menu Preview -->
    <section class="menu-preview" id="menu">
        <div class="section-header fade-in">
            <span class="section-label">Our Menu</span>
            <h2>Signature Dishes</h2>
            <p>Explore our carefully curated selection of culinary masterpieces.</p>
        </div>
        <div class="menu-grid">
            <div class="menu-item fade-in">
                <div class="menu-item-image"><i class="fas fa-drumstick-bite"></i></div>
                <div class="menu-item-content">
                    <div class="menu-item-header">
                        <h3>Truffle Roasted Duck</h3>
                        <span class="menu-price">$48</span>
                    </div>
                    <p>Pan-seared duck breast with black truffle jus, served with parsnip purée and roasted seasonal vegetables.</p>
                    <span class="menu-tag">Chef's Choice</span>
                </div>
            </div>
            <div class="menu-item fade-in">
                <div class="menu-item-image"><i class="fas fa-fish"></i></div>
                <div class="menu-item-content">
                    <div class="menu-item-header">
                        <h3>Pan-Seared Scallops</h3>
                        <span class="menu-price">$42</span>
                    </div>
                    <p>Hand-dived scallops with cauliflower velouté, crispy pancetta, and lemon beurre blanc.</p>
                    <span class="menu-tag">Seasonal</span>
                </div>
            </div>
            <div class="menu-item fade-in">
                <div class="menu-item-image"><i class="fas fa-bread-slice"></i></div>
                <div class="menu-item-content">
                    <div class="menu-item-header">
                        <h3>Wagyu Beef Tartare</h3>
                        <span class="menu-price">$38</span>
                    </div>
                    <p>Grade A5 Wagyu with quail egg, capers, shallots, and toasted sourdough crisps.</p>
                    <span class="menu-tag">Popular</span>
                </div>
            </div>
            <div class="menu-item fade-in">
                <div class="menu-item-image"><i class="fas fa-carrot"></i></div>
                <div class="menu-item-content">
                    <div class="menu-item-header">
                        <h3>Wild Mushroom Risotto</h3>
                        <span class="menu-price">$34</span>
                    </div>
                    <p>Carnaroli rice with porcini, chanterelle, and morel mushrooms, finished with aged Parmesan.</p>
                    <span class="menu-tag">Vegetarian</span>
                </div>
            </div>
            <div class="menu-item fade-in">
                <div class="menu-item-image"><i class="fas fa-pepper-hot"></i></div>
                <div class="menu-item-content">
                    <div class="menu-item-header">
                        <h3>Lobster Thermidor</h3>
                        <span class="menu-price">$65</span>
                    </div>
                    <p>Whole Maine lobster with cognac cream sauce, gruyère crust, and saffron-infused rice.</p>
                    <span class="menu-tag">Signature</span>
                </div>
            </div>
            <div class="menu-item fade-in">
                <div class="menu-item-image"><i class="fas fa-ice-cream"></i></div>
                <div class="menu-item-content">
                    <div class="menu-item-header">
                        <h3>Dark Chocolate Soufflé</h3>
                        <span class="menu-price">$22</span>
                    </div>
                    <p>Valrhona chocolate soufflé with vanilla bean ice cream and raspberry coulis.</p>
                    <span class="menu-tag">Dessert</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Dashboard Section -->
    <section class="dashboard-section" id="dashboard">
        <div class="dashboard-container">
            <div class="section-header fade-in">
                <span class="section-label">Restaurant Analytics</span>
                <h2>Live Dashboard</h2>
                <p>Real-time insights into our restaurant operations and performance.</p>
            </div>

            <div class="dashboard-header fade-in">
                <h2>Overview</h2>
                <div class="dashboard-tabs">
                    <button class="dashboard-tab active" onclick="switchTab(this, 'overview')">Overview</button>
                    <button class="dashboard-tab" onclick="switchTab(this, 'orders')">Orders</button>
                    <button class="dashboard-tab" onclick="switchTab(this, 'reservations')">Reservations</button>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid fade-in">
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">Today's Revenue</span>
                        <div class="stat-icon gold"><i class="fas fa-dollar-sign"></i></div>
                    </div>
                    <div class="stat-value">$8,420</div>
                    <div class="stat-change positive"><i class="fas fa-arrow-up"></i> +12.5% from yesterday</div>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">Active Orders</span>
                        <div class="stat-icon green"><i class="fas fa-shopping-bag"></i></div>
                    </div>
                    <div class="stat-value">24</div>
                    <div class="stat-change positive"><i class="fas fa-arrow-up"></i> +5 new orders</div>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">Reservations</span>
                        <div class="stat-icon blue"><i class="fas fa-calendar-check"></i></div>
                    </div>
                    <div class="stat-value">18</div>
                    <div class="stat-change positive"><i class="fas fa-arrow-up"></i> +3 tonight</div>
                </div>
                <div class="stat-card">
                    <div class="stat-header">
                        <span class="stat-label">Avg. Rating</span>
                        <div class="stat-icon red"><i class="fas fa-star"></i></div>
                    </div>
                    <div class="stat-value">4.9</div>
                    <div class="stat-change positive"><i class="fas fa-arrow-up"></i> +0.2 this week</div>
                </div>
            </div>

            <!-- Charts & Activity -->
            <div class="dashboard-row fade-in">
                <div class="dashboard-card">
                    <h3><i class="fas fa-chart-bar" style="color: var(--accent);"></i> Weekly Revenue</h3>
                    <div class="chart-container">
                        <div class="chart-bars">
                            <div class="chart-bar-group">
                                <div class="chart-bar" style="height: 45%;" data-value="$4.2k"></div>
                                <span class="chart-label">Mon</span>
                            </div>
                            <div class="chart-bar-group">
                                <div class="chart-bar" style="height: 62%;" data-value="$5.8k"></div>
                                <span class="chart-label">Tue</span>
                            </div>
                            <div class="chart-bar-group">
                                <div class="chart-bar" style="height: 55%;" data-value="$5.1k"></div>
                                <span class="chart-label">Wed</span>
                            </div>
                            <div class="chart-bar-group">
                                <div class="chart-bar" style="height: 78%;" data-value="$7.3k"></div>
                                <span class="chart-label">Thu</span>
                            </div>
                            <div class="chart-bar-group">
                                <div class="chart-bar" style="height: 92%;" data-value="$8.6k"></div>
                                <span class="chart-label">Fri</span>
                            </div>
                            <div class="chart-bar-group">
                                <div class="chart-bar" style="height: 100%;" data-value="$9.4k"></div>
                                <span class="chart-label">Sat</span>
                            </div>
                            <div class="chart-bar-group">
                                <div class="chart-bar" style="height: 85%;" data-value="$7.9k"></div>
                                <span class="chart-label">Sun</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="dashboard-card">
                    <h3><i class="fas fa-bell" style="color: var(--accent);"></i> Recent Activity</h3>
                    <div class="activity-list">
                        <div class="activity-item">
                            <div class="activity-avatar">JD</div>
                            <div class="activity-content">
                                <div class="activity-text"><strong>John Doe</strong> made a reservation for 4</div>
                                <div class="activity-time">2 minutes ago</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-avatar">SM</div>
                            <div class="activity-content">
                                <div class="activity-text"><strong>Sarah Miller</strong> ordered Truffle Roasted Duck</div>
                                <div class="activity-time">15 minutes ago</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-avatar">RK</div>
                            <div class="activity-content">
                                <div class="activity-text"><strong>Robert Kim</strong> left a 5-star review</div>
                                <div class="activity-time">32 minutes ago</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-avatar">EL</div>
                            <div class="activity-content">
                                <div class="activity-text"><strong>Emma Liu</strong> booked a private dining room</div>
                                <div class="activity-time">1 hour ago</div>
                            </div>
                        </div>
                        <div class="activity-item">
                            <div class="activity-avatar">MC</div>
                            <div class="activity-content">
                                <div class="activity-text"><strong>Michael Chen</strong> placed a catering order</div>
                                <div class="activity-time">2 hours ago</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Orders Table -->
            <div class="dashboard-card fade-in">
                <h3><i class="fas fa-list" style="color: var(--accent);"></i> Recent Orders</h3>
                <div style="overflow-x: auto;">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Items</th>
                                <th>Total</th>
                                <th>Status</th>
                                <th>Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#ORD-2847</td>
                                <td>James Wilson</td>
                                <td>Wagyu Tartare, Lobster Thermidor</td>
                                <td>$103</td>
                                <td><span class="status-badge completed">Completed</span></td>
                                <td>10:42 AM</td>
                            </tr>
                            <tr>
                                <td>#ORD-2846</td>
                                <td>Anna Peterson</td>
                                <td>Scallops, Chocolate Soufflé</td>
                                <td>$64</td>
                                <td><span class="status-badge pending">Preparing</span></td>
                                <td>10:38 AM</td>
                            </tr>
                            <tr>
                                <td>#ORD-2845</td>
                                <td>David Brooks</td>
                                <td>Duck Breast, Mushroom Risotto</td>
                                <td>$82</td>
                                <td><span class="status-badge completed">Completed</span></td>
                                <td>10:25 AM</td>
                            </tr>
                            <tr>
                                <td>#ORD-2844</td>
                                <td>Lisa Chang</td>
                                <td>Lobster Thermidor (x2)</td>
                                <td>$130</td>
                                <td><span class="status-badge pending">Preparing</span></td>
                                <td>10:15 AM</td>
                            </tr>
                            <tr>
                                <td>#ORD-2843</td>
                                <td>Mark Johnson</td>
                                <td>Scallops, Duck Breast</td>
                                <td>$90</td>
                                <td><span class="status-badge cancelled">Cancelled</span></td>
                                <td>10:02 AM</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="contact-section" id="contact">
        <div class="contact-container">
            <div class="contact-info fade-in">
                <span class="section-label">Get In Touch</span>
                <h2>Reserve Your Table</h2>
                <p>Ready to experience the finest dining? Book your table or reach out to us for private events, catering, or any inquiries.</p>
                
                <div class="contact-details">
                    <div class="contact-detail">
                        <div class="contact-detail-icon"><i class="fas fa-map-marker-alt"></i></div>
                        <div>
                            <h4>Location</h4>
                            <p>123 Gourmet Avenue, Culinary District<br>New York, NY 10001</p>
                        </div>
                    </div>
                    <div class="contact-detail">
                        <div class="contact-detail-icon"><i class="fas fa-phone"></i></div>
                        <div>
                            <h4>Phone</h4>
                            <p>+1 (212) 555-0199</p>
                        </div>
                    </div>
                    <div class="contact-detail">
                        <div class="contact-detail-icon"><i class="fas fa-envelope"></i></div>
                        <div>
                            <h4>Email</h4>
                            <p>reservations@noirbistro.com</p>
                        </div>
                    </div>
                    <div class="contact-detail">
                        <div class="contact-detail-icon"><i class="fas fa-clock"></i></div>
                        <div>
                            <h4>Hours</h4>
                            <p>Mon - Thu: 5:00 PM - 10:00 PM<br>Fri - Sun: 5:00 PM - 11:00 PM</p>
                        </div>
                    </div>
                </div>

                <div class="social-links">
                    <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="social-link"><i class="fab fa-yelp"></i></a>
                </div>
            </div>

            <div class="contact-form fade-in" id="contactForm">
                <form id="reservationForm" onsubmit="handleSubmit(event)">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">First Name</label>
                            <input type="text" id="firstName" name="firstName" placeholder="John" required>
                        </div>
                        <div class="form-group">
                            <label for="lastName">Last Name</label>
                            <input type="text" id="lastName" name="lastName" placeholder="Doe" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" placeholder="john@example.com" required>
                    </div>
                    <div class="form-group">
                        <label for="phone">Phone Number</label>
                        <input type="tel" id="phone" name="phone" placeholder="+1 (555) 000-0000" required>
                    </div>
                    <div class="form-row">
                        <div class="form-group">
                            <label for="date">Reservation Date</label>
                            <input type="date" id="date" name="date" required>
                        </div>
                        <div class="form-group">
                            <label for="time">Preferred Time</label>
                            <select id="time" name="time" required>
                                <option value="">Select time</option>
                                <option value="17:00">5:00 PM</option>
                                <option value="17:30">5:30 PM</option>
                                <option value="18:00">6:00 PM</option>
                                <option value="18:30">6:30 PM</option>
                                <option value="19:00">7:00 PM</option>
                                <option value="19:30">7:30 PM</option>
                                <option value="20:00">8:00 PM</option>
                                <option value="20:30">8:30 PM</option>
                                <option value="21:00">9:00 PM</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="guests">Number of Guests</label>
                        <select id="guests" name="guests" required>
                            <option value="">Select guests</option>
                            <option value="1">1 Guest</option>
                            <option value="2">2 Guests</option>
                            <option value="3">3 Guests</option>
                            <option value="4">4 Guests</option>
                            <option value="5">5 Guests</option>
                            <option value="6">6 Guests</option>
                            <option value="7+">7+ Guests</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="message">Special Requests (Optional)</label>
                        <textarea id="message" name="message" placeholder="Any dietary restrictions, special occasions, or seating preferences..."></textarea>
                    </div>
                    <button type="submit" class="submit-btn" id="submitBtn">
                        <i class="fas fa-paper-plane"></i> Reserve Table
                    </button>
                </form>

                <div class="form-success" id="formSuccess">
                    <i class="fas fa-check-circle"></i>
                    <h3>Reservation Confirmed!</h3>
                    <p>Thank you for choosing Noir Bistro. We've sent a confirmation to your email. We look forward to serving you!</p>
                    <br>
                    <button class="btn-primary" onclick="resetForm()" style="margin-top: 1rem;">
                        <i class="fas fa-plus"></i> Make Another Reservation
                    </button>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-brand">
                <a href="#" class="logo">Noir Bistro</a>
                <p>Experience the art of fine dining. Where every meal is a masterpiece and every visit is unforgettable.</p>
            </div>
            <div class="footer-column">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="#home">Home</a></li>
                    <li><a href="#menu">Menu</a></li>
                    <li><a href="#dashboard">Dashboard</a></li>
                    <li><a href="#contact">Reservations</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Services</h4>
                <ul>
                    <li><a href="#">Private Dining</a></li>
                    <li><a href="#">Catering</a></li>
                    <li><a href="#">Events</a></li>
                    <li><a href="#">Gift Cards</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h4>Legal</h4>
                <ul>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
                    <li><a href="#">Cookie Policy</a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2026 Noir Bistro. All rights reserved. Crafted with passion.</p>
        </div>
    </footer>

    <script>
        // Scroll Animations
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => observer.observe(el));

        // Navbar scroll effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.style.background = 'rgba(10, 10, 15, 0.95)';
            } else {
                navbar.style.background = 'rgba(10, 10, 15, 0.85)';
            }
        });

        // Active nav link
        const sections = document.querySelectorAll('section[id]');
        const navLinks = document.querySelectorAll('.nav-links a');

        window.addEventListener('scroll', () => {
            let current = '';
            sections.forEach(section => {
                const sectionTop = section.offsetTop;
                if (scrollY >= sectionTop - 200) {
                    current = section.getAttribute('id');
                }
            });

            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === '#' + current) {
                    link.classList.add('active');
                }
            });
        });

        // Dashboard Tabs
        function switchTab(btn, tab) {
            document.querySelectorAll('.dashboard-tab').forEach(t => t.classList.remove('active'));
            btn.classList.add('active');
            // In a real app, this would switch content
        }

        // Contact Form
        function handleSubmit(e) {
            e.preventDefault();
            const btn = document.getElementById('submitBtn');
            const originalText = btn.innerHTML;
            
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            btn.disabled = true;
            
            setTimeout(() => {
                document.getElementById('reservationForm').style.display = 'none';
                document.getElementById('formSuccess').style.display = 'block';
                btn.innerHTML = originalText;
                btn.disabled = false;
            }, 1500);
        }

        function resetForm() {
            document.getElementById('reservationForm').reset();
            document.getElementById('reservationForm').style.display = 'block';
            document.getElementById('formSuccess').style.display = 'none';
        }

        // Set min date to today
        const dateInput = document.getElementById('date');
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);

        // Mobile menu toggle
        document.querySelector('.mobile-menu-btn').addEventListener('click', () => {
            const navLinks = document.querySelector('.nav-links');
            navLinks.style.display = navLinks.style.display === 'flex' ? 'none' : 'flex';
            navLinks.style.position = 'absolute';
            navLinks.style.top = '70px';
            navLinks.style.left = '0';
            navLinks.style.right = '0';
            navLinks.style.flexDirection = 'column';
            navLinks.style.background = 'var(--bg-primary)';
            navLinks.style.padding = '2rem';
            navLinks.style.borderBottom = '1px solid var(--border)';
        });
    </script>
</body>
</html>'''

# Save the file
output_path = '/mnt/agents/output/noir_bistro_restaurant.html'
with open(output_path, 'w', encoding='utf-8') as f:
    f.write(html_content)

print(f"✅ Restaurant website saved successfully!")
print(f"📁 File: {output_path}")
print(f"📊 Size: {len(html_content):,} characters")
