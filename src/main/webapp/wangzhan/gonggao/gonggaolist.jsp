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
							<article class="blog-wrap">
							<%if(sousuoGonggaos!=null){ %>
								<%for(int i = 0; i < sousuoGonggaos.size(); i++){ %>
								<%Gonggao newGonggao = sousuoGonggaos.get(i); %>
								<div class="blog-article hentry format-image">
									<figure>
										<a class="swipebox-x" href="<%=basePath %>wangzhan/gonggao/gonggaoshow.jsp?gonggaoId=<%=newGonggao.getGonggaoId()%>"> <img class="img-responsive" alt="<%=newGonggao.getGonggaoName() %>" src="<%=basePath %><%=newGonggao.getGonggaoImg() %>" /> </a>
									</figure>
									<div class="entry-summary post-summary">
										<header class="entry-header">
											<h2 class="entry-title post-title"> <a href="<%=basePath %>wangzhan/gonggao/gonggaoshow.jsp?gonggaoId=<%=newGonggao.getGonggaoId()%>" title="<%=newGonggao.getGonggaoName() %>"><%=newGonggao.getGonggaoName() %></a> </h2>
										</header>
										<div class="entry-meta post-meta">
											<ul>
												<li>
													<%=newGonggao.getGgtypeName() %>
												</li>
												<li>
													<a href="<%=basePath %>wangzhan/gonggao/gonggaolist.jsp"><%=newJcpeizhi.getGonggaoBieming() %>信息</a>
												</li>
												<li>
													<%=newJcpeizhi.getGgtypeBieming() %>：
													<a href="<%=basePath %>wangzhan/gonggao/gonggaolist.jsp?ggtypeId=<%=newGonggao.getGgtypeId()%>">
													<%=newGonggao.getGgtypeName() %>
													</a>
												</li>
												<li>by&nbsp;&nbsp;admin</li>
											</ul>
										</div>
										<div class="entry-content">
											<p><%=StringUtil.jiequString(newGonggao.getGonggaoMark(), 50) %>...</p>
										</div>
										<a href="<%=basePath %>wangzhan/gonggao/gonggaoshow.jsp?gonggaoId=<%=newGonggao.getGonggaoId()%>">查看详细</a>
									</div>
								</div>
								<%} %>
							<%} %>
							</article>
							<div class="pagination-wrap">
								<div id="pages">
									<div class="page">
										<a href="gonggaolist.jsp?page=1">首页</a>
										<%if(gonggaocurrPage!=1){ %>
			                            <a href="gonggaolist.jsp?page=<%=(gonggaocurrPage-1) %>">上页</a>
			                            <%} %>
			                            <%if(gonggaocurrPage!=gonggaototalPage){ %>
			                            <a href="gonggaolist.jsp?page=<%=(gonggaocurrPage+1) %>">下页</a>
			            				<a class="last" href="gonggaolist.jsp?page=<%=gonggaototalPage %>">尾页</a>
			                            <%} %>
									</div>
								</div>
							</div>
						</div>
<%@ include file="left.jsp"%>
					</div>
				</div>
			</div>
			<div class="for-bottom-padding"></div>
<%@ include file="../footer.jsp"%>