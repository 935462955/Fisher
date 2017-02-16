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