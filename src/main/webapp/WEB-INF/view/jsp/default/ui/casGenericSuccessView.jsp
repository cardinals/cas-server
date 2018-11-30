<!DOCTYPE html>

<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />

  <title>统一登录认证</title>

  <meta name="_csrf" content="${_csrf.token}"/>
  <meta name="_csrf_header" content="${_csrf.headerName}"/>


  <spring:theme code="standard.custom.css.file" var="customCssFile" />
  <link rel="stylesheet" href="<c:url value="${customCssFile}" />" />
  <link rel="icon" href="<c:url value="/favicon.ico" />" type="image/x-icon" />

</head>
<body id="cas">

<div id="container">
  <header style=" padding-top: 60px;">
    <h1 style="color: white;font-family: 微软雅黑">云南省自然资源厅智能审批系统</h1>
  </header>
  <div id="content">

  <div id="msg" class="success">
    <h2><spring:message code="screen.success.header" /></h2>
    <p>恭喜！您已经成功登录统一登录认证系统。</p>
    <p>出于安全考虑，一旦您访问过那些需要登录验证的系统时，请操作完成之后关闭浏览器。</p>
  </div>
<jsp:directive.include file="includes/bottom.jsp" />

