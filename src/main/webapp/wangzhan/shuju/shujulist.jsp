<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="../../jiazai/sousuobaohan.jsp"%>

			<div class="breadcrumb-wrapper">
				<div class="container">
					<div class="row">
						<div class="col-md-3 col-sm-4 bcid-cat"><%=newJcpeizhi.getShujuBieming() %>信息</div>
						<div class="col-md-9 col-sm-8 location"> &nbsp;<span>当前位置： <a href='<%=basePath %>'>主页</a> > <a href='<%=basePath %>wangzhan/shuju/shujulist.jsp'><%=newJcpeizhi.getShujuBieming() %>信息</a> > </span></div>
					</div>
				</div>
			</div>
			<div class="page-container" id="innerpage-wrap">
				<div class="container">
					<div class="row">
						<div class="main col-md-9 inner-left" role="main">
							<div class="prolist-wrap">
								<div id="portfolio-container">
									<div class="row portfolio-3-columns isotope-x clearfix">
									<%if(sousuoShujus!=null){ %>
										<%for(int i = 0; i < sousuoShujus.size(); i++){ %>
										<%Shuju newShuju = sousuoShujus.get(i); %>
										<div class="portfolio-item isotope-item col-sm-4 col-xs-6">
											<article>
												<figure class="glass-animation">
													<a class="swipebox" href="<%=basePath %><%=newShuju.getShujuImg() %>"> <span class="background"></span> <span class="glass"><span class="circle"><i class="handle"></i></span></span> <img class="img-responsive" src="<%=basePath %><%=newShuju.getShujuImg() %>" alt="<%=newShuju.getShujuName() %>" /> </a>
												</figure>
												<h5 class="item-title"> <a href="<%=basePath %>wangzhan/shuju/shujushow.jsp?shujuId=<%=newShuju.getShujuId()%>" title="<%=newShuju.getShujuName() %>"><%=newShuju.getShujuName() %></a> </h5>
												<div class="flex separator"> <span class="line"></span> <span class="wrap"><span class="square"></span></span>
												</div>
											</article>
										</div>
										<%} %>
									<%} %>
									</div>
									<div id="pages" class="page">
										<a href="shujulist.jsp?page=1">首页</a>
				                        <%if(shujucurrPage!=1){ %>
				                        <a href="shujulist.jsp?page=<%=(shujucurrPage-1) %>">上页</a>
				                        <%} %>
				                        <%if(shujucurrPage!=shujutotalPage){ %>
				                        <a href="shujulist.jsp?page=<%=(shujucurrPage+1) %>">下页</a>
				        				<a class="last" href="shujulist.jsp?page=<%=shujutotalPage %>">尾页</a>
				                        <%} %>
									</div>
								</div>
							</div>
							<link href="<%=basePath %>wangzhan/skin/css/swipebox.css" rel="stylesheet" media="all" />
							<script src="<%=basePath %>wangzhan/skin/js/jquery.swipebox.js"></script>
							<script type="text/javascript">
								jQuery(document).ready(function($) {
									$(".swipebox").swipebox();
								});
							</script>
						</div>
<%@ include file="left.jsp"%>
					</div>
				</div>
			</div>
			<div class="for-bottom-padding"></div>
<%@ include file="../footer.jsp"%>