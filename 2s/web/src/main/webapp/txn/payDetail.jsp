<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="i_searchBrand">
    <div class="i_arrow"></div>
    <div class="i_upLeft"></div>
    <div class="i_upCenter">
        <div class="i_note" id="div_drag">结算详细</div>
        <div class="i_close" id="div_close_pay_detail"></div>
    </div>
    <div class="i_upRight"></div>
    <div class="i_upBody">
        <div class="moneyTotal">

        </div>
        <div class="clear height"></div>
        <div class="moneyTotal">
            <div class="total" style="float:left;">应&nbsp;&nbsp;付：¥<span class="span" id="pay_total"></span>元</div>
            <div class="total" style="float:left;">扣&nbsp;&nbsp;款：
                <%--<input type="text" id="deduction" name="deduction" style="width:75px;"/>--%>
                <form:input
                        path="deduction"
                        style="width:75px;"/>
                     <form:hidden
                        path="paidtype"
                        value=''
                        />
            </div>
            <div  class="total" style="float:left;"> 欠款挂账:
            <form:input
                    path="creditAmount"
                    cssClass="tab_input" style="width:75px;"/>
                  </div>
            <%--<input type="text" id="creditAmount" name="creditAmount" class="tab_input"--%>
            <%--style="width:100px; float:left;"/>--%>
        </div>
        <div class="clear height"></div>
        <table cellpadding="0" cellspacing="0" class="tabTotal tabDetail">
            <col width="190"/>
            <col/>
            <tr>
                <td>现&nbsp;&nbsp;&nbsp;&nbsp;金：
                    <form:input
                            path="cash"
                            style="width:120px;"/>
                    <%--<input type="text" id="cash" name="cash" style="width:120px;"/>--%>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>银 行 卡：
                    <form:input
                            path="bankCardAmount"
                            style="width:120px;"/>
                    <%--<input type="text" id="bankCardAmount" name="bankCardAmount" style="width:120px;"/>--%>
                </td>
                <td></td>
            </tr>
            <tr>
                <td>
                    支&nbsp;&nbsp;&nbsp;&nbsp;票：
                    <form:input
                            path="checkAmount"
                            style="width:120px;"/>
                    <%--<input type="text" id="checkAmount" name="checkAmount"--%>
                    <%--style="width:120px;"/>--%>
                    <div class="divNum">
                        号&nbsp;&nbsp;&nbsp;&nbsp;码：
                        <form:input
                                path="checkNo"
                                style="width:155px;"/>
                        <%--
                        <input class="tab_input" id="checkNo" name="checkNo" type="text"
                                                          style="width:95px;">--%>
                    </div>
                </td>
                <td style="font-weight:bold; font-size:14px; text-align:right; padding-right:10px;">
                    实&nbsp;&nbsp;付：
                    <form:input
                            path="actuallyPaid"
                            style="width:120px;"/>
                    <%--<input type="text" id="actuallyPaid" name="actuallyPaid" style="width:120px;"/>--%>
                </td>
            </tr>
            <tr>
                <td>预&nbsp;付&nbsp;款：
                   <form:input
                            path="depositAmount"
                            style="width:120px;"/>
                    <%--<input type="text" id="depositAmount" name="depositAmount" style="width:120px;"/>--%>
                </td>
                <td>预付款：<span id="deposit_avaiable"></span></td>
            </tr>
        </table>

        <div class="clear height"></div>
        <div class="btnInput">
            <span class="span">*双击更改付款方式</span>
            <label class="chkPrint"><input type="checkbox" id="checkDetailPrint"/>打印</label>
            <input name="surePayStroage" id="surePayStroage" type="button" value="确认付款" onfocus="this.blur();"/>
            <input id="cancleBtnPayDetail" type="button" value="取消" onfocus="this.blur();"/>
        </div>
    </div>
    <div class="i_upBottom">
        <div class="i_upBottomLeft"></div>
        <div class="i_upBottomCenter"></div>
        <div class="i_upBottomRight"></div>
    </div>
</div>