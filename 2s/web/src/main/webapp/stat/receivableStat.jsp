<%--
  Created by IntelliJ IDEA.
  User: ndong
  Date: 12-10-17
  Time: 上午2:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/includes.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>应收款</title>
    <link rel="stylesheet" type="text/css" href="styles/style<%=ConfigController.getBuildVersion()%>.css"/>
    <link rel="stylesheet" type="text/css" href="styles/statistics<%=ConfigController.getBuildVersion()%>.css"/>
    <link rel="stylesheet" type="text/css" href="styles/salesSlip<%=ConfigController.getBuildVersion()%>.css"/>
    <link rel="stylesheet" type="text/css" href="styles/businessAnalysis<%=ConfigController.getBuildVersion()%>.css"/>
    <%@include file="/WEB-INF/views/header_script.jsp" %>
    <script type="text/javascript" src="js/extension/jquery/plugin/jquery.form.min.js"></script>
    <script type="text/javascript" src="js/dataUtil<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/vehiclenosolrheader<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/utils/tableUtil<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/page/stat/recOrPayStat<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/detailsArrears<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript"
          src="js/statementAccount/statementAccountUtil<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/page/stat/itemStatistics<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/businessAnalysis/businessUtil<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript" src="js/regionSelection<%=ConfigController.getBuildVersion()%>.js"></script>
    <script type="text/javascript">
        defaultStorage.setItem(storageKey.MenuUid, "ARREARS_TO_RECEIVABLE_STAT");
        <bcgogo:permissionParam resourceType="logic" permissions="WEB.VERSION.VEHICLE_CONSTRUCTION,WEB.VERSION.MEMBER_STORED_VALUE">
        APP_BCGOGO.Permission.Version.VehicleConstruction=${WEB_VERSION_VEHICLE_CONSTRUCTION};
        </bcgogo:permissionParam>
    </script>
</head>
<body class="bodyMain">
<%@include file="/WEB-INF/views/header_html.jsp" %>
<div class="i_main clear">
    <div class="mainTitles clear">
    <%--<div class="i_receivableStat">--%>
        <jsp:include page="statNavi.jsp">
            <jsp:param name="currPage" value="recOrPayStat"/>
        </jsp:include>
        <div class="titleWords">应收应付</div>
        <bcgogo:hasPermission
                permissions="WEB.STAT.RECEIVABLE_PAYABLE_STAT.PAYABLE&&WEB.STAT.RECEIVABLE_PAYABLE_STAT.RECEIVABLE">
            <div class="titleList">
                <a id="receivableStatBtn" action-type="menu-click" menu-name="ARREARS_TO_RECEIVABLE_STAT" class="click"
                   href="arrears.do?method=toReceivableStat">应收款</a>
                <a id="payableStatBtn" action-type="menu-click" menu-name="ARREARS_TO_PAYABLE_STAT"
                   href="arrears.do?method=toPayableStat" class="" style="color: #787777;">应付款</a>
            </div>
        </bcgogo:hasPermission>
        </div>
        <div class="i_mainRight">
            <div class="titBody">
                <form:form commandName="recOrPayIndexDTO" id="receivableSearchForm"
                           action="arrears.do?method=getReceivableStatData" method="post"
                           name="thisform">
                    <form:hidden path="startPageNo" value="1"/>
                    <div class="lineTitle">应收款统计搜索</div>
                    <div class="lineBody bodys">
                        <div class="divTit" style="width:100%;">
                            统计日期段：
                            <a class="btnList" id="my_date_thisweek" name="my_date_select">本周</a>&nbsp;
                            <a class="btnList" id="my_date_thismonth" name="my_date_select">本月</a>&nbsp;
                            <a class="btnList" id="my_date_thisyear" name="my_date_select">本年</a>&nbsp;
                            <a class="btnList" id="my_date_self_defining" name="my_date_select">自定义时间段</a>&nbsp;
                            <form:input id="startDate" readonly="true" path="startDateStr" cssClass="my_startdate textbox" style="width:100px"/>&nbsp;
                            至&nbsp;<form:input id="endDate" readonly="true" path="endDateStr" cssClass="my_enddate textbox" style="width:100px"/>
                        </div>
                        <bcgogo:permission>
                            <bcgogo:if resourceType="logic" permissions="WEB.VERSION.VEHICLE_CONSTRUCTION">
                                <div class="divTit">
                                    供应商/客户：&nbsp;<input type="text" style="width:145px;color:#ADADAD" class="customerOrSupplierName textbox"
                                                        autocomplete="off" initialValue="供应商/客户" value="供应商/客户" pagetype="inquiryCenter"
                                                        name="customerOrSupplierName" id="customer_supplierInfoText" />&nbsp;<input type="text" readonly="readonly" style="width:85px;color:#ADADAD" class="mobile textbox" pagetype="payableStat"
                                                                                                                                    initialValue="手机号" value="手机号"
                                                                                                                                    id="mobile" name="contactNum" />
                                </div>
                                <div class="divTit">
                                    车牌号：&nbsp;<input id="vehicleNumberInput" type="text" class="txt"  style="width:80px;" name="vehicleNumber"/>
                                </div>
                            </bcgogo:if>
                            <bcgogo:else>
                                <div class="divTit">
                                    供应商/客户：&nbsp;<input type="text" style="width:145px;color:#ADADAD" class="customerOrSupplierName textbox"
                                                        autocomplete="off" initialValue="供应商/客户" value="供应商/客户" pagetype="inquiryCenter"
                                                        name="customerOrSupplierName" id="customer_supplierInfoText" />&nbsp;<input type="text" readonly="readonly" style="width:85px;color:#ADADAD" class="mobile textbox" pagetype="payableStat"
                                                                                                                                    initialValue="手机号" value="手机号"
                                                                                                                                    id="mobile" name="contactNum" />
                                </div>
                                <div class="divTit" style="display:none">
                                    车牌号：&nbsp;<input type="text" class="txt"  style="width:80px;" name="vehicleNumber" id="vehicleNumberInput"/>
                                </div>
                            </bcgogo:else>
                        </bcgogo:permission>

                            <div class="divTit"<c:if test="${!wholesalerVersion}">style="display: none;"</c:if>>
                                所属区域：
                                <select id="select_province" name="province" class="txt select J_province"><option value="">所有省</option></select>
                                <select id="select_city" name="city" class="txt select J_city"><option value="">所有市</option></select>
                                <select id="select_township" name="region" class="txt select J_region"><option value="">所有区</option></select>
                            </div>


                        <div class="divTit" style="margin-left: 400px;"><input id="receivableSearchBtn" class="btn" type="button" value="统&nbsp;计"></div>
                        <div class="divTit"><input id="resetSearchCondition" type="button" class="btn" value="重&nbsp;置"/></div>
                    </div>
                    <div class="lineBottom"></div>
                    <div class="clear height"></div>
                    <input type="hidden" id="receiver" name="receiver"/>

                </form:form>
            </div>

            <div class="lineTitle tabTitle">
                应收总计：<span class="blue_col" id="totalArrears">0.0</span>元（<bcgogo:hasPermission permissions="WEB.SUPPLIER_MANAGER.BASE" resourceType="menu">供应商：<span class="blue_col" id="supplierTotalDebt">0.0</span>元&nbsp;</bcgogo:hasPermission>客户：<span class="blue_col" id="customerTotalDebt">0.0</span>元）&nbsp;&nbsp;成本总计：<span id="totalCostPriceStat"></span>元
            </div>
            <div class="tab">
                <table cellpadding="0" cellspacing="0" class="recStatTable clear" id="recStatTable">
                    <col>
                    <col width="50px">
                    <col width="100px">
                    <col width="100px">
                    <col width="114px">
                    <bcgogo:hasPermission resourceType="logic" permissions="WEB.VERSION.VEHICLE_CONSTRUCTION">
                        <col width="100px">
                    </bcgogo:hasPermission>

                    <col width="112px">
                    <col width="100px">
                    <col width="100px">
                    <col width="100px">
                    <col width="100px">
                    <col width="100px">
                    <col width="50px">
                    <tr class="tab_title" style="border:none;">
                        <td class="tab_first"></td>
                        <td>NO</td>
                        <td>单据号</td>
                        <td>单据时间</td>
                        <td>客户/供应商</td>
                        <bcgogo:hasPermission resourceType="logic" permissions="WEB.VERSION.VEHICLE_CONSTRUCTION">
                            <td>车牌号</td>
                        </bcgogo:hasPermission>

                        <td>类型</td>
                        <td>单据总额</td>
                        <td>单据成本</td>
                        <td>实收金额</td>
                        <td>优惠金额</td>
                        <td>挂账金额</td>
                        <td>对账</td>
                        <td class="tab_last"></td>
                    </tr>
                </table>
                <div class="" style="margin-right:15px;">
                    <jsp:include page="/common/pageAJAX.jsp">
                        <jsp:param name="url" value="arrears.do?method=getReceivableStatData"></jsp:param>
                        <jsp:param name="data"
                                   value="{startPageNo:1,startDateStr:jQuery('#startDate').val(),endDateStr:jQuery('#endDate').val()}"></jsp:param>
                        <jsp:param name="jsHandleJson" value="initReceivableTable"></jsp:param>
                        <jsp:param name="dynamical" value="dynamical1"></jsp:param>
                    </jsp:include>
                </div>
                <div class="clear" style="margin-bottom:10px;"></div>
                <bcgogo:hasPermission permissions="WEB.STAT.RECEIVABLE_PAYABLE_STAT.RECEIVABLE_PRINT">
                    <div id="print_div" class="btn_div_Img">
                        <input id="printBtn2" class="print j_btn_i_operate" type="button" onfocus="this.blur();">
                        <div class="optWords">打印</div>
                    </div>
                </bcgogo:hasPermission>
            </div>
        </div>
    </div>
</div>


<div id="div_customerOrSupplier" class="i_scroll suggestionMain" style="display:none;">
    <div class="Container">
        <div class="Scroller-Container" id="cusOrSupContainer"></div>
    </div>
</div>
<div id="mask" style="display:block;position: absolute;"></div>
<iframe id="iframe_PopupBox_2" style="position:absolute;z-index:6;top:210px;left:87px;display:none;  background: none repeat scroll;"
        allowtransparency="true" width="1000px" height="650px" frameborder="0" src="" scrolling="no"></iframe>
<%@include file="/WEB-INF/views/footer_html.jsp" %>
</body>
</html>