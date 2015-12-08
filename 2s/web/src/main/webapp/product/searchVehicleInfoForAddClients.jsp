<%@ page import="com.bcgogo.config.ConfigController" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%--
  Created by IntelliJ IDEA.
  User: wjl
  Date: 11-9-30
  Time: 上午9:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/WEB-INF/views/includes.jsp" %>
<head>
    <title>无标题文档</title>
    <%
        String webapp = request.getContextPath();
        String domtitle = request.getParameter("domtitle");
        String brandvalue = request.getParameter("brandvalue");
    %>
</head>
<link rel="stylesheet" type="text/css" href="<%=webapp%>/styles/up<%=ConfigController.getBuildVersion()%>.css"/>
<script type="text/javascript" src="js/extension/jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/base<%=ConfigController.getBuildVersion()%>.js"></script>
<script type="text/javascript" src="js/application<%=ConfigController.getBuildVersion()%>.js"></script>

<script type="text/javascript" src="js/invoicing<%=ConfigController.getBuildVersion()%>.js"></script>
<script type="text/javascript" src="js/jsScroller<%=ConfigController.getBuildVersion()%>.js"></script>
<script type="text/javascript" src="js/jsScrollbar<%=ConfigController.getBuildVersion()%>.js"></script>
<script type="text/javascript">
    $().ready(function () {
        $('#div_close').bind('click', closeWindow);
        $('#div_close_1').bind('click', closeWindow);
    });

    function closeWindow() {
//        window.parent.document.getElementById("mask").style.display = "none";
        window.parent.document.getElementById("iframe_PopupBox_1").style.display = "none";
        //window.parent.document.getElementById("iframe_PopupBox_1").src = "";
        try {
            $(window.parent.document.body).find("input[type='button']").eq(0).focus().blur();
        } catch(e) {
            ;
    }
    }
    var arr;
    var domtitle2 = "<%=domtitle%>";
    $(function () {
        $(".i_upBody ul>li").click(function () {
            $(".i_upBody ul>li").removeAttr("class");
            $(this).attr("class", "brand_hover");
            var firstLetter = $(this).html();
            searchInfo(firstLetter);
        });
        searchInfo('A');
    });
    function searchInfo(flag) {
        var sb = "";
        var domtitle = "<%=domtitle%>";
        var brandvalue = "<%=brandvalue%>";
        $.ajax({
                    url:"product.do?method=searchbrandforvehicle",
                    async:true,
                    data:{flInfo:flag, domtitle:domtitle, brandvalue:brandvalue},
                    cache:false,
                    dataType:"json",
                    success:function (jsonMfr) {
                        for (var i = 0; i < jsonMfr.length; i++) {
                            sb += "<a>" + jsonMfr[i].name + "</a>";
                        }
                        $(".Scroller-Container").html(sb);
                        $(".Scroller-Container>a").click(function () {
                            if (domtitle == "brand") {
                                var parentBrand = parent.document.getElementById("iframe_PopupBox").contentWindow.document.getElementById("brand");
                                var valflag = parentBrand.value != $(this).html() ? true : false;
                                parent.document.getElementById("iframe_PopupBox").contentWindow.vehicleAdjustment(parentBrand, valflag);
                                parentBrand.value = $(this).html();
                            } else if (domtitle == "model") {
                                var parentModel = parent.document.getElementById("iframe_PopupBox").contentWindow.document.getElementById("model");
                                var valflag = parentModel.value != $(this).html() ? true : false;
                                parent.document.getElementById("iframe_PopupBox").contentWindow.vehicleAdjustment(parentModel, valflag);
                                parentModel.value = $(this).html();
                            }
                            parent.document.getElementById("iframe_PopupBox_1").style.display = "none";
                        });
                    }
                }
        );
    }

</script>
<body>
<div class="i_searchBrand" id="div_show">
    <div class="i_arrow"></div>
    <div class="i_upLeft"></div>
    <div class="i_upCenter">
        <div class="i_note" id="div_drag">更多搜索</div>
        <div class="i_close" id="div_close"></div>
    </div>
    <div class="i_upRight"></div>
    <div class="i_upBody">
        <ul>
            <li class="brand_hover">A</li>
            <li>B</li>
            <li>C</li>
            <li>D</li>
            <li>E</li>
            <li>F</li>
            <li>G</li>
            <li>H</li>
            <li>I</li>
            <li>J</li>
            <li>K</li>
            <li>L</li>
            <li>M</li>
            <li>N</li>
            <li>O</li>
            <li>P</li>
            <li>Q</li>
            <li>R</li>
            <li>S</li>
            <li>T</li>
            <li>U</li>
            <li>V</li>
            <li>W</li>
            <li>X</li>
            <li>Y</li>
            <li>Z</li>
            <li>1</li>
            <li>2</li>
            <li>3</li>
            <li>4</li>
            <li>5</li>
            <li>6</li>
            <li>7</li>
            <li>8</li>
            <li>9</li>
            <li>0</li>
        </ul>
        <div id="div_searchBand" class="brandList">
            <div class="brandTop"></div>
            <div class="brandCenter"></div>
            <div class="brandBody">
            </div>
            <div class="brandLeft"></div>
            <div class="brandMiddle"></div>
        </div>
        <div class="i_sure"><input type="button" value="返 回" onfocus="this.blur();" id="div_close_1"/></div>
    </div>
    <div class="i_upBottom">
        <div class="i_upBottomLeft"></div>
        <div class="i_upBottomCenter"></div>
        <div class="i_upBottomRight"></div>
    </div>
</div>
</body>
</html>
<div class="i_scroll">
    <div class="Container">
        <div id="Scroller-1">
            <div class="Scroller-Container">
            </div>
        </div>
    </div>
    <div class="i_scrollBar" id="Scrollbar-Container">
        <div class="Scrollbar-Up"></div>
        <div class="Scrollbar-Track">
            <img src="images/scroll.png" class="Scrollbar-Handle"/>
        </div>
        <div class="scroll-bottom"></div>
    </div>
</div>