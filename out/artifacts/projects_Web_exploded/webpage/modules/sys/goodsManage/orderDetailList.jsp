<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>商品销量排名</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="decorator" content="ani" />
<%@ include file="/webpage/include/bootstraptable.jsp"%>
<%@include file="/webpage/include/treeview.jsp"%>
<%@ include file="/webpage/include/echarts.jsp"%>
<%@include file="orderDetailList.js"%>
</head>
<body>
	<div class="wrapper wrapper-content">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">商品销量排名</h3>
			</div>
		<div class="panel-body">
		<div id="main" style="width: 100%;height: 300px"></div>

		<sys:message content="${message}"/>
		
			<!-- 搜索 -->
			<div id="search-collapse" class="collapse">
				<div class="accordion-inner">
					<form:form id="searchForm" modelAttribute="orderDetail" class="form form-horizontal well clearfix">
			 			
							
			 			<div class="col-xs-12 col-sm-6 col-md-4">
							<label class="label-item single-overflow pull-left" title="商品名称：">商品名称：</label>
							<form:input path="goodsName" htmlEscape="false" maxlength="64"  class=" form-control"/>
						</div>
				
			
			<div class="col-xs-12 col-sm-10 col-md-4">
				<label class="label-item single-overflow pull-left" title="区域名称：">区域：</label>				
				<%-- <sys:gridselect 
							url="${ctx}/org/retailRegionInfo/data" 
							id="continent" 
							name="regionId"
							value="${retailPositionInfo.regionId}" 
							labelName="retailRegionInfo.regionName"
							labelValue="${retailPositionInfo.regionName}"
							title="选择所区域" 						
							cssClass="form-control"						
							fieldLabels="区域名称|所属商户"  
							fieldKeys="regionName|businessName" 
							searchLabels="区域名称" 
							searchKeys="regionName" >
			</sys:gridselect> --%>
				<form:input path="regionName" htmlEscape="false" maxlength="64"  class=" form-control"/>
			</div>
			<div class="col-xs-12 col-sm-5 col-md-4">
					<label class="label-item single-overflow pull-left" title="点位名称：">点位：</label>
					<form:input path="positionName" htmlEscape="false" maxlength="64"  class=" form-control"/>
			</div>
		 	<div class="col-xs-12 col-sm-6 col-md-4">
				 <div class="form-group">
					<label class="label-item single-overflow pull-left" title="pay_time：">&nbsp;日期时间(起)：</label>
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
				<shiro:hasPermission name="sys:goodsManage:orderDetail:add">
					<button id="add" class="btn btn-primary" onclick="add()">
						<i class="glyphicon glyphicon-plus"></i> 新建
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:goodsManage:orderDetail:edit">
					<button id="edit" class="btn btn-success" disabled onclick="edit()">
						<i class="glyphicon glyphicon-edit"></i> 修改
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:goodsManage:orderDetail:del">
					<button id="remove" class="btn btn-danger" disabled
						onclick="deleteAll()">
						<i class="glyphicon glyphicon-remove"></i> 删除
					</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:goodsManage:orderDetail:view">
					<button id="view" class="btn btn-default" disabled onclick="view()">
						<i class="fa fa-search-plus"></i> 查看
					</button>
				</shiro:hasPermission>
			</div>

			<!-- 表格 -->
			<table id="orderDetailTable" data-toolbar="#toolbar"></table>

			<!-- context menu -->
			<ul id="context-menu" class="dropdown-menu">
				<shiro:hasPermission name="sys:goodsManage:orderDetail:view">
					<li data-item="view"><a>查看</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:goodsManage:orderDetail:edit">
					<li data-item="edit"><a>编辑</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:goodsManage:orderDetail:del">
					<li data-item="delete"><a>删除</a></li>
				</shiro:hasPermission>
				<li data-item="action1"><a>取消</a></li>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>