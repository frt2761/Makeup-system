<%@ page language="java" contentType="text/html; charset=utf-8"  import="com.model.*,java.util.List,java.util.ArrayList"
	pageEncoding="utf-8"%>
						<aside class="sidebar col-md-3 inner-right" role="complementary">
							<section class="widget side-news">
								<h3 class="title"><%=newJcpeizhi.getSjduochuBieming() %><%=newJcpeizhi.getSjxingtaiBieming() %></h3>
								<div class="tabbed custom-tabbed">
									<div class="block current">
										<ul class="widget-list">
								        <%if(sjxingtais!=null){ %>
											<%for(int i = 0; i < sjxingtais.size(); i++){ %>
											<li>
												<figure>
													<a href="<%=basePath %>wangzhan/sjduochu/sjduochulist.jsp?sjxingtaiId=<%=sjxingtais.get(i).getSjxingtaiId() %>"><img src="<%=basePath %>wangzhan/skin/images/you.jpg"  style="width:50%;height:50%;"/></a>
												</figure>
												<div class="sn-wrapper">
													<p class="s-desc">
														<a href="<%=basePath %>wangzhan/sjduochu/sjduochulist.jsp?sjxingtaiId=<%=sjxingtais.get(i).getSjxingtaiId() %>" title="<%=sjxingtais.get(i).getSjxingtaiName() %>"><%=sjxingtais.get(i).getSjxingtaiName() %></a>
													</p>
												</div>
											</li>
											<%} %>
										<%} %>
										</ul>
									</div>
								</div>
							</section>
							<section class="widget widget-category side-contact">
								<h3 class="title"><%=newJcpeizhi.getSjduochuBieming() %>搜索</h3>
								<div class="s-contact">
									<form id="form" method="post" name="leftform" action="<%=basePath%>wangzhan/sjduochu/sjduochulist.jsp">
									<input style="width:100px;height:25px;" type="search" placeholder="<%=newJcpeizhi.getSjduochuBieming() %>名称" name="sjduochuName" class="header-search"/>
									<input type="submit" value="搜索"/>
									</form>
								</div>
							</section>
						</aside>