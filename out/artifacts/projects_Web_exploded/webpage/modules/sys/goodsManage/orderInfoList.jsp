<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>订单信息管理</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="decorator" content="ani" />
<%@ include file="/webpage/include/bootstraptable.jsp"%>
<%@include file="/webpage/include/treeview.jsp"%>
<%@include file="orderInfoList.js"%>
</head>
<body>
	<div class="wrapper wrapper-content">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">订单信息</h3>
			</div>
			<!-- 搜索 -->
			<div id="search-collapse" class="collapse">
				<div class="accordion-inner">
					<form:form id="searchForm" modelAttribute="orderInfo" class="form form-horizontal well clearfix">
			 			<div class="col-xs-12 col-sm-6 col-md-4">
							<label class="label-item single-overflow pull-left" title="订单号：">订单号：</label>
							<form:input path="orderSn" htmlEscape="false" maxlength="64"  class=" form-control"/>
						</div>
						<div class="col-xs-12 col-sm-6 col-md-4">
							<label class="label-item single-overflow pull-left" title="用户手机号：">用户手机号：</label>
							<form:input path="mobilePhone" htmlEscape="false" maxlength="64"  class=" form-control"/>
						</div>
			<div class="col-xs-12 col-sm-6 col-md-4">
				 <div class="form-group">
					<label class="label-item single-overflow pull-left" title="orderTime">&nbsp;订单时间(起)：</label>
							<div class="col-xs-12">
						   			<div class="col-xs-12 col-sm-5">
					        	  			<div class='input-group date' id='beginCreateTime' style="left: -10px;" >
					                   			<input type='text'  name="beginCreateTime" class="form-control"  />
					                   			<span class="input-group-addon">
					                       			<span class="glyphicon glyphicon-calendar"></span>
					                   			</span>
					             			</div>	
					        		</div>
					        		<div class="col-xs-12 col-sm-1">
					        			~
					       			</div>
					        		<div class="col-xs-12 col-sm-5">
					          			<div class='input-group date' id='endCreateTime' style="left: -10px;" >
					                   		<input type='text'  name="endCreateTime" class="form-control" />
					                   		<span class="input-group-addon">
					                       		<span class="glyphicon glyphicon-calendar"></span>
					                   		</span>
					           			</div>	
					        		</div>
							</div>
				</div>
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
				<%-- <shiro:hasPermission name="sys:orderInfo:add">
					<button id="add" class="btn btn-primary" onclick="add()">
						<i class="glyphicon glyphicon-plus"></i> 新建
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:orderInfo:edit">
					<button id="edit" class="btn btn-success" disabled onclick="edit()">
						<i class="glyphicon glyphicon-edit"></i> 修改
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:orderInfo:del">
					<button id="remove" class="btn btn-danger" disabled
						onclick="deleteAll()">
						<i class="glyphicon glyphicon-remove"></i> 删除
					</button>
				</shiro:hasPermission> --%>
			<shiro:hasPermission name="sys:orderInfo:import">
				<button id="btnImport" class="btn btn-info">
				<i class="fa fa-folder-open-o"></i> 导入</button>
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:orderInfo:export">
	        		<button id="export" class="btn btn-warning">
					<i class="fa fa-file-excel-o"></i> 导出
				</button>
			 </shiro:hasPermission>
				<shiro:hasPermission name="sys:orderInfo:view">
					<button id="view" class="btn btn-default" disabled onclick="view()">
						<i class="fa fa-search-plus"></i> 查看
					</button>
				</shiro:hasPermission>
			</div>

			<!-- 表格 -->
			<table id="orderInfoTable" data-toolbar="#toolbar" data-id-field="id">
			
			</table>

			<!-- context menu -->
			<ul id="context-menu" class="dropdown-menu">
				<shiro:hasPermission name="sys:orderInfo:view">
					<li data-item="view"><a>查看</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:orderInfo:edit">
					<li data-item="edit"><a>编辑</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:orderInfo:del">
					<li data-item="delete"><a>删除</a></li>
				</shiro:hasPermission>
				<li data-item="action1"><a>取消</a></li>
			</ul>
	</div>
	</div>
	</div>
</body>
</html>