<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="../../jiazai/sousuobaohan.jsp"%>
<script type="text/javascript">
var userId = <%=userId%>;
	
	function addSjqita(sjduochuId){
		var sjqitaName = document.form1.sjqitaName.value;
		if(sjqitaName==""){
			document.form1.sjqitaName.focus();
			alert("请填写回复");
			return false;
		}
		if (userId==0) {
			alert("请登录后回复");
			return false;
		}
		$.post("<%=basePath %>addSjqita?sjqitaType="+userId+"&sjqitaName="+sjqitaName,{sjqitaType1:sjduochuId},function(result){
			if(result.errorMsg){
				alert(result.errorMsg);
			}else{
				location.reload();
				alert("回复成功！");
			}
		},"json");
	}
	
</script>

			<div class="breadcrumb-wrapper">
				<div class="container">
					<div class="row">
						<div class="col-md-3 col-sm-4 bcid-cat">交流<%=newJcpeizhi.getSjduochuBieming()%></div>
						<div class="col-md-9 col-sm-8 location"> &nbsp;<span>当前位置： <a href='<%=basePath %>'>主页</a> > 
						<a href='<%=basePath %>wangzhan/sjduochu/sjduochulist.jsp'>交流<%=newJcpeizhi.getSjduochuBieming()%></a> > </span></div>
					</div>
				</div>
			</div>
			<div class="page-container" id="innerpage-wrap">
				<div class="container">
					<div class="row">
						<div class="main col-md-9 inner-left" role="main">
							<div class="blog-post blog-post-wrap">
								<h3 class="text-center bp-title"><%=sousuoSjduochu.getSjduochuName()%></h3>      
          						<small class="text-center bp-desc">发布人：<%=sousuoSjduochu.getUserName()%>&nbsp;|&nbsp;类型：<%=sousuoSjduochu.getSjxingtaiName()%></small>
									<div class="com-cnt page-content bp-content">
	                                <p style="margin-top:10px; text-indent:2em;"><%=sousuoSjduochu.getSjduochuMark()%></p>
	                                <br /><br />
	                                <p style="margin-top:10px; text-indent:2em;">
									<%if(sousuoSjqitas.size()!=0) {%>
									<%for(int i = 0; i < sousuoSjqitas.size(); i++){ %>
										<%Sjqita newSjqita = sousuoSjqitas.get(i); %>
							        	<p><b>楼层：</b><%=i+1 %>&nbsp;&nbsp;&nbsp;&nbsp;<b>用户：</b><%=newSjqita.getSjqitaPhone() %>&nbsp;&nbsp;<br></p>
							            <p><b>回复：</b><%=newSjqita.getSjqitaName() %><br></p>
							            <br>
							        <%} %>
							        <%} %>
									</p>
	                                <br /><br />
	                                <p style="margin-top:10px; text-indent:2em;">
									<form name="form1" method="post">
							        <p><textarea rows="5" cols="100" name="sjqitaName" id="sjqitaName"></textarea></p>
									<p><a href="javascript:addSjqita(<%=sousuoSjduochu.getSjduochuId()%>)"><input type="button" value="提交回复" /></a></p>
									</form>
									</p>
								</div>
							</div>
						</div>
<%@ include file="left.jsp"%>
					</div>
				</div>
			</div>
			<div class="for-bottom-padding"></div>
<%@ include file="../footer.jsp"%>