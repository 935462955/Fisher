/**
 * 
 */
function switchValue(x){
	var va =x.attributes["value"].value;
	var v = x.innerHTML;
	x.attributes["value"].value=$("btn-type").attr("value");
	x.innerHTML=$("#btn-type").html();
	$("#btn-type").html(v);
	$("#btn-type").attr("value",va);
}

function submit1(){
	$("#typeId").attr("value",$("#btn-type").attr("value"));
	$(".form1").submit();
}

function editModeChange(x){
	if($(".btn-delete").css('display')=='none'){
		x.innerHTML = "预览 <span class=\"glyphicon glyphicon-eye-open\"></span>";
		$(".btn-delete").show();
		$(".btn-update").show();
	}
	else{
		x.innerHTML = "编辑 <span class=\"glyphicon glyphicon-pencil\"></span>";
		$(".btn-delete").hide();
		$(".btn-update").hide();
	}
}

function Del(x,y){//x:this y:type
    var parent = x.parentNode;
    var childNode = parent.firstChild;
    var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    { 
		
	    var x=xmlhttp.responseText;
	    if(x == "false")
	    	alert("删除失败!");
	    else{
	    	parent.remove();
	    }
	    
	    }
	  }
	  if(y == "fish"){
		  
	  var fishName =$(parent).find("h2").html();
	  var file = $(parent).find("img").attr("src");
	  while(file.indexOf('\\')>0)
	  file = file.replace('\\','/');// '\'符号在URL中是特殊字符不能传送，把它替换为'/'在后台再转回来
      xmlhttp.open("GET","deleteWork?deleteValue="+fishName+"&deleteType="+y+"&fileURL="+file,true);
	  
	  }
	  else
	  xmlhttp.open("GET","deleteWork?deleteValue="+childNode.innerHTML+"&deleteType="+y,true);
	  xmlhttp.send();
}

function Update(x){//x:type
    var xmlhttp; 
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    { 
		
	    var x=xmlhttp.responseText;
	    if(x == "false")
	    	alert("更新失败!");
	    else{
	    	var s = "valueA"+$("#index").val();
	    	document.getElementById(s).innerHTML = $("#updateInput").val();
	        $(".close").click();
	    }
	    
	    }
	  }
	  xmlhttp.open("GET","updateWork?oldValue="+$("#oldValue").val()+"&updateType="+x+"&newValue="+$("#updateInput").val(),true);
	  xmlhttp.send();
}

function Insert(x){//x:type
	
    var xmlhttp; 
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    { 
		
	    var x=xmlhttp.responseText;
	    if(x == "false")
	    	alert("添加失败!请检查是否已存在现有的目标");
	    else{
	    
	        $(".close").click();
	        location.reload(true);
	    }
	    
	    }
	  }
	  if(x == "list")
	  xmlhttp.open("GET","insertWork?insertType="+x+"&newValue="+$("#insertInput").val(),true);
	  else if(x == "family")  
	  xmlhttp.open("GET","insertWork?insertType="+x+"&list="+document.getElementById("listName").innerHTML+"&family="+$("#insertInput").val(),true);	  
	  else if(x == "category")
	  xmlhttp.open("GET","insertWork?insertType="+x+"&family="+document.getElementById("familyName").innerHTML+"&category="+$("#insertInput").val(),true);
	  xmlhttp.send();
	  
}	
	
function getUpdateVal(x,y){//x:this y:index i
	var parent = x.parentNode;
	var child = parent.firstChild;
	$("#updateInput").val(child.innerHTML);
    $("#oldValue").val(child.innerHTML);
    $("#index").val(y);
}

function beforeSubmit(){
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	  xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    { 
		
	    var x=xmlhttp.responseText;
	    if(x == "false")
	    	alert("数据已存在！");
	    else if(x == "")alert("名称不能为空!");
	    else if($("#list").val() =="") alert("目不能为空!");
	    else if($("#family").val() =="") alert("科不能为空!");
	    else if($("#category").val() =="") alert("属不能为空!");
	    else{
	    	if($("#localName").val() =="")
	    		$("#localName").val("无");
	    	if($("#EnglishName").val() =="")
	    		$("#EnglishName").val("无");
	    	if($("#origin").val() == "")
	    		$("#origin").val("无");
	    	if($("#introduction").val() == "")
	    		$("#introduction").val("无");
	    	 $("#form1").submit();
	    }
	    }
	  }
	  xmlhttp.open("GET","CheckDuplicate?value="+$("#fishName").val()+"&type=fish",true);
	  xmlhttp.send();
}
