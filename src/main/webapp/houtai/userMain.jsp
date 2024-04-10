<%@ page language="java" contentType="text/html; charset=utf-8" import="com.model.*,java.util.List"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
    
<%
	// 权限验证
	User user = (User)session.getAttribute("user");
	if(user==null){
		System.out.println("没有得到userId");
		response.sendRedirect("shouye/index.jsp");
		return;
	}
	Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi");
	List<Jcbiaoti> jcbiaotis = (List<Jcbiaoti>)session.getAttribute("jcbiaotis");
	List<List<Jcdaohang>> jcdaohangslist = (List<List<Jcdaohang>>)session.getAttribute("jcdaohangslist");
	String userName = user.getUserName();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head id="Head1">
    <title><%=newJcpeizhi.getJcpeizhiName()%></title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel="stylesheet" href="<%=basePath%>houtai/muban2/layui/css/layui.css">
	<link rel="stylesheet" href="<%=basePath%>houtai/muban2/static/css/style.css">
	<script type="text/javascript" src="<%=basePath%>houtai/muban2/layui/layui.js"></script>
	<script type="text/javascript" src="<%=basePath%>houtai/muban2/static/js/vip_comm.js"></script>
</head>
<body>

<!-- layout admin -->
<div class="layui-layout layui-layout-admin"> <!-- 添加skin-1类可手动修改主题为纯白，添加skin-2类可手动修改主题为蓝白 -->
    <!-- header -->
    <div class="layui-header my-header">
            <!--<img class="my-header-logo" src="" alt="logo">-->
            <div class="my-header-logo"><%=newJcpeizhi.getJcpeizhiName()%></div>
        <div class="my-header-btn">
            <button class="layui-btn layui-btn-small btn-nav"><i class="layui-icon">&#xe65f;</i></button>
        </div>

        <!-- 顶部右侧添加选项卡监听 -->
        <ul class="layui-nav my-header-user-nav" lay-filter="side-top-right">
            <li class="layui-nav-item">
                <dl class="layui-nav-child">
                    <dd data-skin="0"><a href="javascript:;">默认</a></dd>
                    <dd data-skin="1"><a href="javascript:;">纯白</a></dd>
                    <dd data-skin="2"><a href="javascript:;">蓝白</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a class="name" href="javascript:;"><img src="<%=basePath%>houtai/muban2/static/image/code.png" alt="logo"><%=userName %></a>
                <dl class="layui-nav-child">
                    <dd><a href="javascript:;" href-url="<%=basePath%>shouye/neiye.jsp"><i class="layui-icon">&#xe621;</i>登录页</a></dd>
                    <dd><a href="javascript:;" href-url="<%=basePath%>user/usermima.jsp"><i class="layui-icon">&#xe621;</i>修改密码</a></dd>
                    <dd><a target="_blank"  href="<%=basePath%>"><i class="layui-icon">&#xe621;</i>返回网站</a></dd>
                    <dd><a href="<%=basePath%>shouye/tuichu.jsp"><i class="layui-icon">&#x1006;</i>退出</a></dd>
                </dl>
            </li>
        </ul>

    </div>
    <!-- side -->
    <div class="layui-side my-side">
        <div class="layui-side-scroll">
            <!-- 左侧主菜单添加选项卡监听 -->
            <ul class="layui-nav layui-nav-tree" lay-filter="side-main">
               <li class="layui-nav-item  layui-nav-itemed">
                    <a href="javascript:;"><i class="layui-icon">&#xe620;</i>个人信息</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" href-url="<%=basePath%>user/user.jsp"><i class="layui-icon">&#xe621;</i>个人信息</a></dd>
                        <dd><a href="javascript:;" href-url="<%=basePath%>user/usermima.jsp"><i class="layui-icon">&#xe621;</i>修改密码</a></dd>
                    </dl>
                </li>
                <%for(int i = 0; i < jcbiaotis.size(); i++){ %>
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon">&#xe62<%=i+1 %>;</i><%=jcbiaotis.get(i).getJcbiaotiName() %></a>
                    <dl class="layui-nav-child">
                    <%for(int j = 0; j < jcdaohangslist.get(i).size(); j++){ %>
                    	<dd><a href="javascript:;" href-url="<%=basePath%>user/<%=jcdaohangslist.get(i).get(j).getJcdaohangNeirong() %>"><i class="layui-icon">&#xe621;</i><%=jcdaohangslist.get(i).get(j).getJcdaohangName() %></a></dd>
                    <%} %>
                    </dl>
                </li>
                <%} %>
            </ul>

        </div>
    </div>
    <!-- body -->
    <div class="layui-body my-body">
        <div class="layui-tab layui-tab-card my-tab" lay-filter="card" lay-allowClose="true">
            <ul class="layui-tab-title">
                <li class="layui-this" lay-id="1"><span><i class="layui-icon">&#xe638;</i>欢迎页</span></li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe id="iframe" src="<%=basePath%>shouye/neiye.jsp" frameborder="0"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- footer -->
    <div class="layui-footer my-footer">
        
    </div>
</div>
<!-- 右键菜单 -->
<div class="my-dblclick-box none">
    <table class="layui-tab dblclick-tab">
        <tr class="card-refresh">
            <td><i class="layui-icon">&#x1002;</i>刷新当前标签</td>
        </tr>
        <tr class="card-close">
            <td><i class="layui-icon">&#x1006;</i>关闭当前标签</td>
        </tr>
        <tr class="card-close-all">
            <td><i class="layui-icon">&#x1006;</i>关闭所有标签</td>
        </tr>
    </table>
</div>
</body>
</html>