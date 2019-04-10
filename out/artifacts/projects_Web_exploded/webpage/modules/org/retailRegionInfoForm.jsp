<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">
		$(document).ready(function() {

	        $('#contractDate').datetimepicker({
				 format: "YYYY-MM-DD HH:mm:ss"				
		    });
			if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
			}
			//获取商户的businessId数据，拼凑获取区域负责人url数据
		 	$("input[name='businessId']").bind('change input propertychange',function () {
				var businessId = $("input[name='businessId']").val();
				$("#manageUrl").attr("value","?businessId="+businessId);
			});
		});
		function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if(!isValidate){
                return false;
			}else{
                jp.loading();
                jp.post("${ctx}/org/retailRegionInfo/save",$('#inputForm').serialize(),function(data){
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
        function findBusinessInfo(){
			 $.ajax({
			        url : '${ctx}/org/retailBusinessInfo/findBusinessInfo',
			        dataType : 'json',
			        type : 'POST',
			        success : function(data) {
			        	var html ="<option value=''>请选择</option>";
			            $.each(data, function (i, item) {
			            	if(businessId==item.businessId){
				            	html+="<option value='"+item.businessId+"' selected='selected'>"+item.businessName+"</option>";
			            	}else{
			            		html+="<option value='"+item.businessId+"'>"+item.businessName+"</option>";
			            	}
			            });
			            $("#businessId").html(html);
			        },
			        error : function(jqXHR, textStatus, errorThrown) {
			            top.toastr.error("操作失败");
			        }
			    });
		}
		function findManagerByBid(businessId){
			if(businessId !='' && businessId !=null){
				$.ajax({
			        url : '${ctx}/org/retailRegionManager/findManagerByBid',
			        data:{businessId:businessId},
			        dataType : 'json',
			        type : 'POST',
			        success : function(data) {
			        	var html ="<option value=''>请选择</option>";
			            $.each(data, function (i, item) {
			            	if(item.managerId==managerId){
				            	html+="<option value='"+item.managerId+"' selected='selected'>"+item.managerName+"</option>";
			            	}else{
				            	html+="<option value='"+item.managerId+"'>"+item.managerName+"</option>";
			            	}
			            });
			            $("#managerId").html(html);
			        },
			        error : function(jqXHR, textStatus, errorThrown) {
			            top.toastr.error("操作失败");
			        }
			    });
			}else{
				 $("#managerId").html("<option value='' >请选择</option>");
			}
		}

	</script>
</head>
<body class="bg-white">
		<form:form id="inputForm" modelAttribute="retailRegionInfo" class="form-horizontal">
		<form:hidden path="id"/>
			<input id="manageUrl" hidden="true" value="">
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>区域名称：</label></td>
					<td class="width-35">
						<form:input path="regionName" htmlEscape="false" maxlength="20"  minlength="3"   class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right required"><font color="red">*</font>所属商户：</label></td>
					<td class="width-35">
						<sys:gridselect
								url="${ctx}/org/retailBusinessInfo/data"
								id="continent1"
								name="businessId"
								value="${retailRegionInfo.businessId}"
								labelName="retailRegionInfo.businessName"
								labelValue="${retailRegionInfo.businessName}"
								title="选择所商户"
								cssClass="form-control required"
								fieldLabels="商户名称|商户描述"
								fieldKeys="businessName|businessDescribe"
								searchLabels="商户名称"
								searchKeys="businessName"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>区域负责人：</label></td>
					<td class="width-35">
						<sys:gridselect
								url="${ctx}/org/retailRegionManager/data${request.getPrameter('manageUrl')}"
								id="continent"
								name="managerId"
								disabled="${retailRegionInfo.businessName}1disabled"
								value="${retailRegionInfo.managerId}"
								labelName="retailRegionInfo.managerName"
								labelValue="${retailRegionInfo.managerName}"
								title="选择所区域负责人"
								cssClass="form-control required"
								fieldLabels="负责人名称|负责人所属商户"
								fieldKeys="managerName|businessName"
								searchLabels="负责人名称|负责人所属商户"
								searchKeys="managerName|businessName"
						/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>区域描述：</label></td>
					<td class="width-35">
						<form:input path="regionDescribe" htmlEscape="false" maxlength="20"  minlength="1"   class="form-control required "/>
					</td> 
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>