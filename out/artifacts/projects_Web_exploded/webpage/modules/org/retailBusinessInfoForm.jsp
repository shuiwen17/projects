<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>商户管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">

	var codeP="${retailBusinessInfo.provinceId}";
	var codeC="${retailBusinessInfo.cityId}";
	var codeD="${retailBusinessInfo.districtId}";
	
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
                jp.post("${ctx}/org/retailBusinessInfo/save",$('#inputForm').serialize(),function(data){
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
		<form:form id="inputForm" modelAttribute="retailBusinessInfo" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>商户名称：</label></td>
					<td class="width-35">
						<form:input path="businessName" htmlEscape="false" maxlength="20"  minlength="3"   class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>登陆用户名：</label></td>
					<td class="width-35">
						<form:input path="loginUser" htmlEscape="false" maxlength="20"  minlength="6"   class="form-control required isEnglish"/>
					</td>
				</tr>
				<tr>	
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>登陆密码：</label></td>
					<td class="width-35">
						<form:input path="loginPass" htmlEscape="false" maxlength="20"  minlength="6"   class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人名称：</label></td>
					<td class="width-35">
						<form:input path="leadName" htmlEscape="false"    class="form-control required stringCheck"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人电话：</label></td>
					<td class="width-35">
						<form:input path="leadPhone" htmlEscape="false"    class="form-control required isTel"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>负责人邮箱：</label></td>
					<td class="width-35">
						<form:input path="leadEmail" htmlEscape="false"    class="form-control required email"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>省：</label></td>
					<td class="width-35" >
						<c:choose>
							<c:when test="${operation!='view'}">
								<select name='provinceId' id="provinceId" class='form-control required' onchange="findCitysByPid(this.value);">
									<option value=''>请选择</option>
								</select>
							</c:when>
							<c:otherwise>
								<form:input path="provincename" htmlEscape="false" class="form-control" disabled="true" />								
							</c:otherwise>
						</c:choose>
					</td>
					
					
					<td class="width-15 active"><label class="pull-right" ><font color="red">*</font>市：</label></td>
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
					
					<!-- 
					
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>市：</label></td>
					<td class="width-35">
					<div class=" input-group" style=" width: 100%;">
						  <form:input path="cityId" htmlEscape="false"  class="required" data-toggle="city-picker" style="height: 34px;"/>
					</div>
					</td>
					 -->
					
					
				</tr>
				<tr>
				
				
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>区域：</label></td>
					<td class="width-35">
						<c:choose>
							<c:when test="${operation!='view'}">
								<select name='districtId' id="districtId" class='form-control required' >
									<option value='' >请选择</option>
								</select>
							</c:when>
							<c:otherwise>
								<form:input path="districtname" htmlEscape="false" class="form-control" disabled="true"/>								
							</c:otherwise>
						</c:choose>
					</td>
					
					
					
					
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>详细地址：</label></td>
					<td class="width-35">
						<form:input path="businessAddress" htmlEscape="false" maxlength="25"  minlength="2"   class="form-control required stringCheck"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>商户描述：</label></td>
					<td class="width-35">
						<form:input path="businessDescribe" htmlEscape="false"    class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right">合同编号：</label></td>
					<td class="width-35">
						<form:input path="contractNo" htmlEscape="false"    class="form-control"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">合同签订日期：</label></td>
					<td class="width-35">
						<div class='input-group form_datetime' id='contractDate'>
							<input type='text'  name="contractDate" class="form-control "  value="<fmt:formatDate value="${retailBusinessInfo.contractDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</td>
					<td class="width-15 active"></td>
		   			<td class="width-35" ></td>
		  		</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>