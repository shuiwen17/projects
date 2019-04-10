<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>商品销量排名</title>
<meta name="decorator" content="ani" />
<style type="text/css">
</style>
<script type="text/javascript">
	function save() {
		var isValidate = jp.validateForm('#inputForm');//校验表单
		if (!isValidate) {
			return false;
		} else {
			jp.loading();
			jp.post("${ctx}/sys/orderDetail/save", $('#inputForm').serialize(),
					function(data) {
						if (data.success) {
							jp.getParent().refresh();
							var dialogIndex = parent.layer
									.getFrameIndex(window.name); // 获取窗口索引
							parent.layer.close(dialogIndex);
							jp.success(data.msg)

						} else {
							jp.error(data.msg);
						}
					})
		}

	}
	
	function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		alert(111);
	}

	$(document).ready(function() {
		$("#orderSn").val("${orderDetail.orderSn}");
		if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}
		
		var validateForm = $("#inputForm").validate({
				rules: {
					orderSn:{
						required:true
					},
					goodsName:{
						required:true
					},
					goodsPrice:{
						required:true
						},
					rfidCode:{
						required:true
						},
					goodsSn:{
						required:true
						},
					goodsImage:{
						validateNum:true
					},
					rfidId:{
						required:true,
						validateNum:true
					},
					rfidCode:{
						required:true,
						validateNum:true
					},
					createTime:{
						required:true,
						validateInteger:true
					},
					//提交表单后，（第一个）未通过验证的表单获得焦点			
					focusInvalid:true,			
					//当未通过验证的元素获得焦点时，移除错误提示			
					focusCleanup:true

				},
				messages: {
					orderSn:{
						required:"这是必填字段"
					},
					goodsName:{
						required:"这是必填字段"
					},
					goodsPrice:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					rfidCode:{
						required:"这是必填字段"
					},
					goodsSn:{
						required:"这是必填字段"
					},
					goodsImage:{
						required:"这是必填字段"
					},
					rfidId:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					rfidCode:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					createTime:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			}); 
			
			$.validator.addMethod("validateNum",function(value,element,params){
				var validateNum = /^(?!(0[0-9]{0,}$))[0-9]{1,}[.]{0,}[0-9]{0,}$/;
				return this.optional(element)||(validateNum.test(value));
				},"*请输入正确的数字！");
				 
			$.validator.addMethod("validateInteger",function(value,element,params){
				var validateInteger = /^([1-9]\d*|[0]{1,1})$/;
				return this.optional(element)||(validateInteger.test(value));
				},"*请输入正确的数字！"); 

		$('#virtualFlag').change(function() {
			//alert($('#virtualFlag').val());
		});
	});
</script>
</head>
<body class="bg-white">
	<form:form id="inputForm" modelAttribute="orderDetail" action="${ctx}/sys/orderDetail/form"  method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
		   <tbody>
		       <tr>
		         <td  class="width-15 active"><label class="pull-right"><font color="red">*</font>订单号:</label></td>
		         <td class="width-35" ><form:input path="orderSn" htmlEscape="false" maxlength="50" class="form-control required abc"/></td>
		      </tr>
		      <tr>
		      <td class="width-15 active"><label class="pull-right"><font color="red">*</font>选择商品：</label></td>
					<td class="width-35">
						<sys:gridselect 
							url="${ctx}/sys/orderDetail/data" 
							id="orderSn" 
							name="orderSn" 
							value="${OrderInfo.orderSn}" 
							labelName="retailOrderInfo.goodsName" 
							labelValue="${retailOrderInfo.goodsName}"
							valueName="goodsName"
							valueValue="${retailOrderInfo.goodsName}"
							title="选择所商品" 
							cssClass="form-control "
							fieldLabels="商品名称|订单号|商品价格			" 
							fieldKeys="goodsName|orderSn|goodsPrice" 
							searchLabels="商品名称" 
							searchKeys="goodsName" ></sys:gridselect>
					</td>
				</tr>
					
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
							fieldLabels="商品名称|商品类型|商品价格			" 
							fieldKeys="goodsName|typeName|goodsPrice" 
							searchLabels="商品名称" 
							searchKeys="goodsName" >
							</sys:gridselect> --%>
				
		       <tr>
		          <td  class="width-15 active">	<label class="pull-right"><font color="red">*</font>商品名:</label></td>
		          <td  class="width-35" ><form:input path="goodsName" htmlEscape="false" maxlength="50" class="form-control required"/></td>
		      </tr>
		       <tr>
		          <td  class="width-15 active">	<label class="pull-right"><font color="red">*</font>商品价格:</label></td>
		          <td  class="width-35" ><form:input path="goodsPrice" htmlEscape="false" maxlength="50" class="form-control required"/></td>
		      </tr>
		      <tr>
		          <td  class="width-15 active">	<label class="pull-right"><font color="red">*</font>rfid码:</label></td>
		          <td  class="width-35" ><form:input path="rfidCode" htmlEscape="false" maxlength="50" class="form-control required"/></td>
		      </tr>
		   </tbody>
		   </table>   
	</form:form>
</body>
</html>