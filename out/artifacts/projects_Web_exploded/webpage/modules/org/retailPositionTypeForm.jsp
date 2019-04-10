<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>点位类型管理</title>
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
                jp.post("${ctx}/org/retailPositionType/save",$('#inputForm').serialize(),function(data){
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
		<form:form id="inputForm" modelAttribute="retailPositionType" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>类型名称：</label></td>
					<td class="width-35">
						<form:input path="typeName" htmlEscape="false" maxlength="20"  minlength="3"   class="form-control required stringCheck"/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>描述：</label></td>
					<td class="width-35">
						<form:input path="typeDescribe" htmlEscape="false" maxlength="20"  minlength="1"   class="form-control required "/>
					</td>
				</tr> 
		 	</tbody>
		</table>
	</form:form>
</body>
</html>