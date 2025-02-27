<%@ page language="java" import="com.model.*"  pageEncoding="utf-8"%>
<% Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi"); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=newJcpeizhi.getSjduochuBieming()%><%=newJcpeizhi.getSjxingtaiBieming()%></title>
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/ui-pepper-grinder/easyui.css">
<link rel="stylesheet" type="text/css" href="../jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
var url;
	function searchSjxingtai(){
		$('#dg').datagrid('load',{
			sjxingtaiName:$('#s_sjxingtaiName').val()
		});
	}
	
	function saveSjxingtai(){
		$("#fm").form("submit",{
			url:url,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
			
				var s=result;
				var result = eval('(' + result + ')');
			
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
	
	function openSjxingtaiAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加<%=newJcpeizhi.getSjduochuBieming()%><%=newJcpeizhi.getSjxingtaiBieming()%>");
		url="../addSjxingtai";
	}
	
	function resetValue(){
	}
	
	function deleteSjxingtai(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].sjxingtaiId);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("../deleteSjxingtai",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功删除<font color=red>"+result.delNums+"</font>条数据！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].sjxingtaiName+'</font>'+result.errorMsg);
					}
				},"json");
			}
		});
	}
	
	function closeSjxingtaiDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	
	function openSjxingtaiModifyDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dlg").dialog("open").dialog("setTitle","编辑<%=newJcpeizhi.getSjduochuBieming()%><%=newJcpeizhi.getSjxingtaiBieming()%>");
		$("#fm").form("load",row);
		url="../addSjxingtai?sjxingtaiId="+row.sjxingtaiId;
	}
	
	function formatSex(sjduochuSex, row) {  
		if(sjduochuSex==0){
			return "男";
		}
		if(sjduochuSex==1){
			return "女";
		}
	}
	
	function formatType1(sjduochuType1, row) {  
		if(sjduochuType1==0){
			return "零";
		}
		if(sjduochuType1==1){
			return "一";
		}
	}
	
	function formatType(sjduochuType, row) {  
		if(sjduochuType==0){
			return "0";
		}
		if(sjduochuType==1){
			return "1";
		}
	}
	
	function formatChakan(sjduochuImg, row) {
		if(sjduochuImg){
			return '<a target="_blank" style="color:red;" href="../' + sjduochuImg + '">查看' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function formatXiazai(sjduochuImgName, row) {
		if(sjduochuImgName){
			return '<a target="_blank" style="color:red;" href="../downFile?filename=' + sjduochuImgName + '">下载' + '</a>'; 
		}else {
			return "未上传";
		}
	}
	
	function daochuSjxingtai(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要导出的数据！");
			return;
		}
		var sjxingtaiIds=[];
		for(var i=0;i<selectedRows.length;i++){
			sjxingtaiIds.push(selectedRows[i].sjxingtaiId);
		}
		var ids=sjxingtaiIds.join(",");
		$.messager.confirm("系统提示","您确认要导出数据吗？",function(r){
			if(r){
				$.post("../daochuSjxingtai",{delIds:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","您已成功导出数据：D:！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示','<font color=red>'+selectedRows[result.errorIndex].sjxingtaiName+'</font>'+result.errorMsg);
					}
				},"json");
			}
		});
	}
	
	function datetostr(date, row) {
		if(date){
			var date = new Date(date.time);
        	var y=date.getFullYear();
        	var m=date.getMonth()+1;
        	var d=date.getDate();
        	var h=date.getHours();
        	var m1=date.getMinutes();
        	var s=date.getSeconds();
        	m = m<10?("0"+m):m;
        	d = d<10?("0"+d):d;
        	return y+"-"+m+"-"+d;
			var text = JsonDateValue.toLocaleString();
			return text;
		}else{
			return "未填写";
		}
	}
	
	function doPrint() {      
        bdhtml=window.document.body.innerHTML;      
        sprnstr="<!--startprint-->";      
        eprnstr="<!--endprint-->";      
        prnhtml=bdhtml.substr(bdhtml.indexOf(sprnstr)+17);      
        prnhtml=prnhtml.substring(0,prnhtml.indexOf(eprnstr));      
        window.document.body.innerHTML=prnhtml;   
        window.print();      
	}
	
	function daoruSjxingtais(){
		$("#daoru").dialog("open").dialog("setTitle","导入<%=newJcpeizhi.getSjduochuBieming()%><%=newJcpeizhi.getSjxingtaiBieming()%>");
		daoruurl="../daoruSjxingtai";
	}
	
	function closeDaoruSjxingtai(){
		$("#daoru").dialog("close");
		resetValue();
	}
	
	function saveDaoruSjxingtai(){
		$("#drfm").form("submit",{
			url:daoruurl,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
			
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#daoru").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
	
	function shangchuanSjxingtai(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要编辑的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#shangchuan").dialog("open").dialog("setTitle","上传<%=newJcpeizhi.getSjduochuBieming()%><%=newJcpeizhi.getSjxingtaiBieming()%>");
		$("#shchfm").form("load",row);
		shchurl="../shangchuanSjxingtai?sjxingtaiId="+row.sjxingtaiId;
	}
	
	function closeShangchuanSjxingtai(){
		$("#shangchuan").dialog("close");
		resetValue();
	}
	
	function saveShangchuanSjxingtai(){
		$("#shchfm").form("submit",{
			url:shchurl,
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
			
				var s=result;
				var result = eval('(' + result + ')');
			
				if(result.errorMsg){
					$.messager.alert("系统提示",result.errorMsg);
					return;
				}else{
					$.messager.alert("系统提示","保存成功");
					resetValue();
					$("#shangchuan").dialog("close");
					$("#dg").datagrid("reload");
				}
			}
		});
	}
</script>
</head>
<body style="margin: 5px;">
<!--startprint-->
	<table id="dg" title="<%=newJcpeizhi.getSjduochuBieming()%><%=newJcpeizhi.getSjxingtaiBieming()%>" class="easyui-datagrid" fitColumns="true"
	 pagination="true" url="../getSjxingtais" fit="true" rownumbers="true" toolbar="#tb" nowrap="false">
		<thead>
			<tr>
				<th field="cb" checkbox="true"></th>
				<th field="sjxingtaiId" width="10" hidden="true">编号</th>
				<th field="sjxingtaiName" width="40">名称</th>
				<th field="sjxingtaiMark" width="40">备注</th>
			</tr>
		</thead>
	</table>
	
	<div id="tb">
		<div>
			<a href="javascript:openSjxingtaiAddDialog()" class="easyui-linkbutton" iconCls="icon-add" plain="true">添加</a>
			<a href="javascript:openSjxingtaiModifyDialog()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改</a>
			<a href="javascript:deleteSjxingtai()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除</a>
		</div>
	</div>
<!--endprint-->
	<div id="dlg" class="easyui-dialog" style="width: 540px;height: 140px;padding: 10px 20px"
		closed="true" buttons="#dlg-buttons">
		<form id="fm" method="post">
			<table cellspacing="5px;">
				<tr>
					<td>名称：</td>
					<td><input type="text" name="sjxingtaiName" id="sjxingtaiName" class="easyui-validatebox" required="true"/></td>
					<td>备注：</td>
					<td><input type="text" name="sjxingtaiMark" id="sjxingtaiMark" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:saveSjxingtai()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeSjxingtaiDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
<!--上传-->	
	<div id="shangchuan" class="easyui-dialog" style="width: 320px;height: 140px;padding: 10px 20px"
		closed="true" buttons="#shangchuan-buttons">
		<form id="shchfm" method="post" enctype="multipart/form-data">
			<table cellspacing="5px;">
				<tr>
					<td><input type="file" name="uploadFile" id="uploadFile" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="shangchuan-buttons">
		<a href="javascript:saveShangchuanSjxingtai()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeShangchuanSjxingtai()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
<!--导入-->	
	<div id="daoru" class="easyui-dialog" style="width: 320px;height: 140px;padding: 10px 20px"
		closed="true" buttons="#daoru-buttons">
		<form id="drfm" method="post" enctype="multipart/form-data">
			<table cellspacing="5px;">
				<tr>
					<td><input type="file" name="uploadFile" id="uploadFile" class="easyui-validatebox" required="true"/></td>
				</tr>
			</table>
		</form>
	</div>
	
	<div id="daoru-buttons">
		<a href="javascript:saveDaoruSjxingtai()" class="easyui-linkbutton" iconCls="icon-ok">保存</a>
		<a href="javascript:closeDaoruSjxingtai()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
	
</body>
</html>