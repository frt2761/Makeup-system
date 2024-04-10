<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ include file="../jiazai/jcpeizhibaohan.jsp"%>
<%
	Jcpeizhi newJcpeizhi = (Jcpeizhi)session.getAttribute("jcpeizhi");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=newJcpeizhi.getJcpeizhiName()%></title>
<!-- //Meta tags -->
<link rel="stylesheet" href="<%=basePath%>shouye/muban25/css/style.css" type="text/css" media="all" /><!-- Style-CSS -->
<link href="<%=basePath%>shouye/muban25/css/font-awesome.css" rel="stylesheet"><!-- font-awesome-icons -->
</head>

<body>
<section class="w3l-form-36">
	<div class="form-36-mian section-gap">
		<div class="wrapper">
			<div class="form-inner-cont">
				<h3><%=newJcpeizhi.getJcpeizhiName()%></h3>
				<form action="<%=basePath%>login" method="post" class="signin-form">
					<div class="form-input">
						<span class="fa fa-envelope-o" aria-hidden="true"></span> <input type="text" name="userName" id="userName"
							placeholder="Username" required />
					</div>
					<div class="form-input">
						<span class="fa fa-key" aria-hidden="true"></span> <input type="password" name="password" id="password"
							placeholder="Password" required />
					</div>
					<div class="form-input">
						<span class="fa fa-gears" aria-hidden="true"></span>
						<input name="loginType" id="loginType"  type="text" list="listItem" placeholder="请选择角色">
                        <datalist id="listItem">
                            <option>管理员</option>
                            <option><%=newJcpeizhi.getUserBieming()%></option>
                        </datalist>
					</div>
					<div class="login-remember d-grid">
						<label class="check-remaind">
						<a href="<%=basePath%>user/zhuceuser.jsp"><%=newJcpeizhi.getUserBieming()%>注册</a>
						</label>
						<button class="btn theme-button">登录</button>
					</div>
				</form>
				<p class="signup"><font color="red">${error }</font></p>
			</div>

			<!-- copyright -->
			<div class="copy-right">
				<p>Copyright &copy; 202X.<%=newJcpeizhi.getJcpeizhiName()%> All rights reserved.</p>
			</div>
			<!-- //copyright -->
		</div>
	</div>
</section>
</body>

</html>