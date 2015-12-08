<%@ page import="com.bcgogo.config.ConfigController" %>
<%--
  Created by IntelliJ IDEA.
  User: Sally_Ma
  Date: 14-2-17
  Time: 上午9:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--<title>发送售后回访短信的帮助</title>--%>
    <link type="text/css" rel="stylesheet" href="styles/prompt_box<%=ConfigController.getBuildVersion()%>.css" />
</head>
<body>
<div class="prompt_box">
    <div class="title">
        <div id="helpTurnOff" class="turn_off"></div>
        发送售后回访APP短信</div>
    <div class="content">
        <p> 客户安装手机APP，可免费发送APP短信，店面与客户实
            时互动，共享打印单，帮助客户及时了解车况，查询违
            章，节省油费等。</p>
        <div class="prompt_img"><img src="images/ewm_r6_c2.jpg"/></div>
        <div class="prompt_txt">手机扫描二维码快速下载 <br />
            <a style="cursor:pointer" onclick="toHelper('appInstallHelper')">更多安装帮助</a></div>
        <div class="clear"></div>
        <div class="wid275">
            <a class="blue_color" href="download.do?method=downloadStaticFile&relativePath=downloadFile/apk/PreLoginActivity_20140228_0921.apk&fileName=PreLoginActivity">
                <div class="download_btn"></div>
            </a>
        </div>
        <div class="clear"></div>
    </div>
</div>

</body>
</html>