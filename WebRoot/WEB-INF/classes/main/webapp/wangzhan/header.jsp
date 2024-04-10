<%@ page language="java" contentType="text/html; charset=utf-8"  import="com.model.*,com.util.*,java.util.List,java.util.ArrayList"  pageEncoding="utf-8"%>
   
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	
	// 权限验证
	User user = (User)session.getAttribute("user");
	int userId = 0;
	if(user!=null){
		userId = user.getUserId();
	}
%>
<%@ include file="../jiazai/jcpeizhibaohan.jsp"%>
<%
	Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi");
%>
<%@ include file="../jiazai/headerbaohan.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=newJcpeizhi.getJcpeizhiName()%></title>
	<script type="text/javascript" src="<%=basePath %>jquery-easyui-1.3.3/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="renderer" content="webkit" />
	<meta name="robots" content="index, follow" />
    <!-- Styles -->
	<meta name="author" content="order by website" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>wangzhan/skin/css/font-awesome.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>wangzhan/skin/css/bootstrap.min.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>wangzhan/skin/css/owl.carousel.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>wangzhan/skin/css/owl.theme.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>wangzhan/skin/css/settings.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>wangzhan/skin/css/style-red.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=basePath %>wangzhan/skin/css/tk.css" media="screen" />
	<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/owl.carousel.min.js"></script>
</head>

	<body>
		<div id="container">
			<header class="clearfix" id="header-sec">
				<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
					<div class="top-line">
						<div class="container">
							<div class="row">
								<div class="col-md-8 col-sm-9 topbar-left">
									<ul class="info-list">
										<li class="tb-adword"><span>欢迎光临<%=newJcpeizhi.getJcpeizhiName()%></span></li>
									</ul>
								</div>
								<div class="col-md-4 col-sm-3 topbar-right">
									<ul class="social-icons">
										<li>
										<%if(userId==0){%>
				    						<a href="<%=basePath %>shouye/index.jsp">登录注册</a>
									    <%}else{%>
									    	<a href="<%=basePath %>houtai/userMain.jsp">个人中心</a>
									    <%}%>
										</li>
										<li>
											<a href="<%=basePath %>wangzhan/sjxiaoxi/sjxiaoxishow.jsp?sjxiaoxiId=1">关于我们</a>
										</li>
										<li>
											<a href="<%=basePath %>wangzhan/sjxiaoxi/sjxiaoxishow.jsp?sjxiaoxiId=2">联系我们</a>
										</li>
										<li>
											<a href="<%=basePath %>">网站首页</a>
										</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="container">
						<div class="navbar-header">
							<a class="navbar-brand" href="<%=basePath %>">
							<%=newJcpeizhi.getJcpeizhiName()%>
							</a>
						</div>
						<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
							<ul class="nav navbar-nav navbar-right" id="navigation">
								<li class="Lev1">
									<a href="<%=basePath %>" class='menu1 active'>网站首页 </a>
								</li>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>wangzhan/sjxiaoxi/sjxiaoxishow.jsp?sjxiaoxiId=1">关于我们</a></li>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>wangzhan/sjxiaoxi/sjxiaoxishow.jsp?sjxiaoxiId=2">联系我们</a></li>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>wangzhan/gonggao/gonggaolist.jsp"><%=newJcpeizhi.getGonggaoBieming() %>信息</a></li>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>wangzhan/shuju/shujulist.jsp"><%=newJcpeizhi.getShujuBieming() %>信息</a></li>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>wangzhan/sjduochu/sjduochulist.jsp">交流<%=newJcpeizhi.getSjduochuBieming() %></a></li>
		                        <%if(userId==0){%>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>shouye/index.jsp">登录注册</a></li>
		                        <%}else{%>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>houtai/userMain.jsp">个人中心</a></li>
		                        <li class="Lev1"><a class='menu1' href="<%=basePath %>wangzhan/shuju/shujubiaoqian.jsp?userId=<%=userId %>">推荐<%=newJcpeizhi.getShujuBieming() %></a></li>
		                        <%}%>
								<li class="search nav-search active">
									<a href="javascript:;" class="open-search">搜</a>
									<form class="form-search" id="searchform" name="formsearch" action="<%=basePath%>wangzhan/shuju/shujulist.jsp">
										<input type="search" value=""  id="shujuName" name="shujuName" class="search-input" placeholder="输入关键字" />
										<button type="submit" class="search-btn">搜</button>
									</form>
								</li>
							</ul>
						</div>
					</div>
				</nav>
			</header>