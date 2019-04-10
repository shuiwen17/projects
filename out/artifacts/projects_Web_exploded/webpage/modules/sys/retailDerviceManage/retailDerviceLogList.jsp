<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title></title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta name="decorator" content="ani" />
<%@ include file="/webpage/include/bootstraptable.jsp"%>
<%@include file="/webpage/include/treeview.jsp"%>
<%@include file="retailDerviceLogList.js"%>
</head>
<body>
	<div class="wrapper wrapper-content">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">设备日志</h3>
			</div>
			
	<!-- 搜索 -->
	<div id="search-collapse" class="collapse">
		<div class="accordion-inner">
			<form:form id="searchForm" modelAttribute="retailDerviceLog" class="form form-horizontal well clearfix">
			 <div class="col-xs-12 col-sm-6 col-md-4">
				<label class="label-item single-overflow pull-left" title="设备编号：">设备编号：</label>
				<form:input path="derviceSn" htmlEscape="false" maxlength="20"  class=" form-control"/>
			</div>
			<div class="col-xs-12 col-sm-6 col-md-4">
				<label class="label-item single-overflow pull-left" title="设备名称：">设备名称：</label>
				<form:input path="derviceName" htmlEscape="false" maxlength="20"  class=" form-control"/>
			</div>
			<div class="col-xs-12 col-sm-6 col-md-4">
				<label class="label-item single-overflow pull-left" title="用户手机号：">用户手机号：</label>
				<form:input path="mobilePhone" htmlEscape="false" maxlength="20"  class=" form-control"/>
			</div>
			 <div class="col-xs-12 col-sm-6 col-md-4">
				 <div class="form-group">
					<label class="label-item single-overflow pull-left" title="createTime：">&nbsp;创建时间(起)：</label>
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
			

			<!-- 表格  -->
			<table id="retailDerviceLogTable" data-toolbar="#toolbar"></table>
			
			<!-- context menu -->
			<ul id="context-menu" class="dropdown-menu">
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceLog:view">
					<li data-item="view"><a>查看</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceLog:edit">
					<li data-item="edit"><a>编辑</a></li>
				</shiro:hasPermission>
				<shiro:hasPermission name="sys:retailDerviceManage:retailDerviceLog:del">
					<li data-item="delete"><a>删除</a></li>
				</shiro:hasPermission>
				<li data-item="action1"><a>取消</a></li>
			</ul>
		</div>
	</div>
	</div>
</body>
</html>