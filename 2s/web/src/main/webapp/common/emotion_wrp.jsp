<%--
  Created by IntelliJ IDEA.
  User: ndong
  Date: 14-11-27
  Time: 下午1:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="emotion_wrp js_emotionArea" style="display: none;">
<ul onselectstart="return false;" class="emotions">

<li class="emotions_item">
    <i style="background-position:0px 0;" data-title="微笑"   class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-24px 0;" data-title="撇嘴"   class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-48px 0;" data-title="色" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/2.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-72px 0;" data-title="发呆" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/3.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-96px 0;" data-title="得意" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/4.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-120px 0;" data-title="流泪" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/5.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-144px 0;" data-title="害羞" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/6.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-168px 0;" data-title="闭嘴" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/7.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-192px 0;" data-title="睡" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/8.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-216px 0;" data-title="大哭" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/9.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-240px 0;" data-title="尴尬" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/10.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-264px 0;" data-title="发怒" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/11.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-288px 0;" data-title="调皮" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/12.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-312px 0;" data-title="呲牙" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/13.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-336px 0;" data-title="惊讶" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/14.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-360px 0;" data-title="难过" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/15.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-384px 0;" data-title="酷" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/16.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-408px 0;" data-title="冷汗" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/17.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-432px 0;" data-title="抓狂" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/18.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-456px 0;" data-title="吐" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/19.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-480px 0;" data-title="偷笑" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/20.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-504px 0;" data-title="可爱" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/21.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-528px 0;" data-title="白眼" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/22.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-552px 0;" data-title="傲慢" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/23.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-576px 0;" data-title="饥饿" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/24.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-600px 0;" data-title="困" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/25.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-624px 0;" data-title="惊恐" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/26.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-648px 0;" data-title="流汗" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/27.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-672px 0;" data-title="憨笑" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/28.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-696px 0;" data-title="大兵" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/29.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-720px 0;" data-title="奋斗" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/30.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-744px 0;" data-title="咒骂" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/31.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-768px 0;" data-title="疑问" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/32.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-792px 0;" data-title="嘘" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/33.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-816px 0;" data-title="晕" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/34.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-840px 0;" data-title="折磨" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/35.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-864px 0;" data-title="衰" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/36.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-888px 0;" data-title="骷髅" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/37.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-912px 0;" data-title="敲打" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/38.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-936px 0;" data-title="再见" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/39.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-960px 0;" data-title="擦汗" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/40.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-984px 0;" data-title="抠鼻" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/41.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1008px 0;" data-title="鼓掌" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/42.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1032px 0;" data-title="糗大了" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/43.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1056px 0;" data-title="坏笑" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/44.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1080px 0;" data-title="左哼哼" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/45.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1104px 0;" data-title="右哼哼" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/46.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1128px 0;" data-title="哈欠" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/47.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1152px 0;" data-title="鄙视" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/48.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1176px 0;" data-title="委屈" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/49.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1200px 0;" data-title="快哭了" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/50.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1224px 0;" data-title="阴险" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/51.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1248px 0;" data-title="亲亲" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/52.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1272px 0;" data-title="吓" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/53.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1296px 0;" data-title="可怜" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/54.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1320px 0;" data-title="菜刀" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/55.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1344px 0;" data-title="西瓜" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/56.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1368px 0;" data-title="啤酒" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/57.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1392px 0;" data-title="篮球" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/58.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1416px 0;" data-title="乒乓" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/59.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1440px 0;" data-title="咖啡" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/60.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1464px 0;" data-title="饭" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/61.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1488px 0;" data-title="猪头" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/62.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1512px 0;" data-title="玫瑰" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/63.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1536px 0;" data-title="凋谢" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/64.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1560px 0;" data-title="示爱" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/65.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1584px 0;" data-title="爱心" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/66.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1608px 0;" data-title="心碎" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/67.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1632px 0;" data-title="蛋糕" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/68.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1656px 0;" data-title="闪电" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/69.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1680px 0;" data-title="炸弹" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/70.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1704px 0;" data-title="刀" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/71.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1728px 0;" data-title="足球" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/72.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1752px 0;" data-title="瓢虫" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/73.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1776px 0;" data-title="便便" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/74.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1800px 0;" data-title="月亮" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/75.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1824px 0;" data-title="太阳" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/76.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1848px 0;" data-title="礼物" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/77.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1872px 0;" data-title="拥抱" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/78.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1896px 0;" data-title="强" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/79.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1920px 0;" data-title="弱" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/80.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1944px 0;" data-title="握手" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/81.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1968px 0;" data-title="胜利" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/82.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-1992px 0;" data-title="抱拳" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/83.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2016px 0;" data-title="勾引" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/84.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2040px 0;" data-title="拳头" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/85.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2064px 0;" data-title="差劲" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/86.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2088px 0;" data-title="爱你" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/87.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2112px 0;" data-title="NO" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/88.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2136px 0;" data-title="OK" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/89.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2160px 0;" data-title="爱情" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/90.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2184px 0;" data-title="飞吻" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/91.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2208px 0;" data-title="跳跳" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/92.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2232px 0;" data-title="发抖" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/93.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2256px 0;" data-title="怄火" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/94.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2280px 0;" data-title="转圈" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/95.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2304px 0;" data-title="磕头" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/96.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2328px 0;" data-title="回头" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/97.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2352px 0;" data-title="跳绳" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/98.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2376px 0;" data-title="挥手" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/99.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2400px 0;" data-title="激动" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/100.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2424px 0;" data-title="街舞" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/101.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2448px 0;" data-title="献吻" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/102.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2472px 0;" data-title="左太极" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/103.gif" class="js_emotion_i">
    </i>
</li>

<li class="emotions_item">
    <i style="background-position:-2496px 0;" data-title="右太极" data-gifurl="https://res.wx.qq.com/mpres/htmledition/images/icon/emotion/104.gif" class="js_emotion_i">
    </i>
</li>

</ul>
<span class="emotions_preview js_emotionPreviewArea"></span>
</div>