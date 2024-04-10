<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="header.jsp"%>
<%@ include file="../jiazai/sousuobaohan.jsp"%>

			<section id="home-section" class="slider1">
				<div class="tp-banner-container">
					<div class="tp-banner">
						<ul>
							<li data-transition="fade" data-slotamount="7" data-masterspeed="500" data-saveperformance="on" data-title="banner1"> <img src="<%=basePath %>file/daohang1.jpg" style="width: 100%;height:200px;" alt="幻灯3" data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat" /> </li>
							<li data-transition="fade" data-slotamount="7" data-masterspeed="500" data-saveperformance="on" data-title="banner1"> <img src="<%=basePath %>file/daohang2.jpg" style="width: 100%;height:200px;" alt="幻灯2" data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat" /> </li>
							<li data-transition="fade" data-slotamount="7" data-masterspeed="500" data-saveperformance="on" data-title="banner1"> <img src="<%=basePath %>file/daohang3.jpg" style="width: 100%;height:200px;" alt="幻灯1" data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat" /> </li>

						</ul>
						<div class="tp-bannertimer"></div>
					</div>
				</div>
			</section>


			<section class="services-section" id="index-cate">
				<div class="container">
					<div class="services-box">
						<div class="row">
						<%if(shujus!=null){ %>
			        		<%for(int i = 0; i < shujus.size(); i++){ %>
			        		<%Shuju newShuju = shujus.get(i); %>
							<div class="col-md-3 col-sm-6 col-xs-6 cate-itme">
								<div class="services-post">
									<a href="<%=basePath %>wangzhan/shuju/shujushow.jsp?shujuId=<%=newShuju.getShujuId()%>" class="thumb-link">
									<img src="<%=basePath %><%=newShuju.getShujuImg() %>" />
									</a>
									<div class="services-content">
										<h2><a href="<%=basePath %>wangzhan/shuju/shujushow.jsp?shujuId=<%=newShuju.getShujuId()%>"><%=newShuju.getShujuName() %></a></h2>
									</div>
								</div>
							</div>
							<%} %>
						<%} %>	
						</div>
					</div>
				</div>
			</section>
			<section class="news-section" id="index-news">
				<div class="container">
					<h3 class="text-center section-title"><a href="<%=basePath %>wangzhan/gonggao/gonggaolist.jsp"><%=newJcpeizhi.getGonggaoBieming() %>信息</a> </h3>
					<div class="news-box owl-wrapper">
						<div class="owl-carousel" data-num="4">
						<%if(gonggaos!=null){ %>
					        <%for(int i = 0; i < gonggaos.size(); i++){ %>
					        <%Gonggao newGonggao = gonggaos.get(i); %>
							<div class="item news-post">
								<div class="news-gallery">
									<a href="<%=basePath %>wangzhan/gonggao/gonggaoshow.jsp?gonggaoId=<%=newGonggao.getGonggaoId()%>" class="thumb-link"><img src="<%=basePath %><%=newGonggao.getGonggaoImg() %>" alt="<%=newGonggao.getGonggaoName() %>" /></a>
								</div>
								<div class="news-content">
									<h2 class="inews-title"><a href="<%=basePath %>wangzhan/gonggao/gonggaoshow.jsp?gonggaoId=<%=newGonggao.getGonggaoId()%>" title="<%=newGonggao.getGonggaoName() %>"><%=newGonggao.getGonggaoName() %></a></h2>
									<p class="desc"><%=StringUtil.jiequString(newGonggao.getGonggaoMark(), 50) %>...</p>
								</div>
							</div>
							<%} %>
						<%} %>	
						</div>
					</div>
				</div>
			</section>
			
			
<%@ include file="footer.jsp"%>