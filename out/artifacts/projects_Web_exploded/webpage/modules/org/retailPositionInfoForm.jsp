<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>点位管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">
 
	var codeP="${retailPositionInfo.provinceId}";
	var codeC="${retailPositionInfo.cityId}";
	var codeD="${retailPositionInfo.districtId}";
	
		$(document).ready(function() {

	        $('#contractDate').datetimepicker({
				 format: "YYYY-MM-DD HH:mm:ss"
		    });
		     
		   	findProvinces();
			findCitysByPid(codeP);
			findDistrictsByCid(codeC);
		    
		     
		});
		function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if(!isValidate){
                return false;
			}else{
                jp.loading();
                jp.post("${ctx}/org/retailPositionInfo/save",$('#inputForm').serialize(),function(data){
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
        function findProvinces(){
			 $.ajax({
			        url : '${ctx}/chinaaddress/address/findProvinces',
			        dataType : 'json',
			        type : 'POST',
			        success : function(data) {
			        	var html ="<option value=''>请选择</option>";
			            $.each(data, function (i, item) {
			            	if(codeP==item.codeP){
				            	html+="<option value='"+item.codeP+"' selected='selected'>"+item.provincename+"</option>";
			            	}else{
			            		html+="<option value='"+item.codeP+"'>"+item.provincename+"</option>";
			            	}
			            });
			            $("#provinceId").html(html);
			        },
			        error : function(jqXHR, textStatus, errorThrown) {
			            top.toastr.error("操作失败");
			        }
			    });
		}
		function findCitysByPid(codeP){

			$("#districtId").html("<option value=''>请选择</option>");
			if(codeP !='' && codeP !=null){
				$.ajax({
			        url : '${ctx}/chinaaddress/address/findCitysByPid',
			        data:{codeP:codeP},
			        dataType : 'json',
			        type : 'POST',
			        success : function(data) {
			        	var html ="<option value=''>请选择</option>";
			            $.each(data, function (i, item) {
			            	if(item.codeC==codeC){
				            	html+="<option value='"+item.codeC+"' selected='selected'>"+item.cityname+"</option>";
			            	}else{
				            	html+="<option value='"+item.codeC+"'>"+item.cityname+"</option>";
			            	}
			            });
			            $("#cityId").html(html);
			        },
			        error : function(jqXHR, textStatus, errorThrown) {
			            top.toastr.error("操作失败");
			        }
			    });
			}else{
				 $("#cityId").html("<option value='' >请选择</option>");
			}
		}
		function findDistrictsByCid(codeC){
			if(codeC!='' && codeC !=null){
				$.ajax({
			        url : '${ctx}/chinaaddress/address/findDistrictsByCid',
			        data:{codeC:codeC},
			        dataType : 'json',
			        type : 'POST',
			        success : function(data) {
			        	var html ="<option value=''>请选择</option>";
			            $.each(data, function (i, item) {
			            	if(codeD==item.codeD){
				            	html+="<option value='"+item.codeD+"' selected='selected'>"+item.districtname+"</option>";
			            	}else{
				            	html+="<option value='"+item.codeD+"'>"+item.districtname+"</option>";
			            	}
			            });
			            $("#districtId").html(html);
			        },
			        error : function(jqXHR, textStatus, errorThrown) {
			            top.toastr.error("操作失败");
			        }
			    });
			}else{
				 $("#districtId").html("<option value=''>请选择</option>");
			}
		}
        
	</script>
</head>
<body class="bg-white">
		<form:form id="inputForm" modelAttribute="retailPositionInfo" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>点位名称：</label></td>
					<td class="width-35">
						<form:input path="positionName" htmlEscape="false" maxlength="20"  minlength="3"   class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>点位类型：</label></td>
					<td class="width-35">
						<sys:gridselect 
							url="${ctx}/org/retailPositionType/data" 
							id="continent1" 
							name="typeId" 
							value="${retailPositionInfo.typeId}" 
							labelName="retailPositionInfo.typeName" 
							labelValue="${retailPositionInfo.typeName}"
							title="选择点位类型" 
							cssClass="form-control required"
							fieldLabels="类型名称|描述" 
							fieldKeys="typeName|typeDescribe" 
							searchLabels="类型名称" 
							searchKeys="typeName" ></sys:gridselect>
					</td>
				</tr> 
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>所在区域：</label></td>
					<td class="width-35">
						<sys:gridselect 
							url="${ctx}/org/retailRegionInfo/data" 
							id="continent" 
							name="regionId"
							value="${retailPositionInfo.regionId}" 
							labelName="retailRegionInfo.regionName"
							labelValue="${retailPositionInfo.regionName}"
							title="选择所区域" 
							cssClass="form-control required"
							fieldLabels="区域名称|所属商户"  
							fieldKeys="regionName|businessName" 
							searchLabels="区域名称" 
							searchKeys="regionName" ></sys:gridselect>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>省：</label></td>
					<td class="width-35">
						<c:choose>
							<c:when test="${operation!='view'}">
								<select name='provinceId' id="provinceId" class='form-control required' onchange="findCitysByPid(this.value);">
									<option value=''>请选择</option>
								</select>
							</c:when>
							<c:otherwise>
								<form:input path="provincename" htmlEscape="false" class="form-control" disabled="true"/>								
							</c:otherwise>
						</c:choose>
					</td>
				</tr> 
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>市：</label></td>
					<td class="width-35">
						<c:choose>
							<c:when test="${operation!='view'}">
								<select name='cityId' id="cityId" class='form-control required' onchange="findDistrictsByCid(this.value);">
									<option value=''>请选择</option>
								</select>
							</c:when>
							<c:otherwise>
								<form:input path="cityname" htmlEscape="false" class="form-control" disabled="true"/>								
							</c:otherwise>
							
						</c:choose>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>区：</label></td>
					<td class="width-35">
						<c:choose>
							<c:when test="${operation!='view'}">
								<select name='districtId' id="districtId" class='form-control required'>
									<option value='' >请选择</option>
								</select>
							</c:when>
							<c:otherwise>
								<form:input path="districtname" htmlEscape="false" class="form-control" disabled="true"/>								
							</c:otherwise>
						</c:choose>
					</td>
				</tr> 
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>详细地址：</label></td>
					<td class="width-35">
						<form:input path="address" htmlEscape="false" maxlength="20"  minlength="3"   class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>描述：</label></td>
					<td class="width-35">
						<form:input path="positionDescribe" htmlEscape="false" maxlength="20"  minlength="1"   class="form-control required "/>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>