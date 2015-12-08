var LazySearcher = APP_BCGOGO.wjl.LazySearcher;
var bcgogoAjaxQuery = APP_BCGOGO.Module.wjl.ajaxQuery;
//order 对应的 items
var ordersStoreMap = {};
getOrderDetailsByOrderId = function (key) {
    return ordersStoreMap[key];
};
$(function(){
    //input框初始化
    $("input[type='text']").each(function(){
        if($(this).attr("initValue")) {
            if($(this).val() == '') {
                $(this).css("color","#7E7E7E");
                $(this).val($(this).attr("initValue"));
            } else {
                if($(this).val() == $(this).attr("initValue")) {
                    $(this).css("color","#7E7E7E");
                } else {
                    $(this).css("color","#000000");
                }
            }
        } else {
            $(this).css("color","#000000");
        }
    })
        .focus(function(){
            if($(this).attr("initValue")) {
                if($(this).attr("initValue") == $(this).val()) {
                    $(this).val('').css("color","#000000");
                }
            }
        })
        .blur(function(){
            if($(this).attr("initValue")) {
                if($(this).val() == $(this).attr("initValue") || $(this).val() == '') {
                    $(this).css("color","#7E7E7E");
                    $(this).val($(this).attr("initValue"));
                }
            }
        });
    //单据类型:所有
    $("#orderTypeAll").click(function(){
        if($(this).attr("checked")) {
            $("#orderTypes :checkbox").attr("checked",true);
        } else {
            $("#orderTypes :checkbox").attr("checked",false);
        }
    });
    //单据类型:除了”所有“
    $("#orderTypes :checkbox").not("#orderTypeAll").click(function(){
        var isAllChecked = true;
        if(!$(this).attr("checked")) {
            $("#orderTypeAll").attr("checked",false);
        } else {
            $("#orderTypes :checkbox").not("#orderTypeAll").each(function(){
                if(!$(this).attr("checked")) {
                    isAllChecked = false;
                    return false;
                }
            });
            if(isAllChecked) {
                $("#orderTypeAll").attr("checked",true);
            } else {
                $("#orderTypeAll").attr("checked",false);
            }
        }

        $("#btnSearch").click();
    });
    //时间段
    $("#startDate,#endDate")
        .datepicker({
            "numberOfMonths":1,
            "showButtonPanel":false,
            "changeYear":true,
            "showHour":false,
            "showMinute":false,
            "changeMonth":true,
            "yearRange":"c-100:c+100",
            "yearSuffix":""
        })
        .blur(function () {
            var startDate = $("#startDate").val();
            var endDate = $("#endDate").val();
            if (startDate == "" || endDate == "") return;
            if (APP_BCGOGO.Validator.stringIsZhCn(startDate) && APP_BCGOGO.Validator.stringIsZhCn(endDate)) {
                return;
            } else {
                if (transformToDateStr(startDate) > transformToDateStr(endDate)) {
                    $("#endDate").val(startDate);
                    $("#startDate").val(endDate);
                }
            }
        })
        .bind("click", function () {
            $(this).blur();
        })
        .change(function () {
            var startDate = $("#startDate").val();
            var endDate = $("#endDate").val();
            $(".divTit > .btnList").removeClass("btnHover");
            if (endDate == "" || startDate == "") {
                return;
            }
            if (APP_BCGOGO.Validator.stringIsZhCn(startDate) && APP_BCGOGO.Validator.stringIsZhCn(endDate)) {
                return;
            } else {
                if (transformToDateStr(startDate) > transformToDateStr(endDate)) {
                    $("#endDate").val(startDate);
                    $("#startDate").val(endDate);
                }
            }
        });


    //更多条件的显示与隐藏
    $(".more_condition").hide();
    $(".up").toggle(
        function(){
            $(".more_condition").show();
            $(this).removeClass("up").addClass("down");
            $(this).html("收起条件");
        },
        function(){
            $(".more_condition").hide();
            $(this).removeClass("down").addClass("up");
            $(this).html("高级条件");
        }
    )

    //分页使用
    $("#btnSearch").click(function () {
        $("#inquiryCenterSearchForm").submit();
    });

    $("#inquiryCenterSearchForm").submit(function (e) {
        e.preventDefault();
        //过滤掉所有提示
        clearInitValue();
        var param = $("#inquiryCenterSearchForm").serializeArray();
        var data = {};
        $.each(param, function (index, val) {
            if(!G.Lang.isEmpty(data[val.name])){
                data[val.name] = data[val.name]+","+val.value;
            }else{
                data[val.name] = val.value;
            }
        });
        initOrderTypes(data);
        APP_BCGOGO.Net.syncPost({
            url: "inquiryCenter.do?method=inquiryImportedOrder",
            dataType: "json",
            data:data,
            success: function (result) {
                showResponse(result);
                initPage(result, "inquiryCenter", "inquiryCenter.do?method=inquiryImportedOrder", '', "showResponse", '', '', data, '');
            },
            error: function () {
                nsDialog.jAlert("数据异常，请刷新页面！");
            }
        });
    });

    //弹出单据下拉框
    $("[id$='.orderInfo'],[id$='.bottom']").live("click", function (e) {
        if(e.target.tagName == "A" && !$(e.target).hasClass("btnDown") ){
            return;
        }
        var idPrefix = $(this).attr("id").split(".")[0];
        //删除其他orderDetail
        $("[id$='.orderDetail']").each(function () {
            var itemIdPrefix =  $(this).attr("id").split(".")[0];
            if(itemIdPrefix != idPrefix){
                $(this).remove();
            }

        });
        if ($("#" + idPrefix + "\\.orderDetail").size() > 0) {
            $("[id$='.orderDetail']").each(function () {
                $(this).remove();
            });
        } else {
            showOrderItems.searchOrderItemDetails(e,idPrefix);
        }

    }).live("mouseenter",function(e){
            var idPrefix = $(this).attr("id").split(".")[0];
            $("[id$='.bottom']").each(function(){
                $(this).find(".div_Btn").hide();
            });
            $("#"+idPrefix + "\\.bottom").find(".div_Btn").show();
        }).live("mouseleave",function (e){
            var idPrefix = $(this).attr("id").split(".")[0];
            if ( $(e.relatedTarget).parents("#" + idPrefix + "\\.orderInfo").length > 0 || $(e.relatedTarget).parents("#" + idPrefix + "\\.bottom").length > 0
                ) {
                return;
            }
            $("#"+idPrefix + "\\.bottom").find(".div_Btn").hide();
        });

    //向上按钮，点击隐藏下拉框
    $("[id$='.orderDetail']").find(".btnUp").live("click",function(){
        $(this).parents("[id$='orderDetail']").remove();
    });

    //入库退货按钮点击事件
    $("#returnStorageBtn").live("click", function(){
        var productIds=new Array();
        var $productId=$(this).parents("tr").find("[id^='inventoryProductId']");
        if(!G.isEmpty($productId)){
            $productId.each(function(){
                productIds.push($(this).val());
            });
        }
        var supplierId=$("#returnSupplierId").val();
        var purchaseOrderId=$("#purchaseInventoryId").val();
        if (productIds.length>0&&!G.isEmpty(purchaseOrderId)&&!G.isEmpty($(supplierId))){
            window.open("goodsReturn.do?method=createReturnStorageByProductId&productIds=" + productIds.toString() +
                "&purchaseOrderId="+purchaseOrderId+"&supplierId="+supplierId+"&isToSalesReturn=true");
        }
    });

    $("#print").live("click",function(){
        var id = $(this).parents("tr").find(".orderHandleId").val();
        if(G.isEmpty(id)){
            nsDialog.jAlert("数据异常，不能打印。");
            return;
        }
        if($(this).attr("handletype") == 'wash') {
            window.showModalDialog('washBeauty.do?method=printWashBeautyTicket&orderId=' + id + "&now=" + new Date(), '', "dialogWidth=250px;dialogHeight=768px");
        } else if($(this).attr("handletype") == 'repair') {
            window.showModalDialog('txn.do?method=getRepairOrderToPrint&repairOrderId=' + id + "&now=" + new Date(), '', "dialogWidth=1024px;dialogHeight=768px");
        } else if($(this).attr("handletype") == 'sale') {
            openWindow('sale.do?method=getSalesOrder&menu-uid=WEB.TXN.SALE_MANAGE.SALE&salesOrderId=' + id + "&operation=PRINT");
        }  else if($(this).attr("handletype") == 'saleReturn') {
            window.showModalDialog('salesReturn.do?method=printSalesReturnOrder&salesReturnOrderId=' + id + "&now=" + new Date(), '', "dialogWidth=1024px;dialogHeight=768px");
        }  else if($(this).attr("handletype") == 'inventory') {
            window.showModalDialog('storage.do?method=getPurchaseInventoryToPrint&purchaseInventoryId=' + id + "&now=" + new Date(), '', "dialogWidth=1024px;dialogHeight=768px");
        }  else if($(this).attr("handletype") == 'purchase') {
            window.showModalDialog('RFbuy.do?method=print&id=' + id + "&now=" + new Date(), '', "dialogWidth=1024px;dialogHeight=768px");
        }  else if($(this).attr("handletype") == 'return') {
            window.showModalDialog('goodsReturn.do?method=printReturnStorageOrder&purchaseReturnId=' + id + "&now=" + new Date(), '', "dialogWidth=1024px;dialogHeight=768px");
        }
    });


    $(".J_order_sort").click(function(){
        $(".J_order_sort").each(function(){
            $(this).removeClass("hover");
        });
        $(this).addClass("hover");
        var $arrowSpan = $(this).find("span");
        if($arrowSpan.hasClass("arrowDown")) {
            $arrowSpan.removeClass("arrowDown").addClass("arrowUp");
        }  else {
            $arrowSpan.removeClass("arrowUp").addClass("arrowDown");
        }
    });

    $(".J_order_sort").click(function(){
        $(".J_order_sort").each(function(){
            $(this).removeClass("hover");
        });
        $(this).addClass("hover");
        var $arrowSpan = $(this).find("span");
        if($arrowSpan.hasClass("arrowDown")) {
            $arrowSpan.removeClass("arrowDown").addClass("arrowUp");
        }  else {
            $arrowSpan.removeClass("arrowUp").addClass("arrowDown");
        }
        var currentSortStatus = $(this).attr("currentSortStatus");
        if(currentSortStatus == "desc"){
            $(this).attr("currentSortStatus","asc");
        } else {
            $(this).attr("currentSortStatus", "desc");
        }
        $("#sortStatus").val($(this).attr("sortField") +  " " + $(this).attr("currentSortStatus"));
        $("#btnSearch").click();
    });

    //reset
    $("#resetSearchCondition").click(function () {
        //reset form
        $("#inquiryCenterSearchForm").resetForm();
        $(".btnList").removeClass("btnHover");
        if(!$("#my_date_today").hasClass("clicked")){
            $("#my_date_today").click();
        }else{
            $("#my_date_today").click();
            $("#my_date_today").click();
        }

        $("#inquiryCenterSearchForm input").each(function (index, domObject) {
            if ($(domObject).attr("initValue")) {
                if ($(domObject).val() != $(domObject).attr("initValue")) {
                    $(domObject).css({"color":"#000000"});
                } else {
                    $(domObject).css({"color":"#ADADAD"});
                }
            }
        });
        //reset
        var inputs = $("#inquiryCenterSearchForm input");
        var initialValue;
        var value;
        for (var i = 0; i < inputs.length; i++) {
            initialValue = $(inputs[i]).attr("initValue");
            value = inputs[i].value;
            if (!initialValue) {
                continue;
            }
            $(inputs[i]).val(initialValue).css({"color":"#ADADAD"});
        }
    });
    $("#my_date_today").click();
    $("#btnSearch").click();
});

//时间名词转换成标准时间
function transformToDateStr(str) {
    if (!APP_BCGOGO.Validator.stringIsZhCn(str)) return str;
    var date = new Date();
    var day = date.getDate();  //getDay 是星期
    var mouth = date.getMonth() + 1;  //+1代表本月
    var year = date.getFullYear();
    var time = null;
    if (str == "今天") {
        time = year + "-" + addZero(mouth) + "-" + addZero(day);
    } else if (str == "昨天") {
        time = year + "-" + addZero(mouth) + "-" + addZero((day - 1));
    } else if (str == "上月第一天") {
        time = year + "-" + addZero((mouth - 1)) + "-01";
    } else if (str == "本月第一天") {
        time = year + "-" + addZero(mouth) + "-01";
    } else if (str == "上月最后一天") {
        var lastMonthLastDay = new Date(new Date(year, mouth, 1).getTime() - 1000 * 60 * 60 * 24);
        time = lastMonthLastDay.getFullYear() + "-" + addZero(lastMonthLastDay.getMonth()) + "-" + addZero(lastMonthLastDay.getDate());
    } else if (str == "今年第一天") {
        time = year + "-01-01";
    }
    return time;
}

//把8转换成08
function addZero(data) {
    if (data < 10) return "0" + data;
    else return data;
}

//相当于 单击“搜索”
function searchOrderImmediately() {
    $("#inquiryCenterSearchForm").submit();
}

//过滤掉所有提示
function clearInitValue() {
    var inputs = $("#inquiryCenterSearchForm input[type='text']");
    var initialValue;
    var value;
    for (var i = 0, max = inputs.length; i < max; i++) {
        initialValue = $(inputs[i]).attr("initValue");
        value = inputs[i].value;
        if (!initialValue) {
            continue;
        }
        if (value == initialValue) {
            $(inputs[i]).val("");
        }
    }
}

//初始化单据类型
function initOrderTypes(data){
    var dom = $("#orderTypes > label > :checkbox");
    //判断是否全部都没选中
    var isAllOrderTypeNotChecked = true;
    for (var i = 0,max = dom.length; i < max; i++) {
        if ($(dom[i]).attr("checked")) {
            isAllOrderTypeNotChecked = false;
            break;
        }
    }
    if (isAllOrderTypeNotChecked) {
        data["orderType"] = '';
        for (var i = 0,max = dom.length; i < max; i++) {
            data["orderType"] = data["orderType"] + $(dom[i]).val() + ",";
        }

        if(data["orderType"].length > 1) {
            data["orderType"] = data["orderType"].substring(0,data["orderType"].length - 1);
        }
    }
}

//ajax 请求后显示结果
function showResponse(json) {
    addHint(null);
    if (json) {
        getInquiryCenterTr(json);
        setOrderCountsAndAmounts(json);
        //set pager totalRows
        if (json != null) {
            $("#totalRows").val(json.numFound);
            $("#totalNum").html(json.numFound);
        }
    }
}

//添加所有提示
function addHint(e) {
    var inputs = $("#inquiryCenterSearchForm input[type='text']");
    var initialValue;
    var value;
    for (var i = 0; i < inputs.length; i++) {
        initialValue = $(inputs[i]).attr("initValue");
        value = inputs[i].value;
        if (!initialValue) {
            continue;
        }
        if (value == "") {
            $(inputs[i]).val(initialValue);
        }
    }
    if (e) {
        GLOBAL.error("inquiryCenter.js inquiryCenterSearchForm error:" + e);
    }
}

//拼接order结果
function getInquiryCenterTr(json) {

    $(".tab_cuSearch tr").not(".titleBg").not(".space").remove();
    var tr;
    if (json == null || json.orders == null || json.orders == 0) {
        tr = '<tr class="titBody_Bg" id="tabStorage[0]"><td colspan="9" style="border-left:none;border-right:none;text-align: center;" class="txt_right">对不起，没有找到您要的单据信息！</td></tr >';
        $(".tab_cuSearch").append($(tr));
        tr = '<tr class="titBottom_Bg"><td colspan="9"></td></tr>'
        $(".tab_cuSearch").append($(tr));
        return;
    }
    var orders = json.orders;
    var inputtingTimerId = 0;
    ordersStoreMap = {};
    for (var i = 0, max = orders.length; i < max; i++) {
        var order = orders[i];
        var orderId = (!order.orderIdStr ? "" : order.orderIdStr);
        if (orderId) {
            ordersStoreMap[orderId] = order;
        }
        var receiptNo = (!order.receiptNo ? "--" : order.receiptNo);
        var orderType = (!order.orderType ? "--" : order.orderType);
        var createdTimeStr = (!order.createdTimeStr ? "--" : order.createdTimeStr);
        var customerOrSupplierName = (!order.customerOrSupplierName ? "--" : order.customerOrSupplierName);
        var vehicle = (!order.vehicle ? "--" : order.vehicle);
        var orderContent = (!(order.orderContent) ? "--" : order.orderContent)
        var orderTypeValue = (!(order.orderTypeValue) ? "--" : order.orderTypeValue);
        var amount = (!(order.amount) ? ("0") : (order.amount + '元'));
        var orderStatusValue = (!order.orderStatusValue ? "--" : order.orderStatusValue);

        if (orderStatusValue == "已入库" && order.debt > 0) {
            orderStatusValue = "欠款入库";
            order.orderStatusValue = orderStatusValue;
        }
        else if (orderStatusValue == "已结算" && order.debt > 0) {
            orderStatusValue = "欠款结算";
            order.orderStatusValue = orderStatusValue;
        }
        if (order.payMethod != null && order.payMethod != undefined && order.payMethod.toString().indexOf("STATEMENT_ACCOUNT") != -1) {
            orderStatusValue = "已对账";
            order.orderStatusValue = orderStatusValue;
        }



        var orderStatus = (!order.orderStatus ? "--" : order.orderStatus);
        tr = '<tr class="titBody_Bg" id="searchResultOrder' + i + '.orderInfo">';
        var customerStatus = (!order.customerStatus ? "" : order.customerStatus);
        tr += '<td style="padding-left:10px;" title="' + receiptNo + '">' + receiptNo;
        tr += '</td>';
        tr += '<td style="text-align: center;" title="' + createdTimeStr + '">' + createdTimeStr + '</td>';
        if ("DISABLED" == customerStatus) {
            tr += '<td  title="' + customerOrSupplierName + '">' + customerOrSupplierName + '</td>';
        }
        else {
            tr += '<td  title="' + customerOrSupplierName + '">' + customerOrSupplierName + '</td>';
        }

        tr += '<td  title="' + vehicle + '">' + vehicle + '</td>';
        tr += '<td  title="' + orderTypeValue + '">' + orderTypeValue + '</td>';
        tr += '<td style="overflow: hidden;" title="' + orderContent + '">' + orderContent + '</td>';
        tr += '<td title="' + amount + '">' + amount + '</td>';
        tr += '<td style="border-right:none;text-align: center;" title="' + orderStatusValue + '">' + orderStatusValue + '</td>';
        tr += '<input type="hidden" class="orderIds" value="' + order.orderIdStr + '" name="' + order.orderIdStr + '">' +
            '<input type="hidden" class="orderTypes" value="' + order.orderType + '" name="' + order.orderType.toLowerCase() + '">' +
            '</tr>';
        var $tr = $(tr);
        $tr.attr("orderInfo", JSON.stringify({ orderType:order.orderType.toLowerCase(), orderIdStr:order.orderIdStr}));
//        $tr.mouseover(function (e) {
//            var foo = this;
//            inputtingTimerId = setTimeout(function () {
//                showOrderItems.searchOrderItemDetails(e, foo);
//            }, 1000);
//        })
//            .mouseout(function (e) {
//                if (!inputtingTimerId) return;
//                clearTimeout(inputtingTimerId);
//            })
//            .click(function (e) {
//                showOrderItems.searchOrderItemDetails(e, this);
//            })
        $(".tab_cuSearch").append($tr);
        $(".tab_cuSearch").append($('<tr class="titBottom_Bg" id="searchResultOrder' + i + '.bottom"' +'><td colspan="9"><div class="div_Btn" style="display:none;"><a class="btnDown"></a></div></td></tr>'));
    }

}

//set order counts amounts
function setOrderCountsAndAmounts(json) {
    //每次show 数据之前 先清空
    $(".divTit").find("b[id^='counts_']").each(function () {
        $(this).html("0");
    });

    //
    if (json == null || json.orders == null)return;
    if (json.orderTypeStat) {
        var orderTypeStat = json.orderTypeStat;
        for(var i=0;i<orderTypeStat.length;i++){
            $("#counts_" + orderTypeStat[i][0].toLowerCase()).html(APP_BCGOGO.StringFilter.intFilter(orderTypeStat[i][1]));
            $("#counts_" + orderTypeStat[i][0].toLowerCase()).attr("title", APP_BCGOGO.StringFilter.intFilter(orderTypeStat[i][1]));

        }
    }

}

//order item details
var showOrderItems = function () {
    return{
        searchOrderItemDetails:function (e, idPrefix) {
            var order = $.parseJSON($("#" + idPrefix + "\\.orderInfo").attr("orderinfo"));
            var repealed = false;
            var copyable = true;
            var repealable = true;
            var returnable = true;
            var jsonStr = getOrderDetailsByOrderId(order.orderIdStr);
            if (!jsonStr) {
                GLOBAL.error("items is null!");
                return;
            } else if (!order.orderType) {
                GLOBAL.error("order type is null!");
                return;
            }
            if (order.orderType == "sale") {
                getSaleItems(jsonStr,idPrefix);
                repealed = (jsonStr.orderStatus == "SALE_REPEAL");
                var status = jsonStr.orderStatus;
                if(status == "STOP" || status=="REFUSED" || status=="SELLER_STOP" || status=="DISPATCH" || status=="STOCKING" || status == "SALE_DEBT_DONE" || status == "PENDING"){
                    copyable = false;
                    repealable = false;
                }
                if(status != 'SALE_DONE'){
                    returnable = false;
                }
            } else if (order.orderType == "repair") {
                getRepairItems(jsonStr,idPrefix);
                repealed = (jsonStr.orderStatus == "REPAIR_REPEAL");
            } else if (order.orderType == "inventory") {
                getInventoryItems(jsonStr,idPrefix);
                repealed = (jsonStr.orderStatus == "PURCHASE_INVENTORY_REPEAL");
            } else if (order.orderType == "wash_beauty") {
                getWashBeautyItems(jsonStr,idPrefix);
                repealed = (jsonStr.orderStatus == "WASH_REPEAL");
            } else if (order.orderType == "return") {
                getReturnItems(jsonStr,idPrefix);
                repealed = (jsonStr.orderStatus == "REPEAL");
                if(jsonStr.orderStatus == "SELLER_ACCEPTED" || jsonStr.orderStatus == "SELLER_REFUSED" || jsonStr.orderStatus == "SELLER_PENDING"){
                    copyable = false;
                }
                repealable = false;
                if(jsonStr.customerOrSupplierShopId != null && (jsonStr.orderStatus == "PENDING" || jsonStr.orderStatus == "WAITING_STORAGE" || jsonStr.orderStatus == "REFUSED")){
                    repealable = true;
                }else if(jsonStr.customerOrSupplierShopId == null && jsonStr.orderStatus == 'SETTLED'){
                    repealable = true;
                }
            } else if (order.orderType == "member_buy_card") {
                getMemberBuyCardItems(jsonStr,idPrefix);
            } else if (order.orderType == "member_return_card") {
                getMemberReturnCardItems(jsonStr,idPrefix);
            } else if (order.orderType == "purchase") {
                getPurchaseItems(jsonStr,idPrefix);
                repealed = (jsonStr.orderStatus == "PURCHASE_ORDER_REPEAL" || jsonStr.orderStatus == "PURCHASE_ORDER_DONE");
                if(jsonStr.orderStatus == "SELLER_DISPATCH" || jsonStr.orderStatus == "SELLER_STOCK" ){
                    repealable = false;
                    copyable = false;
                }
                if(jsonStr.orderStatus == "PURCHASE_ORDER_DONE"){
                    repealable = false;
                }
                if(jsonStr.orderStatus == "SELLER_PENDING"){
                    copyable = false;
                }
                returnable = false;
                if(!G.isEmpty(jsonStr.customerOrSupplierShopIdStr) && jsonStr.orderStatus!='SELLER_PENDING'
                    && jsonStr.orderStatus!='SELLER_STOCK' && jsonStr.orderStatus!='SELLER_DISPATCH'){
                    returnable = true;
                }
            } else if (order.orderType == "sale_return") {
                getSalesReturnItems(jsonStr,idPrefix);
                repealed = (jsonStr.orderStatus == "REPEAL");
                if(jsonStr.orderStatus == "PENDING" || jsonStr.orderStatus == "WAITING_STORAGE" || jsonStr.orderStatus == "SETTLED" || jsonStr.orderStatus == "REFUSED"){
                    copyable = false;
                }
            } else {
                GLOBAL.error("inquiry center mouseover action, orderType[" + order.orderType + "] is illegal !");
            }

            if (jsonStr.payMethod != null && jsonStr.payMethod != undefined && jsonStr.payMethod.toString().indexOf("STATEMENT_ACCOUNT") != -1) {
                repealable = false;
            }


            if (repealed || !repealable) {
                $("#" + idPrefix + "\\.orderDetail" + " #repeal").hide();
            } else {
                $("#" + idPrefix + "\\.orderDetail" + " #repeal").show();
            }
            if(copyable){
                $("#" + idPrefix + "\\.orderDetail" + " #copy").show();
            } else {
                $("#" + idPrefix + "\\.orderDetail" + " #copy").hide();
            }
            if(returnable){
                $("#" + idPrefix + "\\.orderDetail" + " #return").show();
            }else{
                $("#" + idPrefix + "\\.orderDetail" + " #return").hide();
            }
        }
    }
}();

//销售单详情
function getSaleItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    tr += '<div class="divTit">销售单号：<span>' + (order.receiptNo == null ? "" : order.receiptNo) + '</span><input type="hidden" class="orderHandleId" value="' + order.orderIdStr + '" /></div>';
    if(APP_BCGOGO.Permission.Version.StoreHouse){
        tr += '<div class="divTit">仓库：<span>' + (order.storehouseName == null ? "" : order.storehouseName) + '</span></div>';
    }
    if ("DISABLED" == order.customerStatus) {
        tr += '<div class="divTit">客户：<span style="color:#999999">' + (order.customerOrSupplierName == null ? "" : order.customerOrSupplierName) + '</span></div>';
    } else {
        tr += '<div class="divTit">客户：<span>' + (order.customerOrSupplierName == null ? "" : order.customerOrSupplierName) + '</span></div>';
    }
    tr += '<div class="divTit">联系人：<span>'+ (order.contact == null ? "" : order.contact) + '</span></div>';
    tr += '<div class="divTit">状态：<span>'+ (order.orderStatusValue == null ? "" : order.orderStatusValue)  + '</span></div>';
    tr += '<div class="divTit">销售单日期：<span>' + (order.vestDateStr == null ? "" : order.vestDateStr) + '</span></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col width="100"><col><col width="100"><col width="100"><col width="100"><col width="100"><col width="70"><col width="70"><col width="40"><col width="70">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">商品编号</td><td>品名</td><td>品牌/产地</td><td>规格</td><td>型号</td><td>车辆品牌</td><td>车型</td><td>单价</td><td>数量</td><td>单位</td><td>小计</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];
        if(item.itemType!="OTHER_INCOME")
        {
            tr += '<tr><td style="padding-left:5px;">' + (!item.commodityCode ? "" : item.commodityCode) + '</td>';
            tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
            tr += '<td>' + (!item.itemBrand ? "" : item.itemBrand) + '</td>';
            tr += '<td>' + (!item.itemSpec ? "" : item.itemSpec) + '</td>';
            tr += '<td>' + (!item.itemModel ? "" : item.itemModel) + '</td>';
            tr += '<td>' + (!item.vehicleBrand ? "" : item.vehicleBrand) + '</td>';
            tr += '<td>' + (!item.vehicleModel ? "" : item.vehicleModel) + '</td>';
            tr += '<td>' + dataTransition.rounding(item.itemPrice,2) + '</td>';
            tr += '<td>' + (!item.itemCount ? "" : item.itemCount) + '</td>';
            tr += '<td>' + (!item.unit ? "" : item.unit) + '</td>';
            var orderTotalAmount = APP_BCGOGO.StringFilter.priceFilter(Number(item.itemPrice) * Number(item.itemCount));
            tr += '<td>' + (!orderTotalAmount ? "" : orderTotalAmount) + '</td>';
            tr += '<input type="hidden" class="saleProductIds" id="saleProductId[' + i + ']" value="' + item.productIdStr + '" name="' + item.productIdStr + '">';
            tr += '</tr>';
        }
    }
    tr += '</table><div class="i_height"></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document"><col width="305"><col width="100"><col>';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">其他费用</td><td>价格</td><td>备注</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];
        if(item.itemType=="OTHER_INCOME") {
            tr += '<tr><td>' +(!item.itemName ? "" : item.itemName)+ '</td>';
            tr += '<td>' + (!item.itemPrice ? "" : item.itemPrice)  + '</td>';
            tr += '<td>'+ (!item.itemMemo ? "" : item.itemMemo)+ '</td>';
            tr += '</tr>';
        }
    }
    tr += '</table>';
    tr += '<div class="i_height"></div><div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实收：<span class="red_color">' + order.settled + '</span>元</div>';
    tr += '<div class="total_line">欠款：<span class="red_color">' + order.debt + '</span>元</div>';
    if(order.memberDiscountRatio) {
        tr += '<div class="total_line">会员打折：<span class="red_color">' + dataTransition.rounding(order.memberDiscountRatio*10,1) + '</span>折</div>';
    }
    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));

}

//入库单详情
function getInventoryItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    tr += '<div class="divTit">入库单号：<span>' + (order.receiptNo == null ? "" : order.receiptNo) + '</span><input type="hidden" class="orderHandleId" value="' + order.orderIdStr + '" /></div>';
    if(APP_BCGOGO.Permission.Version.StoreHouse){
        tr += '<div class="divTit">仓库：<span>' + (order.storehouseName == null ? "" : order.storehouseName) + '</span></div>';
    }

    tr += '<div class="divTit">供应商：<span>' + (order.customerOrSupplierName == null ? "" : order.customerOrSupplierName) + '</span><input type="hidden" id="returnSupplierId" value="' + order.customerOrSupplierId + '"/><input type="hidden" id="purchaseInventoryId" value="' + order.orderIdStr + '"></div>';

    tr += '<div class="divTit">联系人：<span>'+ (order.contact == null ? "" : order.contact) + '</span></div>';
    tr += '<div class="divTit">状态：<span>'+ (order.orderStatusValue == null ? "" :order.orderStatusValue)  + '</span></div>';
    tr += '<div class="divTit">入库日期：<span>' + (order.vestDateStr == null ? "" :order.vestDateStr) + '</span></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col width="100"><col><col width="100"><col width="100"><col width="100"><col width="100"><col width="70"><col width="70"><col width="40"><col width="70">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">商品编号</td><td>品名</td><td>品牌/产地</td><td>规格</td><td>型号</td><td>车辆品牌</td><td>车型</td><td>单价</td><td>数量</td><td>单位</td><td>小计</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];

        tr += '<tr><td style="padding-left:5px;">' + (!item.commodityCode ? "" : item.commodityCode) + '</td>';
        tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
        tr += '<td>' + (!item.itemBrand ? "" : item.itemBrand) + '</td>';
        tr += '<td>' + (!item.itemSpec ? "" : item.itemSpec) + '</td>';
        tr += '<td>' + (!item.itemModel ? "" : item.itemModel) + '</td>';
        tr += '<td>' + (!item.vehicleBrand ? "" : item.vehicleBrand) + '</td>';
        tr += '<td>' + (!item.vehicleModel ? "" : item.vehicleModel) + '</td>';
        tr += '<td>' + dataTransition.rounding(item.itemPrice,2) + '</td>';
        tr += '<td>' + (!item.itemCount ? "" : item.itemCount) + '</td>';
        tr += '<td>' + (!item.unit ? "" : item.unit) + '</td>';
        var orderTotalAmount = APP_BCGOGO.StringFilter.priceFilter(Number(item.itemPrice) * Number(item.itemCount));
        tr += '<td>' + (!orderTotalAmount ? "" : orderTotalAmount) + '</td>';
        tr += '<input type="hidden" class="inventoryProductIds" id="inventoryProductId[' + i + ']" value="' + item.productIdStr + '">';
        tr += '</tr>';

    }
    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实收：<span class="red_color">' + order.settled + '</span>元</div>';
    tr += '<div class="total_line">欠款：<span class="red_color">' + order.debt + '</span>元</div>';

    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));

}

//采购单详情
function getPurchaseItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    tr += '<div class="divTit">采购单号：<span>' + (order.receiptNo == null ? "" : order.receiptNo) + '</span><input type="hidden" class="orderHandleId" value="' + order.orderIdStr + '" /></div>';


    tr += '<div class="divTit">供应商：<span>' + (order.customerOrSupplierName == null ? "" : order.customerOrSupplierName)  + '</span></div>';

    tr += '<div class="divTit">联系人：<span>'+ (order.contact == null ? "" : order.contact) + '</span></div>';
    tr += '<div class="divTit">状态：<span>'+ (order.orderStatusValue == null ? "" : order.orderStatusValue) + '</span></div>';
    tr += '<div class="divTit">采购日期：<span>' + (order.vestDateStr == null ? "" : order.vestDateStr) + '</span></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col width="100"><col><col width="100"><col width="100"><col width="100"><col width="100"><col width="70"><col width="70"><col width="40"><col width="70">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">商品编号</td><td>品名</td><td>品牌/产地</td><td>规格</td><td>型号</td><td>车辆品牌</td><td>车型</td><td>单价</td><td>数量</td><td>单位</td><td>小计</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];

        tr += '<tr><td style="padding-left:5px;">' + (!item.commodityCode ? "" : item.commodityCode) + '</td>';
        tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
        tr += '<td>' + (!item.itemBrand ? "" : item.itemBrand) + '</td>';
        tr += '<td>' + (!item.itemSpec ? "" : item.itemSpec) + '</td>';
        tr += '<td>' + (!item.itemModel ? "" : item.itemModel) + '</td>';
        tr += '<td>' + (!item.vehicleBrand ? "" : item.vehicleBrand) + '</td>';
        tr += '<td>' + (!item.vehicleModel ? "" : item.vehicleModel) + '</td>';
        tr += '<td>' + dataTransition.rounding(item.itemPrice,2) + '</td>';
        tr += '<td>' + (!item.itemCount ? "" : item.itemCount) + '</td>';
        tr += '<td>' + (!item.unit ? "" : item.unit) + '</td>';
        var orderTotalAmount = APP_BCGOGO.StringFilter.priceFilter(Number(item.itemPrice) * Number(item.itemCount));
        tr += '<td>' + (!orderTotalAmount ? "" : orderTotalAmount) + '</td>';
        tr += '<input type="hidden" class="purchaseProductIds" id="purchaseProductId[' + i + ']" value="' + item.productIdStr + '" name="' + item.productIdStr + '">';
        tr += '</tr>';

    }
    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="document_button"><a class="btn_opera" id="print" href="javascript:" handletype="purchase">打&nbsp;印</a><a class="btn_opera" id="copy" target="_blank" href="RFbuy.do?method=show&operation=COPY&id=' + order.orderIdStr + '">复&nbsp;制</a><a class="btn_opera" id="return" target="_blank" href="onlineReturn.do?method=onlinePurchaseReturnEdit&purchaseOrderId=' + order.orderIdStr + '">退&nbsp;货</a><a class="btn_opera" id="repeal" target="_blank" href="RFbuy.do?method=show&operation=REPEAL&id=' + order.orderIdStr + '">作&nbsp;废</a><a class="btn_opera" target="_blank" href="RFbuy.do?method=show&id=' + order.orderIdStr + '">查&nbsp;看</a></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));

}

//入库退货单详情
function getReturnItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    tr += '<div class="divTit">入库退货单号：<span>' + order.receiptNo + '</span><input type="hidden" class="orderHandleId" value="' + order.orderIdStr + '" /></div>';
    if(APP_BCGOGO.Permission.Version.StoreHouse){
        tr += '<div class="divTit">仓库：<span>' + (order.storehouseName == null ? "" : order.storehouseName) + '</span></div>';
    }

    tr += '<div class="divTit">供应商：<span>' + (order.customerOrSupplierName == null ? "" : order.customerOrSupplierName) + '</span></div>';

    tr += '<div class="divTit">联系人：<span>'+ (order.contact == null ? "" : order.contact) + '</span></div>';
    tr += '<div class="divTit">状态：<span>'+ (order.orderStatusValue == null ? "" : order.orderStatusValue) + '</span></div>';
    tr += '<div class="divTit">入库日期：<span>' + (order.vestDateStr == null ? "" : order.vestDateStr) + '</span></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col width="100"><col><col width="100"><col width="100"><col width="100"><col width="100"><col width="70"><col width="70"><col width="40"><col width="70">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">商品编号</td><td>品名</td><td>品牌/产地</td><td>规格</td><td>型号</td><td>车辆品牌</td><td>车型</td><td>单价</td><td>数量</td><td>单位</td><td>小计</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];

        tr += '<tr><td style="padding-left:5px;">' + (!item.commodityCode ? "" : item.commodityCode) + '</td>';
        tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
        tr += '<td>' + (!item.itemBrand ? "" : item.itemBrand) + '</td>';
        tr += '<td>' + (!item.itemSpec ? "" : item.itemSpec) + '</td>';
        tr += '<td>' + (!item.itemModel ? "" : item.itemModel) + '</td>';
        tr += '<td>' + (!item.vehicleBrand ? "" : item.vehicleBrand) + '</td>';
        tr += '<td>' + (!item.vehicleModel ? "" : item.vehicleModel) + '</td>';
        tr += '<td>' + dataTransition.rounding(item.itemPrice,2) + '</td>';
        tr += '<td>' + (!item.itemCount ? "" : item.itemCount) + '</td>';
        tr += '<td>' + (!item.unit ? "" : item.unit) + '</td>';
        var orderTotalAmount = APP_BCGOGO.StringFilter.priceFilter(Number(item.itemPrice) * Number(item.itemCount));
        tr += '<td>' + (!orderTotalAmount ? "" : orderTotalAmount) + '</td>';
        tr += '<input type="hidden" class="returnProductIds" id="returnProductId[' + i + ']" value="' + item.productIdStr + '" name="' + item.productIdStr + '">';
        tr += '</tr>';

    }
    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实收：<span class="red_color">' + order.settled + '</span>元</div>';
    tr += '<div class="total_line">优惠：<span class="red_color">' + order.discount + '</span>元</div>';
    tr += '<div class="total_line">欠款：<span class="red_color">' + order.debt + '</span>元</div>';

    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="document_button"><a class="btn_opera" id="print" href="javascript:" handletype="return">打&nbsp;印</a><a class="btn_opera" id="repeal" target="_blank" href="goodsReturn.do?method=showReturnStorageByPurchaseReturnId&purchaseReturnId=' + order.orderIdStr + '&operation=REPEAL">作&nbsp;废</a><a class="btn_opera" target="_blank" href="goodsReturn.do?method=showReturnStorageByPurchaseReturnId&purchaseReturnId=' + order.orderIdStr + '">查&nbsp;看</a></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));

}

//销售退货单详情
function getSalesReturnItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    tr += '<div class="divTit">销售退货单号：<span>' + order.receiptNo + '</span><input type="hidden" class="orderHandleId" value="' + order.orderIdStr + '" /></div>';
    if(APP_BCGOGO.Permission.Version.StoreHouse){
        tr += '<div class="divTit">仓库：<span>' + (order.storehouseName == null ? "" : order.storehouseName) + '</span></div>';
    }
    if ("DISABLED" == order.customerStatus) {
        tr += '<div class="divTit">客户：<span style="color:#999999">' + (order.customerOrSupplierName == null ? "" : order.customerOrSupplierName) + '</span></div>';
    } else {
        tr += '<div class="divTit">客户：<span>' + (order.customerOrSupplierName == null ? "" : order.customerOrSupplierName) + '</span></div>';
    }
    tr += '<div class="divTit">联系人：<span>'+ (order.contact == null ? "" : order.contact) + '</span></div>';
    tr += '<div class="divTit">状态：<span>'+ (order.orderStatusValue == null ? "" : order.orderStatusValue) + '</span></div>';
    tr += '<div class="divTit">销售日期：<span>' + (order.vestDateStr == null ? "" : order.vestDateStr) + '</span></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col width="100"><col><col width="100"><col width="100"><col width="100"><col width="100"><col width="70"><col width="70"><col width="40"><col width="70">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">商品编号</td><td>品名</td><td>品牌/产地</td><td>规格</td><td>型号</td><td>车辆品牌</td><td>车型</td><td>单价</td><td>数量</td><td>单位</td><td>小计</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];

        tr += '<tr><td style="padding-left:5px;">' + (!item.commodityCode ? "" : item.commodityCode) + '</td>';
        tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
        tr += '<td>' + (!item.itemBrand ? "" : item.itemBrand) + '</td>';
        tr += '<td>' + (!item.itemSpec ? "" : item.itemSpec) + '</td>';
        tr += '<td>' + (!item.itemModel ? "" : item.itemModel) + '</td>';
        tr += '<td>' + (!item.vehicleBrand ? "" : item.vehicleBrand) + '</td>';
        tr += '<td>' + (!item.vehicleModel ? "" : item.vehicleModel) + '</td>';
        tr += '<td>' + dataTransition.rounding(item.itemPrice,2) + '</td>';
        tr += '<td>' + (!item.itemCount ? "" : item.itemCount) + '</td>';
        tr += '<td>' + (!item.unit ? "" : item.unit) + '</td>';
        var orderTotalAmount = APP_BCGOGO.StringFilter.priceFilter(Number(item.itemPrice) * Number(item.itemCount));
        tr += '<td>' + (!orderTotalAmount ? "" : orderTotalAmount) + '</td>';
        tr += '<input type="hidden" class="salesReturnProductIds" id="salesReturnProductId[' + i + ']" value="' + item.productIdStr + '" name="' + item.productIdStr + '">';
        tr += '</tr>';

    }
    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实收：<span class="red_color">' + order.settled + '</span>元</div>';
    tr += '<div class="total_line">优惠：<span class="red_color">' + order.discount + '</span>元</div>';
    tr += '<div class="total_line">欠款：<span class="red_color">' + order.debt + '</span>元</div>';

    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="document_button"><a class="btn_opera" id="print" handletype="saleReturn" href="javascript:">打&nbsp;印</a><a class="btn_opera" id="repeal" target="_blank" href="salesReturn.do?method=showSalesReturnOrderBySalesReturnOrderId&salesReturnOrderId=' + order.orderIdStr + '&operation=REPEAL">作&nbsp;废</a><a class="btn_opera" target="_blank" href="salesReturn.do?method=showSalesReturnOrderBySalesReturnOrderId&salesReturnOrderId=' + order.orderIdStr + '">查&nbsp;看</a></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));

}

//洗车美容单详情
function getWashBeautyItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    if ("DISABLED" == order.customerStatus) {
        tr += '<div class="divTit">客户：<span style="color:#999999">' + order.customerOrSupplierName + '</span></div>';
    } else {
        tr += '<div class="divTit">客户：<span>' + order.customerOrSupplierName + '</span></div>';
    }
    if (order.memberNo) {
        tr += '<div class="divTit">会员（卡）号：<span>'+ order.memberNo + '</span></div>';
    }else {
        tr += '<div class="divTit">会员（卡）号：<span>'+ '非会员' + '</span></div>';
    }

    tr += '<div class="divTit">车牌号：<span>'+ order.vehicle + '</span><input type="hidden" class="orderHandleId" value="' + order.orderIdStr + '" /></div>';
    tr += '<div class="divTit">消费日期：<span>' + (order.vestDateStr == null ? "" : order.vestDateStr) + '</span></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col><col width="100"><col width="100">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">序号</td><td>施工内容</td><td>施工人</td><td>金额</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];

        tr += '<tr><td style="padding-left:5px;">' + (i + 1) + '</td>';
        tr += '<td>' + (!item.services ? "" : item.services) + '</td>';
        tr += '<td>' + (!item.serviceWorker ? "未填写" : (item.serviceWorker)) + '</td>';
        tr += '<td>' + ((item.consumeType && item.consumeType == "TIMES") ? "计次消费" : ((item.consumeType && item.consumeType == "COUPON")?"消费券消费":(!item.itemPrice ? "0" : (("金额:" + item.itemPrice) + "元")))) + '</td>';
        tr += '</tr>';
    }
    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实收：<span class="red_color">' + order.settled + '</span>元</div>';
    tr += '<div class="total_line">欠款：<span class="red_color">' + order.debt + '</span>元</div>';

    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));
}

//车辆施工单
function getRepairItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var serviceIndex = 1;
    var itemIndex = 1;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    if ("DISABLED" == order.customerStatus) {
        tr += '<div class="divTit">客户：<span style="color:#999999">' + order.customerOrSupplierName + '</span></div>';
    } else {
        tr += '<div class="divTit">客户：<span>' + order.customerOrSupplierName + '</span></div>';
    }
    if (order.memberNo) {
        tr += '<div class="divTit">会员（卡）号：<span>'+ order.memberNo + '</span></div>';
    }else {
        tr += '<div class="divTit">会员（卡）号：<span>'+ '非会员' + '</span></div>';
    }

    tr += '<div class="divTit">车牌号：<span>'+ (order.vehicle == null ? "" : order.vehicle) + '</span><input type="hidden" class="orderHandleId" value="' + order.orderIdStr + '" /></div>';
    tr += '<div class="divTit">状态：<span>'+ (order.orderStatusValue == null ? "" : order.orderStatusValue) + '</span></div>';
    tr += '<div class="divTit">进厂时间：<span>' + (order.vestDateStr == null ? "" : order.vestDateStr) + '</span></div>';
    tr += '<div class="divTit divTit_title"><b>施工单</b>&nbsp;&nbsp;<b>施工人：</b><span>' + ((items == null || items[0] == null) ? "" : (items[0].serviceWorker == null ? "" : items[0].serviceWorker))  + '</span></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col><col width="100"><col width="100">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">序号</td><td>施工内容</td><td>工时</td><td>备注</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];
        if (item.itemType == "SERVICE") {
            serviceIndex++;
            tr += '<tr><td style="padding-left:5px;">' + (i + 1) + '</td>';
            tr += '<td>' + (!item.services ? "" : item.services) + '</td>';
            tr += '<td>' + ((item.consumeType && item.consumeType == "TIMES") ? "计次消费" : ((item.consumeType && item.consumeType == "COUPON")?"消费券消费":(!item.itemPrice ? "0" : (("金额:" + item.itemPrice) + "元")))) + '</td>';
            tr += '<td>' + (!item.itemMemo ? "无" : (item.itemMemo)) + '</td>';
            tr += '</tr>';
        }

    }
    if(serviceIndex == 1) {
        tr += '<tr><td colspan="4">' + '对不起，该单据无服务项目！' + '</td></tr>';
    }
    tr += '</table><div class="i_height"></div>';
    if(APP_BCGOGO.Permission.Version.StoreHouse){
        tr += '<div class="divTit divTit_title"><b>材料单</b>&nbsp;&nbsp;<b>仓库：</b><span>' + (order.storehouseName == null ? "" : order.storehouseName) + '</span>&nbsp;&nbsp;<b>销售人：</b><span>' + (order.salesMans == null ? "" : order.salesMans) + '</span></div>';
    } else {
        tr += '<div class="divTit divTit_title"><b>材料单</b>&nbsp;&nbsp;<b>销售人：</b><span>' + (order.salesMans == null ? "" : order.salesMans)  + '</span></div>';
    }
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col><col width="100"><col width="100">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">商品编号</td><td>品名</td><td>品牌/产地</td><td>规格</td><td>型号</td><td>单价</td><td>数量</td><td>单位</td><td>小计</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];
        if (item.itemType != "SERVICE" && item.itemType != "OTHER_INCOME") {
            itemIndex++;
            tr += '<tr><td style="padding-left:5px;">' + (!item.commodityCode ? "" : item.commodityCode) + '</td>';
            tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
            tr += '<td>' + (!item.itemBrand ? "" : item.itemBrand) + '</td>';
            tr += '<td>' + (!item.itemSpec ? "" : item.itemSpec) + '</td>';
            tr += '<td>' + (!item.itemModel ? "" : item.itemModel) + '</td>';
            tr += '<td>' + dataTransition.rounding(item.itemPrice,2) + '</td>';
            tr += '<td>' + (!item.itemCount ? "" : item.itemCount) + '</td>';
            tr += '<td>' + (!item.unit ? "" : item.unit) + '</td>';
            var orderTotalAmount = APP_BCGOGO.StringFilter.priceFilter(Number(item.itemPrice) * Number(item.itemCount));
            tr += '<td>' + (!orderTotalAmount ? "" : orderTotalAmount) + '</td>';
            tr += '</tr>';
        }

    }
    if(itemIndex == 1) {
        tr += '<tr><td colspan="9">' + '对不起，该单据无材料！' + '</td></tr>';
    }
    tr += '</table><div class="i_height"></div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="305"><col width="100"><col>';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">其他费用</td><td>价格</td><td>备注</td></tr>';
    for (var i = 0, max = items.length; i < max; i++) {
        var item = items[i];
        if (item.itemType == "OTHER_INCOME") {
            tr += '<tr><td style="padding-left:5px;">' + (!item.itemName ? "" : item.itemName) + '</td>';
            tr += '<td>' + (!item.itemPrice ? "" : item.itemPrice) + '</td>';
            tr += '<td>' + (!item.itemMemo ? "" : item.itemMemo) + '</td>';
            tr += '</tr>';
        }
    }
    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">预计出厂时间：<span>' + (order.endDateStr == null ? "" : order.endDateStr)  + '</span></div> ';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实收：<span class="red_color">' + order.settled + '</span>元</div>';
    tr += '<div class="total_line">欠款：<span class="red_color">' + order.debt + '</span>元</div>';

    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));

}

//会员购卡续卡
function getMemberBuyCardItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    if ("DISABLED" == order.customerStatus) {
        tr += '<div class="divTit">客户名：<span style="color:#999999">' + order.customerOrSupplierName + '</span></div>';
    } else {
        tr += '<div class="divTit">客户名：<span>' + order.customerOrSupplierName + '</span></div>';
    }
    if (order.memberNo) {
        tr += '<div class="divTit">会员卡号：<span>'+ order.memberNo + '</span></div>';
        tr += '<div class="divTit">购卡/续卡类型：<span>'+ (order.memberType == null ? "" : order.memberType) + '</span></div>';

    }else {
        tr += '<div class="divTit">会员卡号：<span>' + '</span></div>';
        tr += '<div class="divTit">购卡/续卡类型：<span>' + '</span></div>';
    }

    tr += '<div class="divTit">储值原有金额：<span>' + Number(order.memberBalance - order.worth).toFixed(2) + '</span>元</div>';
    tr += '<div class="divTit">储值新增金额：<span>' + Number(order.worth).toFixed(2) + '</span>元</div>';
    tr += '<div class="divTit">储值余额：<span>' + Number(order.memberBalance).toFixed(2) + '</span>元</div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col width="75"><col><col width="100"><col width="100">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">服务项目</td><td>原有次数</td><td>新增</td><td>剩余次数</td><td>限消费车牌</td><td>失效日期</td></tr>';
    if(!items || items.length == 0) {
        tr += '<tr><td colspan="6">对不起，该单据无服务项目！</td></tr>';
    } else {
        for (var i = 0, max = items.length; i < max; i++) {
            //卡的每项服务
            var item = items[i];
            tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
            tr += '<td>' + (!item.oldTimes ? 0 : (Number(item.oldTimes) == -1 ? "不限次" : item.oldTimes)) + '</td>';
            //新增无限次 逻辑
            tr += '<td>' + (!item.increasedTimes ? "" : ((Number(item.increasedTimes) ) == -1 && (item.increasedTimesLimitType == "UNLIMITED") ? "不限次" : item.increasedTimes)) + '</td>';
            tr += '<td>' + (!item.balanceTimes ? "" : (Number(item.balanceTimes) == -1 ? "不限次" : item.balanceTimes)) + '</td>';
            //限制车辆
            tr += '<td>' + (!item.vehicles ? "无" : (item.vehicles)) + '</td>';
            tr += '<td style="border-right:none;">' + (item.deadlineStr ? item.deadlineStr : "--") + '</td>';
            tr += '</tr>';
        }
    }
    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实收：<span class="red_color">' + order.settled + '</span>元</div>';
    tr += '<div class="total_line">欠款：<span class="red_color">' + order.debt + '</span>元</div>';

    tr += '</div><div class="total">备注：<span>' + (order.memo?order.memo:"") + '</span></div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));
}

//会员退卡
function getMemberReturnCardItems(order,idPrefix) {
    var items = order.itemIndexDTOs;
    var tr = '<tr class="document" id="' + idPrefix + '.orderDetail' + '">';
    tr += '<td colspan="9"><div class="divListInfo">';
    if ("DISABLED" == order.customerStatus) {
        tr += '<div class="divTit">客户名：<span style="color:#999999">' + order.customerOrSupplierName + '</span></div>';
    } else {
        tr += '<div class="divTit">客户名：<span>' + order.customerOrSupplierName + '</span></div>';
    }
    if (order.memberNo) {
        tr += '<div class="divTit">会员卡号：<span>'+ order.memberNo + '</span></div>';
        tr += '<div class="divTit">退卡类型：<span>'+ order.memberType + '</span></div>';

    }else {
        tr += '<div class="divTit">会员卡号：<span>' + '</span></div>';
        tr += '<div class="divTit">退卡类型：<span>' + '</span></div>';
    }
    tr += '<div class="divTit">上次购卡金额：<span>' + Number(order.memberLastBuyTotal).toFixed(2) + '</span>元</div>';
    tr += '<div class="divTit">上次购卡日期：<span>' + order.memberLastBuyDateStr + '</span></div>';
    tr += '<div class="divTit">上次储值金额：<span>' + (GLOBAL.Lang.isEmpty(order.memberLastRecharge) ? 0 : Number(order.memberLastRecharge).toFixed(1)) + '</span>元</div>';
    tr += '<div class="divTit">储值余额：<span>' + (GLOBAL.Lang.isEmpty(order.memberBalance) ? 0 : Number(order.memberBalance).toFixed(2)) + '</span>元</div>';
    tr += '<table cellpadding="0" cellpadding="0" class="tab_document">';
    tr += '<col><col width="100"><col width="100">';
    tr += '<tr class="tit_bg"><td style="padding-left:5px;">服务项目</td><td>上次购买次数</td><td>剩余次数</td></tr>';
    if(items) {
        for (var i = 0, max = items.length; i < max; i++) {
            //卡的每项服务
            var item = items[i];
            tr += '<td>' + (!item.itemName ? "" : item.itemName) + '</td>';
            tr += '<td>' + (!item.oldTimes ? "" : (Number(item.oldTimes) == -1 ? "不限次" : item.oldTimes)) + '</td>';
            tr += '<td>' + (!item.balanceTimes ? "" : (Number(item.balanceTimes) == -1 ? "不限次" : item.balanceTimes)) + '</td>';
            tr += '</tr>';
        }
    }

    tr += '</table><div class="i_height"></div>';
    tr += '<div class="total">';
    tr += '<div class="total_line">合计：<span class="red_color">' + order.amount + '</span>元</div>';
    tr += '<div class="total_line">实付：<span class="red_color">' + Math.abs(order.settled) + '</span>元</div>';
    tr += '<div class="i_height"></div><div class="i_height"></div><div class="div_Btn"><a class="btnUp"></a></div></div></td></tr>';
    $("#" + idPrefix + "\\.bottom").after($(tr));

}

function openWindow(url) {
    window.open(encodeURI(url));
}

function productSuggestion($domObject) {
    var searchWord = $domObject.val().replace(/[\ |\\]/g, "");
    var dropList = APP_BCGOGO.Module.droplist;
    dropList.setUUID(GLOBAL.Util.generateUUID());
    var currentSearchField = $domObject.attr("searchField");
    var ajaxData = {
        searchWord: searchWord,
        searchField: currentSearchField,
        uuid: dropList.getUUID()
    };
    $domObject.prevAll(".J-productSuggestion").each(function () {
        var val = $(this).val().replace(/[\ |\\]/g, "");
        if($(this).attr("name")!="searchWord"){
            ajaxData[$(this).attr("name")] = val == $(this).attr("initValue") ? "" : val;
        }
    });

    var ajaxUrl = "product.do?method=getProductSuggestion";
    APP_BCGOGO.wjl.LazySearcher.lazySearch(ajaxUrl, ajaxData, function (result) {
        if (currentSearchField == "product_info") {
            dropList.show({
                "selector": $domObject,
                "autoSet": false,
                "data": result,
                onGetInputtingData: function() {
                    var details = {};
                    $domObject.nextAll(".J-productSuggestion").each(function () {
                        var val = $(this).val().replace(/[\ |\\]/g, "");
                        details[$(this).attr("searchField")] = val == $(this).attr("initValue") ? "" : val;
                    });
                    return {
                        details:details
                    };
                },
                onSelect: function (event, index, data, hook) {
                    $domObject.nextAll(".J-productSuggestion").each(function () {
                        var label = data.details[$(this).attr("searchField")];
                        if (G.Lang.isEmpty(label) && $(this).attr("initValue")) {
                            $(this).val($(this).attr("initValue"));
                            $(this).css({"color": "#ADADAD"});
                        } else {
                            $(this).val(G.Lang.normalize(label));
                            $(this).css({"color": "#000000"});
                        }
                    });
                    dropList.hide();
                },
                onKeyboardSelect: function (event, index, data, hook) {
                    $domObject.nextAll(".J-productSuggestion").each(function () {
                        var label = data.details[$(this).attr("searchField")];
                        if (G.Lang.isEmpty(label) && $(this).attr("initValue")) {
                            $(this).val($(this).attr("initValue"));
                            $(this).css({"color": "#ADADAD"});
                        } else {
                            $(this).val(G.Lang.normalize(label));
                            $(this).css({"color": "#000000"});
                        }
                    });
                }
            });
        }else{
            dropList.show({
                "selector": $domObject,
                "data": result,
                "onSelect": function (event, index, data) {
                    $domObject.val(data.label);
                    $domObject.css({"color": "#000000"});
                    $domObject.nextAll(".J-productSuggestion").each(function () {
                        clearSearchInputValueAndChangeCss(this);
                    });
                    dropList.hide();
                }
            });
        }
    });
}

function clearSearchInputValueAndChangeCss(domObject) {
    if($(domObject).attr("initValue")) {
        $(domObject).val($(domObject).attr("initValue"));
        $(domObject).css({
            "color": "#ADADAD"
        });
    } else {
        $(domObject).val("");
    }
}

// 会员类型
$("#memberCardType")
    .click(function () {
        var offset = $("#memberCardType").offset();
        var offsetHeight = $("#memberCardType").height();
        var offsetWidth = $("#memberCardType").width();
        $("#memberCardTypesPanel").css({
            'display':'block', 'position':'absolute',
            'left':offset.left + 'px', 'top':offset.top + offsetHeight + 3 + 'px',
            'overflow-x':"hidden", 'overflow-y':"hidden",
            'color':'#000000', 'padding-left':0 + 'px',
            'width':offsetWidth
        });
    })
    .blur(function (event) {
        var initialValue = $(event.target).attr("initValue");
        if (initialValue != null && initialValue != "") {
            if (event.target.value == '') {
                event.target.value = initialValue;
                $(this).css({"color":"#ADADAD"});
            }
        } else {
            $(this).css({"color":"#000000"});
        }
    })
    .focus(function (event) {
        var initialValue = $(event.target).attr("initValue");
        if (initialValue != null && initialValue != "") {
            if (event.target.value == initialValue) {
                event.target.value = "";
            }
            $(this).css({"color":"#000000"});
        }
    });
