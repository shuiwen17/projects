<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>没有权限</title>
	<meta name="decorator" content="ani"/>
</head>
<body class="">
	<div class="login-page">
		<div class="row">
			<div class="col-md-4 col-lg-4 col-md-offset-4 col-lg-offset-4">
				<img class="img-circle" src="https://goodsinfo.oss-cn-hangzhou.aliyuncs.com/20181130/index_logo.png"   class="user-avatar" />
				<%-- "${ctxStatic}/common/images/flat-avatar.png" --%>
				<h1>橘猫新零售</h1>
				<div class="four-container text-center">
					<h4>${fns:getUser().name}，您没有任何权限访问该系统，请联系管理员开通权限!</h4>
				</div>
				
				
				<div class="four-container text-center">
					<h3><a href="${ctx}/logout" style="color:white">安全退出</a></h3>
				</div>
			</div>			
		</div>
	</div>
</body>
</html>