<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="../../jiazai/sousuobaohan.jsp"%>

			<div class="breadcrumb-wrapper">
				<div class="container">
					<div class="row">
						<div class="col-md-3 col-sm-4 bcid-cat"><%=newJcpeizhi.getGonggaoBieming() %>信息</div>
						<div class="col-md-9 col-sm-8 location"> &nbsp;<span>当前位置： <a href='<%=basePath %>'>主页</a> > 
						<a href='<%=basePath %>wangzhan/gonggao/gonggaolist.jsp'><%=newJcpeizhi.getGonggaoBieming() %>信息</a> > </span></div>
					</div>
				</div>
			</div>
			<div class="page-container" id="innerpage-wrap">
				<div class="container">
					<div class="row">
						<div class="main col-md-9 inner-left" role="main">
							<div class="blog-post blog-post-wrap">
								<h3 class="text-center bp-title"><%=sousuoGonggao.getGonggaoName()%></h3>
								<small class="text-center bp-desc"> &nbsp;<a href="<%=basePath %>wangzhan/gonggao/gonggaolist.jsp"><%=newJcpeizhi.getGonggaoBieming() %>信息</a>
								 &nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
								  &nbsp;<%=sousuoGonggao.getGgtypeName()%></small>
									<div class="com-cnt page-content bp-content">
									<p>&nbsp;&nbsp;&nbsp;&nbsp;<%=sousuoGonggao.getGonggaoMark()%></p>
								</div>
							</div>
						</div>
<%@ include file="left.jsp"%>
					</div>
				</div>
			</div>
			<div class="for-bottom-padding"></div>
<%@ include file="../footer.jsp"%>