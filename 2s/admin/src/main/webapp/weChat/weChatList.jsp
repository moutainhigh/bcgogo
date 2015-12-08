<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>后台管理系统——微信管理</title>
    <link rel="stylesheet" type="text/css" href="styles/dataMaintenance.css"/>
    <link rel="stylesheet" type="text/css" href="styles/backstage.css"/>
    <link rel="stylesheet" type="text/css" href="styles/backAgent.css"/>
    <link rel="stylesheet" type="text/css" href="styles/storesMange.css"/>
    <link rel="stylesheet" type="text/css" href="styles/style.css"/>
    <%@include file="/WEB-INF/views/style-thirdpartLibs.jsp"%>

    <%@include file="/WEB-INF/views/script-thirdpartLibs.jsp"%>
    <script type="text/javascript" src="js/extension/jquery/plugin/jquery.form.js"></script>
    <script type="text/javascript" src="js/extension/jquery/plugin/jquery.validate.js"></script>
    <%@include file="/WEB-INF/views/script-common.jsp"%>
    <script type="text/javascript" src="js/bcgogo.js"></script>
    <script type="text/javascript" src="js/wxArticle.js"></script>
    <script type="text/javascript" src="js/mask.js"></script>
</head>
<body>
<div class="main">
    <!--头部-->
    <%@include file="/WEB-INF/views/header.jsp" %>
    <!--头部结束-->
    <div class="body">
        <!--左侧列表-->
        <%@include file="/WEB-INF/views/left.jsp" %>
        <!--左侧列表结束-->
        <!--右侧内容-->
        <div class="bodyRight">

            <!--内容-->
            <div class="rightMain clear">
                <%@include file="/weChat/wxNav.jsp"%>
                <div class="fileInfo">
                    <div  id="systemConfig_form"  class="systemConfig_form">
                        <div>
                            <label style="float:left;margin-right: 10px">查询条件: </label>

                            <div style="float:left;">标题<input id="title" type="text" tabindex="6" autocomplete="off"  />
                            </div>
                            <div style="float:left;">正文<input id="description" type="text" tabindex="6" autocomplete="off" />
                            </div>
                            <div style="float:left;">
                                <input type="button" id="configSearchBtn" onfocus="this.blur();" value="查询" onclick="searchWeChat()"/>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <br/>
                        <div>
                            <table cellpadding="0" cellspacing="0" class="config_table" id="table_WXJob" width="830px">
                                <col width="30">
                                <col width="100">
                                <col width="100">
                                <col width="300">
                                <col width="210">
                                <tr class="dm_table_title">
                                    <td style="border-left:none;">编号</td>
                                    <td>标题</td>
                                    <td>图片地址</td>
                                    <td>正文</td>
                                    <td>操作</td>
                                </tr>
                            </table>
                        </div>
                        <div>
                            <div class="simplePageAJAX" style="font-size:12px;">
                                <jsp:include page="/common/pageAJAX.jsp">
                                    <jsp:param name="url" value="weChat.do?method=weChatList"></jsp:param>
                                    <jsp:param name="data" value="{startPageNo:1}"></jsp:param>
                                    <jsp:param name="jsHandleJson" value="inintTable_WXJob"></jsp:param>
                                    <jsp:param name="dynamical" value="dynamical1"></jsp:param>
                                </jsp:include>
                            </div>
                        </div>

                        <div>
                            <img width="100" class="J_wx_article_img_show">
                        </div>

                    </div>
                </div>
                <!--内容结束-->
            </div>
            <!--内容结束-->
            <!--圆角-->
            <div class="bottom_crile clear">
                <div class="crile"></div>
                <div class="bottom_x"></div>
                <div style="clear:both;"></div>
            </div>
            <!--圆角结束-->
        </div>
        <!--右侧内容结束-->
    </div>
</div>
<ul class="suggestionMain" style="list-style: none;color:#000000;">
</ul>
<div id="mask" style="display:block;position: absolute;">
</div>
<%--<div id="setLocation"   style="position: fixed; left: 37%; top: 37%;  z-index: 8; display: none;">--%>
    <%--<jsp:include page="sms/editSms.jsp"></jsp:include>--%>
<%--</div>--%>
</body>
</html>