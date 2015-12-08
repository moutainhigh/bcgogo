<%@ page import="com.bcgogo.config.ConfigController" %>
<%--
  Created by IntelliJ IDEA.
  User: ndong
  Date: 13-1-18
  Time: 上午7:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>合并供应商详细信息</title>
  <link rel="stylesheet" type="text/css" href="styles/mergeCustomer<%=ConfigController.getBuildVersion()%>.css"/>
  <%--<link rel="stylesheet" type="text/css" href="styles/addCheck<%=ConfigController.getBuildVersion()%>.css"/>--%>


  <script type="text/javascript">

  </script>
</head>
<body class="bodyMain">
<div class="i_upBody">
  <div class="i_height"></div>
  <div class="mergeBefore" style="color:#FF0000;">友情提示：供应商合并后，将只保留一个供应商的信息，其他不保留供应商的预付款信息、应付款信息将转移到保留供应商上。</div>
   <div class="i_height"></div>
  <h3 class="blue_color mergeBefore">系统为您自动保留的供应商为：</h3>
  <h3 class="blue_color mergeAfter">进行合并的供应商信息如下：</h3>
  <div class="mWholesalesDiv">
  <div id="parentBorder" class="border">
      <table cellpadding="0" cellspacing="0" id="wholeSaleParentTable" class="tabMerge tabMerge_selected">
          <col width="110">
          <col width="110">
          <col width="100">
          <col width="190">
          <col width="100">
          <col>
          <col width="100">
          <col width="110">
          <tr class="tab_title">
              <td colspan="8" class="qian_red name">
                  <!--<span class="blue_color">关联客户</span>-->
              </td>
          </tr>
          <tr>
              <td class="tab_title"><div id="selectedSupplier1" class="radCheck mergeBefore" isParent="true" supplierId="" supplierShopId=""></div>简&nbsp;称</td>
              <td class="abbr"></td>
              <td class="tab_title">供应商类别</td>
              <td class="categoryStr"></td>
              <td class="tab_title">座&nbsp;机</td>
              <td class="landLine"></td>
              <td class="tab_title">传&nbsp;真</td>
              <td class="fax"></td>
          </tr>
          <tr>
              <td class="tab_title">所在区域</td>
              <td class="areaStr"></td>
              <td class="tab_title">地&nbsp;址</td>
              <td class="address"></td>
              <td class="tab_title">开户行</td>
              <td class="bank"></td>
              <td class="tab_title">开户名</td>
              <td class="accountName"></td>
          </tr>
          <tr>
              <td class="tab_title">账&nbsp;号</td>
              <td class="account"></td>
              <td class="tab_title">发票类型</td>
              <td class="invoiceCategory"></td>
              <td class="tab_title">结算方式</td>
              <td class="settlementType"></td>
              <td class="tab_title">预付款余额</td>
              <td class="deposit"></td>
          </tr>
          <tr>
              <td class="tab_title">累计交易</td>
              <td class="totalTradeAmount"></td>
              <td class="tab_title">累计销售退货</td>
              <td class="totalReturnAmount"></td>
              <td class="tab_title">当前应付</td>
              <td class="totalPayable"></td>
              <td class="tab_title">当前应收</td>
              <td class="totalReceivable"></td>
          </tr>
          <tr>
              <td class="tab_title">退货次数</td>
              <td class="countSupplierReturn"></td>
              <td class="tab_title">经营产品</td>
              <td class="businessScope"></td>
              <td colspan="4"></td>
          </tr>
      </table>
  </div>
  <div class="height"></div>
  <h3 class="blue_color mergeBefore">被合并的供应商为：</h3>
  <div id="childBorder" class="border">
      <table cellpadding="0" cellspacing="0" id="wholeChildTable" class="tabMerge">
          <col width="110">
          <col width="110">
          <col width="100">
          <col width="190">
          <col width="100">
          <col>
          <col width="100">
          <col width="110">
          <tr class="tab_title">
              <td colspan="8" class="qian_red name">
                  <!--<span class="blue_color">关联客户</span>-->
              </td>
          </tr>
          <tr>
              <td class="tab_title"><div id="selectedSupplier2" class="radNormal mergeBefore" isParent="false" supplierId="" supplierShopId=""></div>简&nbsp;称</td>
              <td class="abbr"></td>
              <td class="tab_title">供应商类别</td>
              <td class="categoryStr"></td>
              <td class="tab_title">座&nbsp;机</td>
              <td class="landLine"></td>
              <td class="tab_title">传&nbsp;真</td>
              <td class="fax"></td>
          </tr>
          <tr>
              <td class="tab_title">所在区域</td>
              <td class="areaStr"></td>
              <td class="tab_title">地&nbsp;址</td>
              <td class="address"></td>
              <td class="tab_title">开户行</td>
              <td class="bank"></td>
              <td class="tab_title">开户名</td>
              <td class="accountName"></td>
          </tr>
          <tr>
              <td class="tab_title">账&nbsp;号</td>
              <td class="account"></td>
              <td class="tab_title">发票类型</td>
              <td class="invoiceCategory"></td>
              <td class="tab_title">结算方式</td>
              <td class="settlementType"></td>
              <td class="tab_title">预付款余额</td>
              <td class="deposit"></td>
          </tr>
          <tr>
              <td class="tab_title">累计交易</td>
              <td class="totalTradeAmount"></td>
              <td class="tab_title">累计销售退货</td>
              <td class="totalReturnAmount"></td>
              <td class="tab_title">当前应付</td>
              <td class="totalPayable"></td>
              <td class="tab_title">当前应收</td>
              <td class="totalReceivable"></td>
          </tr>
          <tr>
              <td class="tab_title">退货次数</td>
              <td class="countSupplierReturn"></td>
              <td class="tab_title">经营产品</td>
              <td class="businessScope"></td>
              <td colspan="4"></td>
          </tr>
      </table>
  </div>
  </div>
  <div class="height"></div>
  <div class="mergeConfirm" id="mergeWholesalerDiv">
  </div>
</div>

</div>
</body>
</html>
