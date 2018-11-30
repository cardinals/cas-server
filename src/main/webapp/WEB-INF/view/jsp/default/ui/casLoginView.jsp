<!DOCTYPE html>

<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <title>统一登录认证</title>

    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>


    <spring:theme code="standard.custom.css.file" var="customCssFile"/>
    <link rel="stylesheet" href="<c:url value="${customCssFile}" />"/>
    <link rel="stylesheet" href="<c:url value="/css/jquery.autocomplete.css " />"/>
    <link rel="icon" href="<c:url value="/favicon.ico" />" type="image/x-icon"/>
    <style type="text/css">
        .input-group {
            padding-bottom: 20px;
            padding-left: 50px;
            padding-right: 50px;
        }

        h3 {
            padding: 5px;
            border-bottom: 1px solid #ddd;
        }

        li {
            list-style-type: square;
        }

        em {
            font-style: inherit;
            background-color: #f9f2f4;
        }
        .form-control{
            border-bottom: 1px solid #ccc;
            border-top:none;
            border-left:none;
            border-right:none;
            background: none;
            -webkit-box-shadow: none ;
            -moz-box-shadow: none ;
            box-shadow: none ;
        }
        .input-group-addon{
            border-bottom: 1px solid #ccc;
            border-top:none;
            border-left:none;
            border-right:none;
            background: none;
        }
        .input-group-addon img{
            height: 24px;
            width: 24px;
        }
    </style>
    <script type="text/javascript" src="<c:url value="/js/jquery.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery.autocomplete.min.js"/>"></script>
</head>
<body id="cas">

<header id="logo">
</header>
<div id="container">
    <div id="content">


        <c:if test="${not empty registeredService}">
            <c:set var="registeredServiceLogo" value="images/webapp.png"/>
            <c:set var="registeredServiceName" value="${registeredService.name}"/>
            <c:set var="registeredServiceDescription" value="${registeredService.description}"/>

            <c:choose>
                <c:when test="${not empty mduiContext}">
                    <c:if test="${not empty mduiContext.logoUrl}">
                        <c:set var="registeredServiceLogo" value="${mduiContext.logoUrl}"/>
                    </c:if>
                    <c:set var="registeredServiceName" value="${mduiContext.displayName}"/>
                    <c:set var="registeredServiceDescription" value="${mduiContext.description}"/>
                </c:when>
                <c:when test="${not empty registeredService.logo}">
                    <c:set var="registeredServiceLogo" value="${registeredService.logo}"/>
                </c:when>
            </c:choose>

        </c:if>


        <div id="serviceui" class="serviceinfo">
            <p style="font-family: 微软雅黑;font-size: 24px;text-align: center;"><spring:message
                    code="screen.login.title"/></p>
        </div>
        <%-- <div class="box" id="login">
             <form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">

                 <form:errors path="*" id="msg" cssClass="errors" element="div" htmlEscape="false"/>
                 <section class="row">
                     <label for="username"><spring:message code="screen.welcome.label.netid"/></label>
                     <c:choose>
                         <c:when test="${not empty sessionScope.openIdLocalId}">
                             <strong><c:out value="${sessionScope.openIdLocalId}"/></strong>
                             <input type="hidden" id="username" name="username"
                                    value="<c:out value="${sessionScope.openIdLocalId}" />"/>
                         </c:when>
                         <c:otherwise>
                             <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey"/>
                             <form:input cssClass="required" cssErrorClass="error" id="username" size="25" tabindex="1"
                                         accesskey="${userNameAccessKey}" path="username" autocomplete="off"
                                         htmlEscape="true"/>
                         </c:otherwise>
                     </c:choose>
                 </section>

                 <section class="row">
                     <label for="password"><spring:message code="screen.welcome.label.password"/></label>
                         &lt;%&ndash;
                         NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
                         "autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
                         information, see the following web page:
                         http://www.technofundo.com/tech/web/ie_autocomplete.html
                         &ndash;%&gt;
                     <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey"/>
                     <form:password cssClass="required" cssErrorClass="error" id="password" size="25" tabindex="2"
                                    path="password" accesskey="${passwordAccessKey}" htmlEscape="true"
                                    autocomplete="off"/>
                     <span id="capslock-on" style="display:none;"><p><img src="images/warning.png"
                                                                          valign="top"> <spring:message
                             code="screen.capslock.on"/></p></span>
                 </section>

                 <!--
                 <section class="row check">
                 <p>
                 <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message
                     code="screen.welcome.label.warn.accesskey"/>" type="checkbox" />
                 <label for="warn"><spring:message code="screen.welcome.label.warn"/></label>
                 <br/>
                 <input id="publicWorkstation" name="publicWorkstation" value="false" tabindex="4" type="checkbox" />
                 <label for="publicWorkstation"><spring:message code="screen.welcome.label.publicstation"/></label>
                 <br/>
                 <input type="checkbox" name="rememberMe" id="rememberMe" value="true" tabindex="5" />
                 <label for="rememberMe"><spring:message code="screen.rememberme.checkbox.title"/></label>
                 </p>
                 </section>
                 -->

                 <section class="row btn-row">

                     <input type="hidden" name="execution" value="${flowExecutionKey}"/>
                     <input type="hidden" name="_eventId" value="submit"/>

                     <input class="btn-submit" name="submit" accesskey="l"
                            value="<spring:message code="screen.welcome.button.login" />" tabindex="6" type="submit"/>
                     <input class="btn-reset" name="reset" accesskey="c"
                            value="<spring:message code="screen.welcome.button.clear" />" tabindex="7" type="reset"/>
                 </section>
             </form:form>

             <div id="sidebar">
                 <div class="sidebar-content">
                     <c:if test="${!empty pac4jUrls}">
                         <div id="list-providers">
                             <h3><spring:message code="screen.welcome.label.loginwith"/></h3>
                             <form>
                                 <ul>
                                     <c:forEach var="entry" items="${pac4jUrls}">
                                         <li><a href="${entry.value}">${entry.key}</a></li>
                                     </c:forEach>
                                 </ul>
                             </form>
                         </div>
                     </c:if>
                 </div>
             </div>

         </div>--%>

        <div class="row" style="margin-top:30px;">
            <div class="col-md-12">
                <form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">
                    <div class="input-group input-group-md"><span class="input-group-addon"><img src="<c:url value="/images/usr.png"/>"/></span><input type="text"
                                                                                                  class="form-control"
                                                                                                  placeholder="请输入姓名"
                                                                                                  style="height: 50px"
                                                                                                  id="username" name="username"
                                                                                                   >

                    </div>
                    <div class="input-group input-group-md"><span class="input-group-addon"><img src="<c:url value="/images/lock.png"/>"/></span><input type="password" class="form-control"
                                                                               placeholder="请输入密码"
                                                                               style="height: 50px"
                                                                               id="password" name="password"
                                                                               ></div>
                   <%-- <div class="input-group input-group-md">
                        <input type="checkbox" name="rememberMe" id="rememberMe" value="true" tabindex="5" />
                        <label for="rememberMe"><spring:message code="screen.rememberme.checkbox.title"/></label>
                    </div>--%>
                    <div class="input-group input-group-md" style="padding-bottom: 40px">
                        <div class="col-md-3">
                            <label for="authcode"  style="height: 50px;padding-top: 22.5px"><spring:message code="screen.welcome.label.authcode" /></label>
                            <spring:message code="screen.welcome.label.authcode.accesskey" var="authcodeAccessKey" />
                        </div>
                        <div class="col-md-6">
                            <form:input class="form-control"  style="height: 50px" cssErrorClass="error" id="authcode" size="10" tabindex="2" path="authcode"
                                        accesskey="${authcodeAccessKey}" htmlEscape="true" autocomplete="off" />
                        </div>
                        <div class="col-md-3">
                            <img onclick="this.src='captcha.jpg?'+Math.random()"  style="cursor: pointer;width: 100px;height: 50px;margin-left: -10px" src="captcha.jpg">
                        </div>

                    </div>
                    <input type="hidden" id="humanid" name="humanid"/>


                    <input type="hidden" name="lt" value="${loginTicket}" />
                    <input type="hidden" name="execution" value="${flowExecutionKey}" />

                    <input type="hidden" name="_eventId" value="submit" />
                    <form:errors path="*" id="msg" cssClass="errors" element="div" htmlEscape="false"/>
                    <button type="submit" class="btn btn-primary btn-block"
                            style="width: 50%;margin: auto;border-radius: 80px;background-image: url(images/loginBtn.png);">登录
                    </button>
                </form:form>
            </div>
        </div>

    </div> <!-- END #container -->
    <footer>
        <div id="copyright" class="container">
            <%--<p><spring:message code="copyright" /></p>
                <p>Powered by <a href="http://www.apereo.org/cas">
                    Apereo Central Authentication Service <%=org.jasig.cas.CasVersion.getVersion()%></a>
                    <%=org.jasig.cas.CasVersion.getDateTime()%></p>--%>
        </div>
    </footer>

    <spring:theme code="cas.javascript.file" var="casJavascriptFile" text=""/>
    <script type="text/javascript" src="<c:url value="${casJavascriptFile}" />"></script>
    <script type="text/javascript">
        $("#username").autocomplete("fetchHumanList?action=ajax&count=10",{
            matchSubset:false,
            formatItem: function(row, i, total) {
                return row;
            },
            formatResult: function(row) {
                return row;
            },
            width:$('#username').width()+12 ,
            dataType: 'json'	,
            parse: function(data) {
                var rows = [];
                for(var i=0; i<data.length; i++){
                    rows[rows.length] = {
                        data:data[i].HUMANNAME+"(" + data[i].HUMANCODE + ")",
                        value:data[i].HUMANID,
                        result:data[i].HUMANNAME
                    };
                }
               /* for(var j = 0 ; j < rows.length;j++){
                    for(var k = j+1;k<rows.length;k++){
                        if(rows[j].data == rows[k].data){
                            rows[j].data = (rows[j].data +"(" +rows[j].value + ")");
                            break;
                        }
                    }
                }*/
                return rows;
            }
        }
        ).result(function (event,data,value) {
            $('#humanid').val(value);
        });

        $("#username").change(function () {
            $('#humanid').val('');
        });
    </script>
</body>
</html>

