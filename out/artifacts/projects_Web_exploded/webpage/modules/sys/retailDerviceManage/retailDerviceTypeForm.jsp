<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>设备类型</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">
		
		function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if(!isValidate){
                return false;
			}else{
                jp.loading();
                jp.post("${ctx}/sys/retailDerviceType/save",$('#inputForm').serialize(),function(data){
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
        
        $(document).ready(function() {
       		$("#connectType").val("${retailDerviceType.connectType}");
       		if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}
        });
	</script>
</head>
<body class="bg-white">
		<form:form id="inputForm" modelAttribute="retailDerviceType" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">设备分类：</label></td>
					<td class="width-35">
					<div class=" input-group" style=" width: 100%;">
					<sys:gridselect 
							url="${ctx}/sys/retailDerviceClassify/data" 
							id="continent1" 
							name="classifyId" 
							value="${retailDerviceType.classifyId}" 
							labelName="retailDerviceType.classifyName" 
							labelValue="${retailDerviceType.classifyName}"
							title="选择分类" 
							cssClass="form-control "
							fieldLabels="类型名称|描述" 
							fieldKeys="classifyName|classifyDescribe" 
							searchLabels="类型名称" 
							searchKeys="classifyName" ></sys:gridselect> 
					</div>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>类型名称：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 100%;">
							  <form:input path="typeName" htmlEscape="false"  class="form-control required stringCheck" style="height: 34px;"/>
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">品牌名称：</label></td>
					<td class="width-35">
					<div class=" input-group" style=" width: 100%;">
						  <form:input path="brandName" htmlEscape="false"  class="form-control required stringCheck" style="height: 34px;"/>
					</div>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>型号：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 100%;">
							  <form:input path="modelName" htmlEscape="false"  class="form-control required stringCheck" style="height: 34px;"/>
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">通型类型：</label></td>
					<td class="width-35">
					<div class=" input-group" style=" width: 100%;">
						  <select name=connectType id="connectType"
								class='form-control required'>
								<option value=''></option>
								<option value='0'>工控机</option>
								<option value='1'>单片机</option>
							</select>
					</div>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>类型描述：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 100%;">
							  <form:input path="typeDescribe" htmlEscape="false"  class="form-control" style="height: 34px;"/>
						</div>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>