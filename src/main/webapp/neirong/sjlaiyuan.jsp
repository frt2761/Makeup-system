<%@ page language="java" contentType="text/html; charset=utf-8"  
import="com.model.*,com.util.*,java.util.List,java.util.ArrayList,net.sf.json.JSONArray,net.sf.json.JSONObject,net.sf.json.JsonConfig"  
pageEncoding="utf-8"%>
<%
	String sjlaiyuanpage = "1";
	String sjlaiyuanrows = "4";
	String sjlaiyuanName = "";
	String sjlaiyuanId = (String) request.getParameter("sjlaiyuanId");
	
	StringBuffer sjlaiyuanparam = new StringBuffer("yuliucanshu=1");
	if (StringUtil.isNotEmpty(sjlaiyuanpage)) {
		sjlaiyuanparam.append("&page=" + sjlaiyuanpage);
	}
	if (StringUtil.isNotEmpty(sjlaiyuanrows)) {
		sjlaiyuanparam.append("&rows=" + sjlaiyuanrows);
	}
	if (StringUtil.isNotEmpty(sjlaiyuanName)) {
		sjlaiyuanparam.append("&sjlaiyuanName=" + sjlaiyuanName);
	}
	if (StringUtil.isNotEmpty(sjlaiyuanId)) {
		sjlaiyuanparam.append("&sjlaiyuanId=" + sjlaiyuanId);
	}

 %>
<%
	List<Sjlaiyuan> sjlaiyuans = new ArrayList<Sjlaiyuan>();
	Sjlaiyuan sjlaiyuan = null;
	int sjlaiyuansshuliang = 0;
	String sjlaiyuanpath = request.getContextPath();
	String sjlaiyuanbasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sjlaiyuanpath+"/";
	
	String sjlaiyuanurl = sjlaiyuanbasePath + "getSjlaiyuans";
	JSONObject sjlaiyuanresult = PostUtil.sendPost(sjlaiyuanurl, sjlaiyuanparam.toString());
	if(sjlaiyuanresult!=null){
		JSONArray sjlaiyuanjsonArray = (JSONArray)sjlaiyuanresult.get("rows");
		//System.out.println(sjlaiyuanjsonArray);
		sjlaiyuans = JSONArray.toList(sjlaiyuanjsonArray, new Sjlaiyuan(), new JsonConfig());
		if(sjlaiyuans.size()>0){
			sjlaiyuan = sjlaiyuans.get(0);
		}
		//for(int i = 0;i < sjlaiyuans.size();i++){
		//	System.out.println(sjlaiyuans.get(i).getSjlaiyuanName());
		//}
		sjlaiyuansshuliang = (Integer)sjlaiyuanresult.get("total");
		//System.out.println(sjlaiyuansshuliang);
	}
%>