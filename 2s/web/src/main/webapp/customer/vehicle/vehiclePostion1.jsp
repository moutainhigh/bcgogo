<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=760f39e8b3f09ae5a4d3a0c7b97bc504"></script>
</head>
<body>
<div id="allmap" style="width: 100%;height: 500px;;overflow: hidden;margin:0"></div>
</body>


<script type="text/javascript">

    function getUrlParameter(name) {
        "use strict";
        return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search) || [, ""])[1].replace(/\+/g, '%20')) || "";
    }

    function initVehiclePosition() {



        var map = new BMap.Map("allmap");
        map.enableScrollWheelZoom();
        map.enableDoubleClickZoom();
        map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
        map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL}));  //右上角，仅包含平移和缩放按钮
        map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_LEFT, type: BMAP_NAVIGATION_CONTROL_PAN}));  //左下角，仅包含平移按钮
        map.addControl(new BMap.NavigationControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, type: BMAP_NAVIGATION_CONTROL_ZOOM}));  //右下角，仅包含缩放按钮
        var url = location.search; //获取url中"?"符后的字串
//        var url  = "?"+json;
        var strs = null;
        if (url.indexOf("?") != -1) {

            if(url.indexOf("shopCoordinate") != -1){
                var shopCoordinate = getUrlParameter("shopCoordinate");
                strs = shopCoordinate.split("_");

                if(!(strs[1].length == 0 || strs[0].length==0)){
                    var point = new BMap.Point(strs[0],strs[1]);
                    map.centerAndZoom(point,12);
                }else{
                    var city = getUrlParameter("city");
                    map.centerAndZoom(city,12);
//
//                    map.setCenter(city);
//                    map.setZoom(12);
                }

            }else{
                var str = url.substr(1);
                strs = str.split(",,,");
                if (strs.length <= 0) {
                    return;
                }


                var array = new Array(strs.length);

                for (var index = 0; index < strs.length; index++) {
                    var gsmPointDTO = strs[index].split("__");
                    var lat = gsmPointDTO[0];
                    var lon = gsmPointDTO[1];
                    var point = new BMap.Point(lon, lat);
                    array[index] = point;
                }

                map.setViewport(array);
                var zoom = map.getZoom();
                map.setZoom(zoom - 1);

                for (var index = 0; index < strs.length; index++) {
                    var gsmPointDTO = strs[index].split("__");
                    var lat = gsmPointDTO[0].substr(0, 6);
                    var lon = gsmPointDTO[1].substr(0, 6);

                    var uploadServerTimeStr = gsmPointDTO[2].replace("%20"," ");
                    var address = decodeURI(gsmPointDTO[3]);
                    var vehicleNo = decodeURI(gsmPointDTO[4]);

                    // 百度地图API功能
                    var sContent =
                            "<p style='margin:0;line-height:1.0;font-size:13px;text-indent:1em'>车牌号:" + vehicleNo + "</p>" +
                                    "<p style='margin:0;line-height:1.0;font-size:13px;text-indent:1em'>经度:" + lon + " 纬度:" + lat + "</p>" +
//        "<p style='margin:0;line-height:1.5;font-size:13px;text-indent:2em'>速度:"+ speed+"</p></br>" +
                            "<p style='margin:0;line-height:1.0;font-size:13px;text-indent:1em'>地址:" + address + "</p>" +
                            "<p style='margin:0;line-height:1.0;font-size:13px;text-indent:1em'>时间:" + uploadServerTimeStr + "</p>";
                    var gpsPoint = null;
                    var marker = null;

                    var opts = {
                        width: 80,     // 信息窗口宽度
                        height: 80,     // 信息窗口高度
                        title: "车辆定位", // 信息窗口标题
                        enableMessage: false,//设置允许信息窗发送短息
                        message: ""
                    }

                    gpsPoint = new BMap.Point(lon, lat);
                    marker = new BMap.Marker(gpsPoint);
                    map.addOverlay(marker);

                    var infoWindow = new BMap.InfoWindow(sContent, opts);  // 创建信息窗口对象
                    if(index ==0){
                        marker.openInfoWindow(infoWindow);
                        marker.open = "true";
                    }


                    marker.addEventListener("click", function () {
                        if (this.open == "true") {
                            this.closeInfoWindow(infoWindow);
                            this.open = "false";
                        } else {
                            this.openInfoWindow(infoWindow);
                            this.open == "true"
                        }
                    });
                }

            }


        }




    }
    initVehiclePosition();


</script>
</html>