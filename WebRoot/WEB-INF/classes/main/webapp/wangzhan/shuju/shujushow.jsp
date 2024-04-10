<%@ page language="java" contentType="text/html; charset=utf-8" import="com.model.*"
	pageEncoding="utf-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="../../jiazai/sousuobaohan.jsp"%>
<script type="text/javascript">
var userId = <%=userId%>;
	function addSjshaochu(shujuId){
		var sjshaochuZong = document.form1.sjshaochuZong.value;
		if(sjshaochuZong==""){
			document.form1.sjshaochuZong.focus();
			alert("请填写数量");
			return false;
		}
		if (!(/(^[1-9]\d*$)/.test(sjshaochuZong))) {
			document.form1.sjshaochuZong.focus();
			alert("请填写正确数量");
			return false;
		}
		if (userId==0) {
			if(confirm("注册登录网站？")){
				window.location.href="<%=basePath %>shouye/index.jsp";
				return false;
			}else{
				return false;
			}
		}
		$.post("<%=basePath %>addSjshaochu?sjshaochuType=0&userId="+userId+"&sjshaochuZong="+sjshaochuZong,{shujuId:shujuId},function(result){
			if(result.errorMsg){
				alert(result.errorMsg);
			}else{
				alert("加入购物车成功，请到个人中心查看购买！");
				location.reload();
			}
		},"json");
	}
	function addBumen(shujuId){
		if (userId==0) {
			if(confirm("注册登录网站？")){
				window.location.href="<%=basePath %>shouye/index.jsp";
				return false;
			}else{
				return false;
			}
		}
		$.post("<%=basePath %>addBumen?bumenType=0&bumenType1="+userId,{bumenType2:shujuId},function(result){
			if(result.errorMsg){
				alert(result.errorMsg);
			}else{
				alert("加入收藏成功，请到个人中心查看！");
				location.reload();
			}
		},"json");
	}
	
</script>

			<div class="breadcrumb-wrapper">
				<div class="container">
					<div class="row">
						<div class="col-md-3 col-sm-4 bcid-cat"><%=newJcpeizhi.getShujuBieming() %>信息</div>
						<div class="col-md-9 col-sm-8 location"> &nbsp;<span>当前位置： <a href='<%=basePath %>'>主页</a> > 
						<a href='<%=basePath %>wangzhan/shuju/shujulist.jsp'><%=newJcpeizhi.getShujuBieming() %>信息</a> > </span></div>
					</div>
				</div>
			</div>
			<div class="page-container" id="innerpage-wrap">
				<div class="container">
					<div class="row">
						<div class="main col-md-9 inner-left" role="main">
							<div class="blog-post blog-post-wrap">
								<div class="com-cnt page-content bp-content">
									
									<table frame=void  width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
						                <tr>
						                  <td valign="top" width="355">
										  <table frame=void width="100%" border="0" cellspacing="0" cellpadding="2">
						                      <tr>
						                        <td>
						                        <table frame=void cellspacing=0 cellpadding=0 width=355 height=180 border=0>
						                            <tbody>
						                              <tr>
						                                <td align=center>
						                                <%
															if (sousuoShuju.getShujuImg() != null) {
														%> <img src="<%=basePath %><%=sousuoShuju.getShujuImg()%>" height="350" width="350" />
														<%
						 									} else {
														%> <img src="<%=basePath %>wangzhan/images/cuowu.jpg" width="163" height="163" />
														<%
															}
														%>
						                                </td>
						                              </tr>
						                            </tbody>
						                        </table>
						                        </td>
						                      </tr>
						                  </table>
						                  </td>
						                  <td valign="top"><table frame=void width="100%" border="0" cellspacing="0" cellpadding="0">
											<form name="form1" method="post">
						                    <tr>
						                       <td height="30" align="left"><%=newJcpeizhi.getShujuBieming() %>名称：<font color="#cb1c1d" size="3"><strong><%=sousuoShuju.getShujuName()%></strong></font></td>
						                    </tr>
										<tr>
											<td align="left">&nbsp;标签：<%=sousuoShuju.getBuyuanName()%>
											</td>
										</tr>
										<tr>
											<td align="left">&nbsp;数量：<%=sousuoShuju.getShujuZong()%>
											</td>
										</tr>
										<tr>
											<td align="left">&nbsp;产地：<%=sousuoShuju.getShujuMark1()%>
											</td>
										</tr>
										<tr>
											<td align="left">&nbsp;特点：<%=sousuoShuju.getShujuMark2()%>
											</td>
										</tr>
										<tr>
											<td align="left">&nbsp;备注：<%=sousuoShuju.getShujuMark3()%>
											</td>
										</tr>
										<tr>
											<td align="left">&nbsp;价格：￥<%=sousuoShuju.getShujuDouble()%>元
											</td>
										</tr>
										<tr>
											<td align="left">&nbsp;购买：<input style="width:50px;"placeholder="数量" required id="sjshaochuZong" name="sjshaochuZong"/>
											</td>
										</tr>
										<tr>
											<td height="50" align="left">
											<a href="javascript:addSjshaochu(<%=sousuoShuju.getShujuId()%>)">
											<input type="button" class="tbutton" value="加入购物车" />
											</a>
											&nbsp;&nbsp;
											<a href="javascript:addBumen(<%=sousuoShuju.getShujuId()%>)">
											<input type="button" class="tbutton" value="收藏<%=newJcpeizhi.getShujuBieming() %>" />
											</a>
											</td>
										</tr>
										</form>
						                  </table></td>
						                </tr>
						                
						              </table>
						              <table frame=void width="100%"  border="0" cellspacing="0" cellpadding="0" style="padding-top:15px;">
						                <tr>
											<td height="35" class="col-md-3 col-sm-4 bcid-cat">&nbsp;&nbsp;详细介绍</td>
									  	</tr>
						              	<tr>
						              		<td style="border:1px solid #e0e0e0; border-top:0px; padding:10px; line-height:25px;">
						              			<%=sousuoShuju.getShujuMark()%>
						              		</td>
						              	</tr>
						              </table>
						              <table frame=void width="100%"  border="0" cellspacing="0" cellpadding="0" style="padding-top:15px;">
						              	<tr>
											<td height="35" class="col-md-3 col-sm-4 bcid-cat">&nbsp;&nbsp;评价信息</td>
									  	</tr>
						              <%if(sousuoSjpingluns.size()!=0) {%>
										<%for(int i = 0; i < sousuoSjpingluns.size(); i++){ %>
											<%Sjpinglun newSjpinglun = sousuoSjpingluns.get(i); %>
						              	<tr>
						              		<td style="border:1px solid #e0e0e0; border-top:0px; padding:10px; line-height:25px;">
						              			<b>楼层：</b><%=i+1 %>&nbsp;&nbsp;&nbsp;&nbsp;<b>用户：</b><%=newSjpinglun.getUserName() %>&nbsp;&nbsp;<br>
						              			<b>评价：</b><%=newSjpinglun.getSjpinglunName() %><br>
						              		</td>
						              	</tr>
										<%} %>
									  <%} %>
						              </table>
        
									
								</div>
							</div>
						</div>
<%@ include file="left.jsp"%>
					</div>
				</div>
			</div>
			<div class="for-bottom-padding"></div>
<%@ include file="../footer.jsp"%>