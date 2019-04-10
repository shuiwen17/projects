<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>区域负责人管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">
 
		$(document).ready(function() {

	        $('#contractDate').datetimepicker({
				 format: "YYYY-MM-DD HH:mm:ss"
		    });
		     
		  if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}   
		});
		function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if(!isValidate){
                return false;
			}else{
                jp.loading();
                jp.post("${ctx}/org/retailRegionManager/save",$('#inputForm').serialize(),function(data){
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
		<form:form id="inputForm" modelAttribute="retailRegionManager" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人名称：</label></td>
					<td class="width-35">
						<form:input path="managerName" htmlEscape="false" maxlength="20"  minlength="2"   class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>所属商户：</label></td>
					<td class="width-35">
						<sys:gridselect 
							url="${ctx}/org/retailBusinessInfo/data" 
							id="continent" 
							name="businessId" 
							value="${retailRegionManager.businessId}" 
							labelName="retailRegionManager.businessName" 
							labelValue="${retailRegionManager.businessName}"
							title="选择所商户" 
							cssClass="form-control required"
							fieldLabels="商户名称|商户描述" 
							fieldKeys="businessName|businessDescribe" 
							searchLabels="商户名称" 
							searchKeys="businessName" ></sys:gridselect>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人电话：</label></td>
					<td class="width-35">
						<form:input path="managerTel" htmlEscape="false" maxlength="11"  minlength="11"   class="form-control required isTel"/>
					</td> 
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人邮箱：</label></td>
					<td class="width-35">
						<form:input path="managerEmail" htmlEscape="false" maxlength="20"  minlength="6"   class="form-control required email"/>
					</td> 
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人用户名：</label></td>
					<td class="width-35">
						<form:input path="loginUser" htmlEscape="false" maxlength="11"  minlength="1"   class="form-control required stringCheck"/>
					</td> 
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人密码：</label></td>
					<td class="width-35">
						<form:input path="loginPass" htmlEscape="false" maxlength="20"  minlength="6"   class="form-control required stringCheck"/>
					</td> 
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>