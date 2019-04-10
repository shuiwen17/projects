<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>设备分类</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="decorator" content="ani" />
<%@ include file="/webpage/include/bootstraptable.jsp"%>
<%@include file="/webpage/include/treeview.jsp"%>
<%@include file="retailDerviceClassifyList.js"%>
</head>
<body>
	<div class="wrapper wrapper-content">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">设备分类</h3>
			</div>

			<!-- 搜索 -->
			<div id="search-collapse" class="collapse">
				<div class="accordion-inner">
					<form:form id="searchForm" modelAttribute="retailDerviceClassify" class="form form-horizontal well clearfix">
			 			<div class="col-xs-12 col-sm-6 col-md-4">
							<label class="label-item single-overflow pull-left" title="设备分类名：">设备分类名：</label>
							<form:input path="classifyName" htmlEscape="false" maxlength="64"  class=" form-control"/>
						</div>
		 				<div class="col-xs-12 col-sm-6 col-md-4">
							<div style="margin-top:26px">
			  					<a  id="search" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><i class="fa fa-search"></i> 查询</a>
			  					<a  id="reset" class="btn btn-primary btn-rounded  btn-bordered btn-sm" ><i class="fa fa-refresh"></i> 重置</a>
			 				</div>
	    				</div>	
					</form:form>
				</div>
			</div>
			
			<!-- 工具栏 -->
			<div id="toolbar">
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceClassify:add">
					<button id="add" class="btn btn-primary" onclick="add()">
						<i class="glyphicon glyphicon-plus"></i> 新建
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceClassify:edit">
					<button id="edit" class="btn btn-success" disabled onclick="edit()">
						<i class="glyphicon glyphicon-edit"></i> 修改
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceClassify:del">
					<button id="remove" class="btn btn-danger" disabled
						onclick="deleteAll()">
						<i class="glyphicon glyphicon-remove"></i> 删除
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceClassify:view">
					<button id="view" class="btn btn-default" disabled onclick="view()">
						<i class="fa fa-search-plus"></i> 查看
					</button>
				</shiro:hasPermission>
			</div>

			<!-- 表格 -->
			<table id="table" data-toolbar="#toolbar"></table>

			<!-- context menu -->
			<ul id="context-menu" class="dropdown-menu">
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceClassify:view">
					<li data-item="view"><a>查看</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceClassify:edit">
					<li data-item="edit"><a>编辑</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceClassify:del">
					<li data-item="delete"><a>删除</a></li>
				</shiro:hasPermission>
				<li data-item="action1"><a>取消</a></li>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>