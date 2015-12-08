<%--
  Created by IntelliJ IDEA.
  User: MZDong
  Date: 11-9-21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ include file="/WEB-INF/views/includes.jsp" %>

<html>
<head>
    <title>Add User</title>
</head>

<body>

<form:form commandName="userDTO"  action="user.do?method=saveuser" method="post">

    <table cellspacing="0" cellpadding="6" border="0">
        <tbody>
        <tr>
            <td colspan="2" style="background:#cccccc; ">
                <div align="center"><span>Register</span></div>
            </td>
        </tr>
        <tr>
            <td align="left">No:</td>
            <td align="left"><form:hidden path="shopId" value="${userDTO.shopId}"></form:hidden><form:hidden path="id" value="${userDTO.id}"></form:hidden><form:input path="userNo" size="14" value="${userDTO.userNo}"/></td>
        </tr>
        <tr>
            <td align="left">UserName:</td>
            <td align="left"><form:input path="userName" size="14" value="${userDTO.userName}"/></td>
        </tr>
        <tr>
            <td align="left">Password:</td>
            <td align="left"><form:password path="password" size="14" value="${userDTO.password}"/></td>
        </tr>
        <tr>
            <td align="left">Name:</td>
            <td align="left"><form:input path="name" size="14" value="${userDTO.name}"/></td>
        </tr>
        <tr>
            <td align="left">LoginTimes:</td>
            <td align="left"><form:input path="loginTimes" size="14" value="${userDTO.loginTimes}"/></td>
        </tr>
        <tr>
            <td align="left">LastTime:</td>
            <td align="left"><form:input path="lastTime" size="14" value="${userDTO.lastTime}"/></td>
        </tr>
        <tr>
            <td align="left">Email:</td>
            <td align="left"><form:input path="email" size="14" value="${userDTO.email}"/></td>
        </tr>
        <tr>
            <td align="left">Mobile:</td>
            <td align="left"><form:input path="mobile" size="14" value="${userDTO.mobile}"/></td>
        </tr>
        <tr>
            <td align="left">QQ:</td>
            <td align="left"><form:input path="qq" size="14" value="${userDTO.qq}"/></td>
        </tr>
        <tr>
            <td align="left">Memo:</td>
            <td align="left"><form:input path="memo" size="14" value="${userDTO.memo}"/></td>
        </tr>
        <tr>
            <td align="center" colspan="2"><input type="submit" value="submit"/><input type="reset" value="reset"/></td>
        </tr>
        </tbody>
    </table>
</form:form>
</body>
</html>