<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
			<footer id="footer-sec">
				<div class="container">
					<div class="footer-widgets">
						<div class="row">
							<div class="col-md-3 col-sm-12 foot-about">
								<div class="widgets">
									<h2 class="dark-title"><a href="javascript:;">关于我们</a> </h2>
									<div class="f-about"> <%=StringUtil.jiequString(sjxiaoxi.getSjxiaoxiMark(), 50) %>... </div>
								</div>
							</div>
							<div class="col-md-3 col-sm-6 hidden-sm hidden-xs foot-nav">
								<div class="widgets">
									<h2>快捷链接</h2>
									<ul class="tag-list">
									<%if(sjlianjies!=null){ %>
				                 	<%for(int i = 0; i < sjlianjies.size(); i++){ %>
							        	<%Sjlianjie newSjlianjie = sjlianjies.get(i); %>
										<li>
											<a href="<%=newSjlianjie.getSjlianjieMark() %>" target="_blank"><%=newSjlianjie.getSjlianjieName() %></a>
										</li>
										<%} %>
									<%} %>
									</ul>
								</div>
							</div>
							<div class="col-md-3 col-sm-6 hidden-sm hidden-xs foot-contact">
								<div class="widgets">
									<h2 class="dark-title"><a href="javascript:;">联系我们</a> </h2>
									<div class="f-contact">
										<p>地址：XX省XX市XXXXX </p>
										<p>电话：400-000-000</p>
										<p>邮箱：12345@qq.com</p>
									</div>
								</div>
							</div>
							<div class="col-md-3 col-sm-6 hidden-sm hidden-xs foot-qrcode">
								<div class="widgets info-widget">
									<h2><%=newJcpeizhi.getJcpeizhiName()%></h2>
									<p>Copyright 2017-202X XXXX市XXXXXXX  All Rights Reserved</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</footer>
		</div>
		<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/jquery.migrate.js"></script>
		<!--<script type="text/javascript" src="skin/js/jquery.bxslider.min.js"></script>-->
		<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/jquery.imagesloaded.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/retina-1.1.0.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/jquery.themepunch.tools.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/jquery.themepunch.revolution.min.js"></script>
		<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/script.js"></script>
		<link type="text/css" rel="stylesheet" href="<%=basePath %>wangzhan/skin/css/jquery.mmenu.all.css" />
		<script type="text/javascript" src="<%=basePath %>wangzhan/skin/js/jquery.mmenu.all.min.js"></script>
		<script type="text/javascript">
			jQuery(document).ready(function($) {
				var mmenu = $('nav#mmenu').mmenu({
					slidingSubmenus: true,
					classes: 'mm-white', //mm-fullscreen mm-light
					extensions: ["theme-white"],
					offCanvas: {
						position: "right", //left, top, right, bottom
						zposition: "front" //back, front,next
						//modal		: true
					},
					searchfield: false,
					counters: false,
					//navbars		: {
					//content : [ "prev", "title", "next" ]
					//},
					navbar: {
						title: "网站导航"
					},
					header: {
						add: true,
						update: true,
						title: "网站导航"
					}
				});
				$(".closemenu").click(function() {
					var mmenuAPI = $("#mmenu").data("mmenu");
					mmenuAPI.close();
				});
			});
		</script>
	</body>

</html>