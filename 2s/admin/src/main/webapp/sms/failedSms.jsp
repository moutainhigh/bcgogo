﻿<%@ page language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>后台管理系统——短信发送失败管理</title>
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
    <script type="text/javascript" src="js/failedSms.js"></script>
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
            <!--搜索-->
            <div class="rightText">
                <div class="textLeft"></div>
                <div class="textBody"><input type="text" value="店铺名" id="txt_shopName"/></div>
                <div class="textRight"></div>
            </div>
            <div class="rightText">
                <div class="textLeft"></div>
                <div class="textBody"><input type="text" value="店主" id="txt_shopOwner"/></div>
                <div class="textRight"></div>
            </div>
            <div class="rightText">
                <div class="textLeft"></div>
                <div class="textAddressbody"><input type="text" value="地址" id="txt_address"/></div>
                <div class="textRight"></div>
            </div>
            <div class="rightText">
                <div class="textLeft"></div>
                <div class="textBody"><input type="text" value="手机/电话" id="txt_phone"/></div>
                <div class="textRight"></div>
            </div>
            <input type="button" class="rightSearch" value="搜 索"/>
            <!--搜索结束-->
            <!--内容-->
            <div class="rightMain clear">
                <div class="rightTitle">
                    <div class="rightLeft"></div>
                    <div class="rightBody">
                        <div class="titleHover" id="failedSms"><a href="sms.do?method=initFailedSmsPage">短信发送失败管理</a></div>
                        <div class="titleHover" id="sensitiveWordsUpload"><a href="sms.do?method=initUploadSensitiveWordsPage">敏感词上传</a></div>
                        <div class="titleHover" id="sensitiveWordsManager"><a href="sms.do?method=initSensitiveWordPage">敏感词管理</a></div>
                        <div class="titleHover" id="toTestStopWords"><a href="sms.do?method=toTestStopWords">联逾短信</a></div>
                    </div>
                </div>
                <div class="fileInfo">
    <div  id="systemConfig_form"  class="systemConfig_form">
      <div>
          <label style="float:left;">查询条件 </label>

           <div style="float:left;">店面名称<input id="shop_name" type="text" tabindex="6" autocomplete="off" />
          </div>
          <div style="float:left;">手机号码<input id="mobile" type="text" tabindex="6" autocomplete="off"  />
          </div>
           <div style="float:left;">发送内容<input id="content" type="text" tabindex="6" autocomplete="off" />
          </div>
          <div style="float:left;">
              <input type="button" id="configSearchBtn" onfocus="this.blur();" value="查询" onclick="searchFailedSms()"/>
          </div>
    </div>
       <div class="clear"></div>
        <br/>
         <div>
         <table cellpadding="0" cellspacing="0" class="config_table" id="table_smsFailedJob" width="830px">
             <col width="30">
             <col width="100">
             <col width="100">
             <col width="300">
             <col width="100">
             <col width="110">
              <col width="110">
         <tr class="dm_table_title">
             <td style="border-left:none;">编号</td>
             <td>店面名称</td>
             <td>手机号码</td>
             <td>发送内容</td>
             <td>状态</td>
             <td>发送失败原因</td>
              <td>操作</td>
         </tr>
        </table>
       </div>
        <div>
            <div class="simplePageAJAX" style="font-size:12px;">
                <jsp:include page="/common/pageAJAX.jsp">
                    <jsp:param name="url" value="sms.do?method=failedSmsList"></jsp:param>
                    <jsp:param name="data" value="{startPageNo:1}"></jsp:param>
                    <jsp:param name="jsHandleJson" value="initFailedSmsJobTable"></jsp:param>
                    <jsp:param name="dynamical" value="dynamical1"></jsp:param>
                </jsp:include>
            </div>
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
   <div id="setLocation"   style="position: fixed; left: 37%; top: 37%;  z-index: 8; display: none;">
        <jsp:include page="editSms.jsp"></jsp:include>
    </div>

</body>
</html>
