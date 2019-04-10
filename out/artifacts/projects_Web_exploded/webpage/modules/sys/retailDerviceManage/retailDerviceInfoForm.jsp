<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>设备信息</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">

		function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if(!isValidate){
                return false;
			}else{
                jp.loading();
                jp.post("${ctx}/sys/retailDerviceInfo/save",$('#inputForm').serialize(),function(data){
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
       /*  function checkForm(){			
			if(${id} == "" || ${id} == null ){ 
			return false;                  
            }
		} */	
        $(document).ready(function() {
         if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}
        });
	</script>
</head>
<body class="bg-white">
		<form:form id="inputForm" modelAttribute="retailDerviceInfo" class="form-horizontal">
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<form:hidden path="id"/>
					<td class="width-15 active"><label class="pull-right" ><font color="red">*</font>设备编号：</label></td>
					<td class="width-35">
						   <form:input path="derviceSn" htmlEscape="true" class="form-control required stringCheck" disabled="if (checkForm()) {return true;} return false;"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>设备名称：</label></td>
					<td class="width-35">
							<form:input path="derviceName" htmlEscape="false"  class="form-control required stringCheck"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>商户：</label></td>
					<td class="width-35">
						<sys:gridselect 
							url="${ctx}/org/retailBusinessInfo/data" 
							id="businessId" 
							name="businessId" 
							value="${retailDerviceInfo.businessId}" 
							labelName="retailDerviceInfo.businessName" 
							labelValue="${retailDerviceInfo.businessName}"
							title="选择所商户" 
							cssClass="form-control required"
							fieldLabels="商户名称|商户描述" 
							fieldKeys="businessName|businessDescribe" 
							searchLabels="商户名称" 
							searchKeys="businessName" ></sys:gridselect> 
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>设备类型：</label></td>
					<td class="width-35">
						 <sys:gridselect 
							url="${ctx}/sys/retailDerviceType/data" 
							id="typeId" 
							name="typeId" 
							value="${retailDerviceInfo.typeId}" 
							labelName="retailDerviceInfo.typeName" 
							labelValue="${retailDerviceInfo.typeName}"
							title="选择所设备类型" 
							cssClass="form-control required"
							fieldLabels="类型名称|类型描述|分类名称" 
							fieldKeys="typeName|typeDescribe|classifyName" 
							searchLabels="类型名称"
							searchKeys="typeName" ></sys:gridselect>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>区域：</label></td>
					<td class="width-35">
						  <sys:gridselect 
							url="${ctx}/org/retailRegionInfo/data" 
							id="regionId" 
							name="regionId" 
							value="${retailDerviceInfo.regionId}" 
							labelName="retailDerviceInfo.regionName" 
							labelValue="${retailDerviceInfo.regionName}"
							title="选择所区域" 
							cssClass="form-control required"
							fieldLabels="区域名称|区域描述" 
							fieldKeys="regionName|regionDescribe" 
							searchLabels="区域名称" 
							searchKeys="regionName" ></sys:gridselect>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>点位：</label></td>
					<td class="width-35">
						<sys:gridselect 
							url="${ctx}/org/retailPositionInfo/data" 
							id="positionId" 
							name="positionId" 
							value="${retailDerviceInfo.positionId}" 
							labelName="retailDerviceInfo.positionName" 
							labelValue="${retailDerviceInfo.positionName}"
							title="选择所商户" 
							cssClass="form-control required"
							fieldLabels="点位名称|点位描述" 
							fieldKeys="positionName|positionDescribe" 
							searchLabels="点位名称" 
							searchKeys="positionName" ></sys:gridselect>	
					</td>
				</tr>
				<tr>
					
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>纬度：</label></td>
					<td class="width-35">
						   <form:input path="latitude" htmlEscape="false"  class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>经度：</label></td>
					<td class="width-35">
							  <form:input path="longitude" htmlEscape="false"  class="form-control required stringCheck"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>设备状态：</label></td>
					<td class="width-35">
						   <form:select  path="derviceState" class='form-control required'>
						  	<form:option value=''>请选择</form:option>
						  	<form:option value='0'>停用</form:option>
						  	<form:option value='1'>启用</form:option>
				          </form:select>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>设备在线状态：</label></td>
					<td class="width-35">
						<form:select path="derviceOnline" class='form-control required'>
						  	<form:option value=''>请选择</form:option>
						  	<form:option value='0'>不在线</form:option>
						  	<form:option value='1'>在线</form:option>
				          </form:select>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>