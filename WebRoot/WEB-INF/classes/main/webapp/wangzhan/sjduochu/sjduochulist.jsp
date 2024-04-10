<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="../../jiazai/sousuobaohan.jsp"%>

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
							<article class="blog-wrap">
							<%if(sousuoSjduochus!=null){ %>
								<%for(int i = 0; i < sousuoSjduochus.size(); i++){ %>
								<%Sjduochu newSjduochu = sousuoSjduochus.get(i); %>
								<div class="blog-article hentry format-image">
									<figure>
										<a class="swipebox-x" href="<%=basePath %>wangzhan/sjduochu/sjduochushow.jsp?sjduochuId=<%=newSjduochu.getSjduochuId()%>"> <img class="img-responsive" alt="<%=newSjduochu.getSjduochuName() %>" src="<%=basePath %><%=newSjduochu.getSjduochuImg() %>" /> </a>
									</figure>
									<div class="entry-summary post-summary">
										<header class="entry-header">
											<h2 class="entry-title post-title"> <a href="<%=basePath %>wangzhan/sjduochu/sjduochushow.jsp?sjduochuId=<%=newSjduochu.getSjduochuId()%>" title="<%=newSjduochu.getSjduochuName() %>"><%=newSjduochu.getSjduochuName() %></a> </h2>
										</header>
										<div class="entry-meta post-meta">
											<ul>
												<li>
													<%=newSjduochu.getSjxingtaiName()%>
												</li>
												<li>
													<a href="<%=basePath %>wangzhan/sjduochu/sjduochulist.jsp">交流<%=newJcpeizhi.getSjduochuBieming()%></a>
												</li>
												<li>
													<%=newJcpeizhi.getSjxingtaiBieming() %>：
													<a href="<%=basePath %>wangzhan/sjduochu/sjduochulist.jsp?sjxingtaiId=<%=newSjduochu.getSjxingtaiId()%>">
													<%=newSjduochu.getSjxingtaiName() %>
													</a>
												</li>
												<li>by&nbsp;&nbsp;<%=newSjduochu.getUserName() %></li>
											</ul>
										</div>
										<div class="entry-content">
											<p><%=StringUtil.jiequString(newSjduochu.getSjduochuMark(), 50) %>...</p>
										</div>
										<a href="<%=basePath %>wangzhan/sjduochu/sjduochushow.jsp?sjduochuId=<%=newSjduochu.getSjduochuId()%>">查看详细</a>
									</div>
								</div>
								<%} %>
							<%} %>
							</article>
							<div class="pagination-wrap">
								<div id="pages">
									<div class="page">
										<a href="sjduochulist.jsp?page=1">首页</a>
										<%if(sjduochucurrPage!=1){ %>
			                            <a href="sjduochulist.jsp?page=<%=(sjduochucurrPage-1) %>">上页</a>
			                            <%} %>
			                            <%if(sjduochucurrPage!=sjduochutotalPage){ %>
			                            <a href="sjduochulist.jsp?page=<%=(sjduochucurrPage+1) %>">下页</a>
			            				<a class="last" href="sjduochulist.jsp?page=<%=sjduochutotalPage %>">尾页</a>
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