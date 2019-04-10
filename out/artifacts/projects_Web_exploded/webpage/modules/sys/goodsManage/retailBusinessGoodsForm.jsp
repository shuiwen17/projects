<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
	<title>商户商品管理</title>
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
                jp.post("${ctx}/sys/retailBusinessGoods/save",$('#inputForm').serialize(),function(data){
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
		<form:form id="inputForm" modelAttribute="retailBusinessGoods" class="form-horizontal">
		<form:hidden path="id"/>	
		<table class="table table-bordered">
		   <tbody>
				<tr>
					
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>所属商户：</label></td>
					<td class="width-35">
						<sys:gridselect 
							url="${ctx}/org/retailBusinessInfo/data" 
							id="continent" 
							name="businessId" 
							value="${retailBusinessGoods.businessId}" 
							labelName="retailBusinessGoods.	businessName" 
							labelValue="${retailBusinessGoods.businessName}"
							valueName="businessName"
							valueValue="${retailBusinessGoods.businessName}"
							title="选择所商户" 
							cssClass="form-control "
							fieldLabels="商户名称|商户描述" 
							fieldKeys="businessName|businessDescribe" 
							searchLabels="商户名称" 
							searchKeys="businessName" ></sys:gridselect>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>商品价格：</label></td>
					<td class="width-35">
						<form:input path="goodsPrice" htmlEscape="false" maxlength="11"  minlength="1"   class="form-control required number"/>
					</td>
					
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>选择商品：</label></td>
					<td class="width-35">
						<%-- <sys:gridselect 
							url="${ctx}/sys/goodsInfo/data" 
							id="goodsId" 
							name="goodsId" 
							value="${retailBusinessGoods.goodsId}" 
							labelName="retailBusinessGoods.goodsName" 
							labelValue="${retailBusinessGoods.goodsName}"
							valueName="goodsName"
							valueValue="${retailBusinessGoods.goodsName}"
							title="选择所商品" 
							cssClass="form-control "
							fieldLabels="商品名称|商品类型|商品价格|商品地址			" 
							fieldKeys="goodsName|typeName|goodsPrice|goodsImage" 
							searchLabels="商品名称" 
							searchKeys="goodsName" ></sys:gridselect>
					 --%>
					<sys:zgridselect 
						url="${ctx}/sys/goodsInfo/data" 
						name="goodsId" 
						id="goodsId" 
						value="${retailBusinessGoods.goodsId}" 
						labelValue="${retailBusinessGoods.goodsName}" 
						labelName="retailBusinessGoods.goodsName" 
						searchLabels="商品名称" 
						title="选择所商品" 
						cssClass="form-control "
						valueName="goodsName"
						valueValue="${retailBusinessGoods.goodsName}"
						imageName="goodsImage"
						imageValue="${retailBusinessGoods.goodsImage}"
						fieldLabels="商品名称|商品地址" 
						fieldKeys="goodsName|goodsImage" 
						searchKeys="goodsName"></sys:zgridselect>
					</td> 
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>商品图片上传：</label></td>
					<td class="width-35">
					<%-- <form:input path="goodsImage" htmlEscape="false" maxlength="11"  minlength="1"   class="form-control  "/> --%>
					<%-- <sys:gridselect 
							url="${ctx}/sys/goodsInfo/data" 
							id="goodsIds" 
							name="goodsId" 
							value="${retailBusinessGoods.goodsImage}" 
							labelName="retailBusinessGoods.goodsImage" 
							labelValue="${retailBusinessGoods.goodsImage}"
							valueName="goodsImage"
							valueValue="${retailBusinessGoods.goodsImage}"
							title="选择所商品图片" 
							cssClass="form-control "
							fieldLabels="商品名称|商品类型|商品价格|商品地址			" 
							fieldKeys="goodsName|typeName|goodsPrice|goodsImage" 
							searchLabels="商品名称" 
							searchKeys="goodsImage" ></sys:gridselect> --%>
					
						<sys:fileUpload path="goodsImage" fileNumLimit="1" fileSizeLimit="50" 
							value="${retailBusinessGoods.goodsImage}" type="image" uploadPath="s/upload/uploadFile" />
					</td> 
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>商品描述：</label></td>
					<td class="width-35">
						<form:input path="goodsDescribe" htmlEscape="false" maxlength="11"  minlength="1"   class="form-control required "/>
					</td>
					<td class="width-15 active"><label class="pull-right"><font color="red">*</font>商品图片：</label></td>
					<td class="width-35">
						<img style="width: 50px;max-height: 50px;" src="${retailBusinessGoods.goodsImage}"/>
					</td> 
				</tr>
		 	</tbody>
		</table>
	</form:form>
</body>
</html>