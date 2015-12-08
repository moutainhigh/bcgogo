﻿(function(){window.$=function(_1,_2){return (_2||document).getElementById(_1);};
function $1(_1,_2,_3,_4){if(_2 in _1&&_1._2.version>=_3)return;_4.version=_3;_1[_2]=_4;};
(function(){var $1=1.1;if("js" in window&&window.js.version>=$1)return;var $={version:$1};$.$ie=navigator.appName=="Microsoft Internet Explorer";window.js=$;})();
(function(){var $1=1.0;if("html" in js&&js.html.version>=$1)return;var $={version:$1};$.$=function(_1,_2){return (_2||document).createElement(_1);};$.$text=function(_1,_2){return (_2||document).createTextNode(_1);};$.$window=function(_){return _.parentWindow||_.defaultView||null;};$.$style=function(_){return _.currentStyle||window.getComputedStyle(_,null);};js.html=$;})();
(function(){var $1=1.0;if("xml" in js&&js.xml.version>=$1)return;var $={version:$1};$.$=function(){if(typeof ActiveXObject!="undefined")return new ActiveXObject("Microsoft.XMLDOM");else if(document.implementation)return document.implementation.createDocument("", "", null);else throw null;};$.parse = function(_){if(typeof ActiveXObject!="undefined"){var _1=this.$();_1.async=false;_1.loadXML(_);return _1;}else if(typeof DOMParser!="undefined")return new DOMParser().parseFromString(_,"text/xml");else throw null;};$.serialize = function(_){if("xml" in _)return _.xml;else if(typeof XMLSerializer!="undefined")return new XMLSerializer().serializeToString(_);else throw null;};$.selectNodes=function(_1,_2){if(typeof _1!="object"||_1==null)throw null;if("selectNodes" in _1){var _4=_1.selectNodes(_2);var _5=[];for(var i=0,l=_4.length;i<l;i++){_5.push(_4[i]);}return _5;}var _3=_1.nodeType==9?_1:_1.ownerDocument;if(_3.evaluate){var _4=_3.evaluate(_2,_1,null,XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,null);var _5=[];for(var i=0,l=_4.snapshotLength;i<l;i++){_5.push(_4.snapshotItem(i));}return _5;}else throw null;};js.xml=$})();
(function(){var $1=1.1;if("http" in js&&js.http.version>=$1)return;var $={version:$1};$.$=function(_){var _1;if(typeof ActiveXObject!="undefined")_1=new ActiveXObject("Microsoft.XMLHTTP");else if(typeof XMLHttpRequest!="undefined")_1=new XMLHttpRequest();else throw null;if(_&&"url" in _){if("data" in _){_1.open("POST",_.url,false);_1.setRequestHeader("CONTENT-TYPE","application/x-www-form-urlencoded");var _2="";for(var _3 in _.data){_2+="&"+_3+"="+(_.data[_3]==null?"":encodeURIComponent(_.data[_3]));}_1.send(_2.length>0?_2.substr(1):null);}else{_1.open("GET",_.url,false);_1.send(null);}if(_1.status==200){if(_["header"]){for(var _5 in _.header){_.header[_5]=_1.getResponseHeader(_5);}}return _1.getResponseHeader("Content-Type")=="text/xml"?_1.responseXML:_1.responseText;}else return null;}else return _1;};$.get=function(_){return this.$({"url":_});};$.post=function(_1,_2){return this.$({"url":_1,"data":_2});};js.http=$;})();
(function(){var $1=1.0;if("cookie" in js&&js.cookie.version>=$1)return;var $={version:$1};$.set = function(_1, _2, _3){var _4="";if(_2){if(_2.expires){_4+="; expires="+_2.expires.toGMTString();}if("max-age" in _2){_4+="; max-age="+_2["max-age"];}if(_2.path){_4+="; path="+_2.path;}if(_2.domain){_4+="; domain="+_2.domain;}}for(var _5 in _1){(_3||document).cookie=_5+"="+escape(_1[_5])+_4;}};$.get=function(_1,_2){var _3=(_2||document).cookie.split("; ");for(var i=0,l=_3.length;i<l;i++){var _4=_3[i].split("=");if(_4[0]==_1)return unescape(_4[1]||"");}return null;};js.cookie=$;})();

$1(js,"string",1.0,function(){var $={};$.trim=function(_){return _;};$.parsesearch=function(_){if(typeof _!="string")return null;_=this.trim(_);if(_.charAt(0)=="?"){_=_.substr(1);}if(_.length==0)return null;var _1=null;var _2=_.split("&");for(var i=0,l=_2.length;i<l;i++){var _3=_2[i].split("=");if(_1==null){_1=new Object();}_1[decodeURIComponent(_3[0])]=decodeURIComponent(_3[1]);}return _1;};return $;}());

$1(js,"event",1.0,function(){var $={};$.$target=function(_){return _.srcElement||_.target;};$.add=function(_1,_2,_3){if(_1.attachEvent)_1.attachEvent("on"+_2,_3);else if(_1.addEventListener)_1.addEventListener(_2,_3,false);else throw null;};$.remove=function(_1,_2,_3){if(_1.detachEvent)_1.detachEvent("on"+_2,_3);else if(_1.removeEventListener)_1.removeEventListener(_2,_3,false);else throw null;};$.EventListener=function(){var $1=[];this.addEventListener=function(_1,_2){$1.push([_1,_2]);};this.removeEventListener=function(){var _1=arguments[0];var _2=typeof _1=="string";var _3=_2?arguments[1]:_1;var _4=typeof _3=="function";for(var i=0,l=$1.length;i<l;i++)if((!_2||$1[i][0]==_1)&&(!_4||$1[i][1]==_3))return $1.splice(i,1)[0];};this.fireEvent=function(_){for(var i=0,l=$1.length;i<l;i++)if($1[i][0]==_)if($1[i][1].apply(this,arguments))break;};};return $;}());})();