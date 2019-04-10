<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>设备分类</title>
	<meta name="decorator" content="ani"/>

	<script type="text/javascript">
	

		$(document).ready(function() {
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
                jp.post("${ctx}/sys/retailDerviceClassify/save",$('#inputForm').serialize(),function(data){
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
		<form:form id="inputForm" modelAttribute="retailDerviceClassify" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">设备分类：</label></td>
					<td class="width-35">
					<div class=" input-group" style=" width: 100%;">
						  <form:input path="classifyName" htmlEscape="false"  class="form-control required stringCheck" style="height: 34px;"/>
					</div>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>分类描述：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 100%;">
							  <form:input path="classifyDescribe" htmlEscape="false"  class="form-control" style="height: 34px;"/>
						</div>
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>