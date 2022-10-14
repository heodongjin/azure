<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>G1 CMS4 - Azure Alert</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="/assets/img/logo.png" rel="icon">
<link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
<link href="/assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="/assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">

<!-- Template Main CSS File -->
<link href="/assets/css/style.css" rel="stylesheet">

<script src="/assets/js/jquery-3.3.1.js"></script>

<style>
.sb {
	min-width: 20%;
}

#tableModal th {
	position: sticky;
	top: 0px;
	background-color: #afb5bb;
}

.right-box {
  float: right;
  flex-wrap: wrap;
}

</style>

</head>

<body id="body">

	<!-- ======= Header ======= -->
	<header id="header" class="header fixed-top d-flex align-items-center">
		<div class="d-flex align-items-center justify-content-between">
			<a href="index.html" class="logo d-flex align-items-center">
				<img src="/assets/img/logo.png" alt="">
				<span class="d-none d-lg-block">G1 CMS4</span>
			</a>
			<i class="bi bi-list toggle-sidebar-btn"></i>
		</div>
		<!-- End Logo -->
	</header>
	<!-- End Header -->

	<!-- ======= Sidebar ======= -->
	<aside id="sidebar" class="sidebar">
		<ul class="sidebar-nav" id="sidebar-nav">
			<!-- customer Nav -->
			<li class="nav-item">
				<a class="nav-link" data-bs-target="#components-nav" data-bs-toggle="collapse" href="#">
					<img src="/assets/img/client.jpg" style="width: 20px; height: 20px;" alt=""><span>고객사</span>
					<i class="bi bi-chevron-down ms-auto"></i>
				</a>
				<ul id="components-nav" class="nav-content collapse show" data-bs-parent="#sidebar-nav">
					<li>
						<a href="javascript:customerList('sldt');" <c:if test="${params.customerName eq 'sldt' || params.customerName eq null }">class="active"</c:if>>
							<i class="bi bi-circle"></i>
							<span>솔드아웃</span>
						</a>
					</li>
					<li>
						<a href="javascript:customerList('doopedia');" <c:if test="${params.customerName eq 'doopedia' }">class="active"</c:if>> 
							<i class="bi bi-circle"></i>
							<span>두산두피디아</span>
						</a>
					</li>
					<li>
						<a href="javascript:customerList('autoever');" <c:if test="${params.customerName eq 'autoever' }">class="active"</c:if>>
							<i class="bi bi-circle"></i>
							<span>현대오토에버-시큐리티존</span>
						</a>
					</li>
					<li>
						<a href="javascript:customerList('kbhealth');" <c:if test="${params.customerName eq 'kbhealth' }">class="active"</c:if>>
							<i class="bi bi-circle"></i>
							<span>KB헬스케어</span>
						</a>
					</li>
					<li>
						<a href="javascript:customerList('fsec');" <c:if test="${params.customerName eq 'fsec' }">class="active"</c:if>>
							<i class="bi bi-circle"></i>
							<span>금융보안원</span>
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</aside>
	<!-- End Sidebar-->