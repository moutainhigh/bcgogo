<%@ page import="com.bcgogo.config.ConfigController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/includes.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>入库打印单</title>
    <link rel="stylesheet" type="text/css" href="styles/style<%=ConfigController.getBuildVersion()%>.css"/>
    <link rel="stylesheet" type="text/css" href="styles/print<%=ConfigController.getBuildVersion()%>.css"/>
    <link rel="stylesheet" type="text/css" href="styles/printShow<%=ConfigController.getBuildVersion()%>.css"/>
    <script type="text/javascript" src="js/extension/jquery/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="js/base<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/application<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript">
        $().ready(function () {
            window.print();
            window.close();
        });

    </script>
</head>
<body class="bodyMain">
<!--内容-->
<div class="print_cont">
    <h3>${purchaseInventoryDTO.shopName}</h3>
    <!--第一部分-->
    <div class="i_searchTitle pruch clear">
        <label class="danju">单据号:</label>
        <label class="receipt danju">${purchaseInventoryDTO.id}</label>
        <label>入库单</label>
        <label class="zhidan">制单时间：${purchaseInventoryDTO.editDateStr}</label>
    </div>
    <!--第一部分结束-->

    <!--第二部分-->
    <%--<div class="print_info pruch_use clear">--%>
    <%--<label>供应商:</label><span>${purchaseInventoryDTO.supplier}</span><label>联系人:</label><span>${purchaseInventoryDTO.contact}</span><label>联系电话:</label><span class="non_pruch">${purchaseInventoryDTO.mobile}</span> <label>地址:</label><span class="address_show">${purchaseInventoryDTO.address}</span>--%>
    <%--<div class="clear"></div>--%>
    <%--</div>--%>

    <table class="pruch_tab">
        <col width="50"/>
        <col width="85" style="width:83px\9;"/>
        <col width="55"/>
        <col width="80"/>
        <col width="65"/>
        <col width="110"/>
        <col width="40"/>
        <col/>
        <tr>
            <td>供应商:</td>
            <td>${purchaseInventoryDTO.supplier}</td>
            <td>联系人:</td>
            <td>${purchaseInventoryDTO.contact}</td>
            <td>联系电话:</td>
            <td>${purchaseInventoryDTO.mobile}</td>
            <td>地址:</td>
            <td>${purchaseInventoryDTO.address}</td>
        </tr>
    </table>


    <!--施工单-->
    <table cellpadding="0" cellspacing="0" class="table2">
        <col width="85" style="width:90px\9;"/>
        <col width="100" style="width:80px\9;"/>
        <col width="90" style="width:80px\9;"/>
        <col width="90" style="width:80px\9;"/>
        <col width="85" style="width:80px\9;"/>
        <col width="80" style="width:80px\9;"/>
        <col width="50" style="width:40px\9;"/>
        <col width="55"/>
        <col width="40"/>
        <col width="60"/>

        <tr class="table_title">
            <td>商品编号</td>
            <td>品名</td>
            <td>品牌</td>
            <td>规格</td>
            <td>型号</td>
            <td>车型</td>
            <td>单价</td>
            <td>数量</td>
            <td>单位</td>
            <td>小计</td>
        </tr>
        <c:forEach items="${purchaseInventoryDTO.itemDTOs}" var="itemDTO" varStatus="status">
            <tr>
                <td>${status.index+1}</td>
                <td>${itemDTO.productName}</td>
                <td>${itemDTO.brand}</td>
                <td>${itemDTO.spec}</td>
                    <%--<c:if test='${""!=itemDTO.spec&&""!=itemDTO.model}'>,</c:if>${itemDTO.model}</td>--%>
                <td>${itemDTO.model}</td>
                    <%--<td>${itemDTO.vehicleBrand}</td>--%>
                <td>${itemDTO.vehicleInfo}</td>
                    <%--<td>${itemDTO.vehicleYear}</td>--%>
                    <%--<td>${itemDTO.vehicleEngine}</td>--%>
                <td>${itemDTO.price}</td>
                <td>${itemDTO.amount}</td>
                <td>${itemDTO.unit}</td>
                <td>${itemDTO.total}</td>
                    <%--<td>${itemDTO.memo}</td>--%>
            </tr>
        </c:forEach>
        <tr>
            <td>合计</td>
            <td colspan="2">${purchaseInventoryDTO.total}¥</td>
            <td>合计(大写)：</td>
            <td colspan="6" class="font_set">${purchaseInventoryDTO.totalStr}</td>
        </tr>
    </table>
    <div class="clear" style="height:10px;"></div>
    <div>备注：${purchaseInventoryDTO.memo}</div>
    <!--施工单结束-->
    <div class="qianzi clear">
        <span class="print_num" style="width:181px;*width:190px;">入库人签字：<label></label></span>

        <div>店长签字：<label></label></div>
    </div>
    <div>
        <div class=" time_pr">日期：<label></label></div>
        <div class=" time_pr time_pint">(盖章)</div>

    </div>
    <div class="address clear">
        <div class=" time time_p"><span>地址：</span><label>${purchaseInventoryDTO.shopAddress}</label></div>
        <div class=" phone_time">电话：<label>${purchaseInventoryDTO.shopLandLine}
            <c:if test="${storeManagerMobile != null && storeManagerMobile !=''}">
                <c:if test="${purchaseInventoryDTO.shopLandLine != null && purchaseInventoryDTO.shopLandLine!=''}">
                    ,
                </c:if>
                ${storeManagerMobile}
            </c:if>
        </label></div>
    </div>
    <div class="clear"></div>
</div>
<!--内容结束-->
</body>
</html>
