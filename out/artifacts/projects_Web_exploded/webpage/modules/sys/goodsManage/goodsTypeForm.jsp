<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>商品分类</title>
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
                jp.post("${ctx}/sys/goodsType/save",$('#inputForm').serialize(),function(data){
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
		<form:form id="inputForm" modelAttribute="goodsType" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">商品类别：</label></td>
					<td class="width-35">
					<div class=" input-group" style=" width: 100%;">
						  <form:input path="name" htmlEscape="false"  class="form-control required stringCheck" style="height: 34px;"/>
					</div>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>创建人：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 100%;">
							  <form:input path="createBy.name" htmlEscape="false"  class="form-control required stringCheck" style="height: 34px;"/>
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">父级编号：</label></td>
					<td class="width-35">
					<div class=" input-group" style="width: 100%;">
						<sys:treeselect 
						id="parent" 
						name="parent.id" value="${goodsType.parent.id}" labelName="parent.name" labelValue="${goodsType.parent.name}"
							title="父级编号" url="/sys/goodsType/treeData" extId="${goodsType.id}" cssClass="form-control m-s" allowClear="true"/>
							
							
					</div>
					</td>
					<td class="width-15 active"></td>
					<td class="width-35">
						
					</td>
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>