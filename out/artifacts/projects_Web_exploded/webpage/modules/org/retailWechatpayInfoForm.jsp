<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>微信配置信息管理</title>
	<meta name="decorator" content="ani"/>
	<script type="text/javascript">
 
		$(document).ready(function() {

	        $('#contractDate').datetimepicker({
				 format: "YYYY-MM-DD HH:mm:ss"
		    });
		     
		    
		});
		function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if(!isValidate){
                return false;
			}else{
                jp.loading();
                jp.post("${ctx}/org/retailWechatpayInfo/save",$('#inputForm').serialize(),function(data){
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
		<form:form id="inputForm" modelAttribute="retailWechatpayInfo" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="businessId"/>
		
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>微信商户ID：</label></td>
					<td class="width-35">
						<form:input path="mchId" htmlEscape="false" maxlength="50"  minlength="3"   class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>微信应用ID：</label></td>
					<td class="width-35">
						<form:input path="appId" htmlEscape="false"   class="form-control required"/>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>模板ID：</label></td>
					<td class="width-35">
						<form:input path="planId" htmlEscape="false"  class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>私钥：</label></td>
					<td class="width-35">
						<form:input path="privateKey" htmlEscape="false"  class="form-control required "/>
					</td>
				</tr> 
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>微信交易支付密钥：</label></td>
					<td class="width-35">
						<form:input path="apiKey" htmlEscape="false"  class="form-control required"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>证书地址：</label></td>
					<td class="width-35">
						<form:input path="bookAddress" htmlEscape="false" class="form-control required "/>
					</td>
				</tr> 
		 	</tbody>
		</table>
	</form:form>
</body>
</html>