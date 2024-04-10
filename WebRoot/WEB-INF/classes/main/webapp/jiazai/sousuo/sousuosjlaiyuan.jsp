<%@ page language="java" contentType="text/html; charset=utf-8"  
import="com.model.*,com.util.*,java.util.List,java.util.ArrayList,net.sf.json.JSONArray,net.sf.json.JSONObject,net.sf.json.JsonConfig"  
pageEncoding="utf-8"%>
<%
	String sousuoSjlaiyuanpage = (String) request.getParameter("page");
	String sousuoSjlaiyuanrows = (String) request.getParameter("rows");
	String sousuoSjlaiyuanName = (String) request.getParameter("sjlaiyuanName");
	String sousuoSjlaiyuanId = (String) request.getParameter("sjlaiyuanId");
	String sousuosjlaiyuanType = "0";
	
	StringBuffer sousuoSjlaiyuanparam = new StringBuffer("yuliucanshu=1");
	if (StringUtil.isEmpty(sousuoSjlaiyuanpage)) {
		sousuoSjlaiyuanpage = "1";
	}
	sousuoSjlaiyuanparam.append("&page=" + sousuoSjlaiyuanpage);
	if (StringUtil.isEmpty(sousuoSjlaiyuanrows)) {
		sousuoSjlaiyuanrows = "12";
	}
	sousuoSjlaiyuanparam.append("&rows=" + sousuoSjlaiyuanrows);
	if (StringUtil.isNotEmpty(sousuoSjlaiyuanName)) {
		sousuoSjlaiyuanparam.append("&sjlaiyuanName=" + sousuoSjlaiyuanName);
	}
	if (StringUtil.isNotEmpty(sousuoSjlaiyuanId)) {
		sousuoSjlaiyuanparam.append("&sjlaiyuanId=" + sousuoSjlaiyuanId);
	}
	if (StringUtil.isNotEmpty(sousuosjlaiyuanType)) {
		sousuoSjlaiyuanparam.append("&sjlaiyuanType=" + sousuosjlaiyuanType);
	}

	List<Sjlaiyuan> sousuoSjlaiyuans = new ArrayList<Sjlaiyuan>();
	Sjlaiyuan sousuoSjlaiyuan = null;
	int sousuoSjlaiyuansshuliang = 0;
	String sousuoSjlaiyuanpath = request.getContextPath();
	String sousuoSjlaiyuanbasePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+sousuoSjlaiyuanpath+"/";
	
	String sousuoSjlaiyuanurl = sousuoSjlaiyuanbasePath + "getSjlaiyuans";
	JSONObject sousuoSjlaiyuanresult = PostUtil.sendPost(sousuoSjlaiyuanurl, sousuoSjlaiyuanparam.toString());
	if(sousuoSjlaiyuanresult!=null){
		JSONArray sousuoSjlaiyuanjsonArray = (JSONArray)sousuoSjlaiyuanresult.get("rows");
		//System.out.println(sousuoSjlaiyuanjsonArray);
		sousuoSjlaiyuans = JSONArray.toList(sousuoSjlaiyuanjsonArray, new Sjlaiyuan(), new JsonConfig());
		if(sousuoSjlaiyuans.size()>0){
			sousuoSjlaiyuan = sousuoSjlaiyuans.get(0);
		}
		//for(int i = 0;i < sjlaiyuans.size();i++){
		//	System.out.println(sjlaiyuans.get(i).getSjlaiyuanName());
		//}
		sousuoSjlaiyuansshuliang = (Integer)sousuoSjlaiyuanresult.get("total");
		//System.out.println(sjlaiyuansshuliang);
	}
	int sjlaiyuanrowCount = 1;
	sjlaiyuanrowCount = Integer.parseInt(sousuoSjlaiyuanrows);
	int sjlaiyuancurrPage = 0;
	sjlaiyuancurrPage = Integer.parseInt(sousuoSjlaiyuanpage);
	int sjlaiyuantotalPage = 0;
	sjlaiyuantotalPage = (sousuoSjlaiyuansshuliang + sjlaiyuanrowCount - 1)/sjlaiyuanrowCount;
%>