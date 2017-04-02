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