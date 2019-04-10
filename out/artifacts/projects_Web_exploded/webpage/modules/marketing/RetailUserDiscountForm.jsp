<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>优惠券信息管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">

		$(document).ready(function() {

	        $('#createTime').datetimepicker({
				 format: "YYYY-MM-DD HH:mm:ss"
		    });
		});
		function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if(!isValidate){
                return false;
			}else{
                jp.loading();
                jp.post("${ctx}/marketing/retailUserDiscount/save",$('#inputForm').serialize(),function(data){
                    if(data.success){
                        jp.getParent().refresh();
                        var dialogIndex = parent.layer.getFrameIndex(window.name); // 获取窗口索引
                        parent.layer.close(dialogIndex);
                        jp.success(data.msg)

                    }else{
                        jp.error(data.msg);
                    }
                })
			}

        }
	</script>
</head>
<body class="bg-white">
		<form:form id="inputForm" modelAttribute="retailUserDiscount" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>ID：</label></td>
					<td class="width-35">
						<form:input path="id" htmlEscape="false"    class="form-control " disabled="true"/>
					</td>
					<td class="width-15 active"><label class="pull-right">红包名称：</label></td>
					<td class="width-35">
						<form:input path="discountName" htmlEscape="false"    class="form-control " disabled="true"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">用户手机号：</label></td>
					<td class="width-35">
						<form:input path="userMobile" htmlEscape="false"    class="form-control " disabled="true"/>
					</td>
					<td class="width-15 active"><label class="pull-right">红包来源：</label></td>
					<td class="width-35">
						<form:input path="discountFrom" htmlEscape="false"    class="form-control " disabled="true"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">红包类型：</label></td>
					<td class="width-35">
						<form:input path="discountTypeName" htmlEscape="false"    class="form-control " disabled="true"/>
					</td>
					<td class="width-15 active"><label class="pull-right">红包金额无门槛红包及满减红包使用金额：</label></td>
					<td class="width-35">
						<form:input path="discountAmount" htmlEscape="false"    class="form-control required number"  />
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">满减卷使用的条件金额：</label></td>
					<td class="width-35">
						<form:input path="achieveAmount" htmlEscape="false"    class="form-control required number"/>
					</td>
					<td class="width-15 active"><label class="pull-right">折扣比率：</label></td>
					<td class="width-35">
						<form:input path="discountRate" htmlEscape="false"    class="form-control required number"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">红包描述：</label></td>
					<td class="width-35">
						<form:input path="discountDescribe" htmlEscape="false"    class="form-control " disabled="true"/>
					</td>
					<td class="width-15 active"><label class="pull-right">使用状态：</label></td>
					<td class="width-35">
						<form:input path="useStatusName" htmlEscape="false"    class="form-control " disabled="true"/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>