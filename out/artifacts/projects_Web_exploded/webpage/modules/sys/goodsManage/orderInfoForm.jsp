<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>订单信息</title>
<meta name="decorator" content="ani" />
<style type="text/css">
</style>
<script type="text/javascript">
	$(document).ready(function() {

	        $('#createTime').datetimepicker({
				 format: "YYYY-MM-DD HH:mm:ss"
		    });
		});
	function save() {
		var isValidate = jp.validateForm('#inputForm');//校验表单
		if (!isValidate) {
			return false;
		} else {
			jp.loading();
			jp.post("${ctx}/sys/orderInfo/save", $('#inputForm').serialize(),
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
		$("#fromDervice").val("${orderInfo.fromDervice}");
		$("#orderStatus").val("${orderInfo.orderStatus}");
		$("#refundStatus").val("${orderInfo.refundStatus}");
		$("#payType").val("${orderInfo.payType}");
		$("#payStatus").val("${orderInfo.payStatus}");
		$("#discountFlg").val("${orderInfo.discountFlg}");
		$("#isSharding").val("${orderInfo.isSharding}");
		if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}
		
		var validateForm = $("#inputForm").validate({
				rules: {
					orderSn:{
						required:true
					},
					businessName:{
						required:true
					},
					positionName:{
						required:true
						},
					derviceName:{
						required:true
						},
					fromDerviceName:{
						required:true
						},
					userName:{
						validateNum:true
					},
					orderPrice:{
						required:true,
						validateNum:true
					},
					orderStatus:{
						required:true,
						validateNum:true
					},
					refundStatus:{
						required:true,
						validateInteger:true
					},
					payType:{
						validateNum:true
					},
					payStatus:{
						validateNum:true
					},
					tradeNo:{
						validateNum:true
					},
					discountFlg:{
						required:true
					},
					discountName:{
						required:true
					},
					payPrice:{
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
					businessName:{
						required:"这是必填字段"
					},
					positionName:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					derviceName:{
						required:"这是必填字段"
					},
					fromDerviceName:{
						required:"这是必填字段"
					},
					userName:{
						required:"这是必填字段"
					},
					orderPrice:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					orderStatus:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					refundStatus:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					payType:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					payStatus:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					tradeNo:{
						number:"必须输入数字"
					},
					discountFlg:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					discountName:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					payPrice:{
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
	<form:form id="inputForm" modelAttribute="orderInfo" action="${ctx}/sys/orderInfo/form"  method="post" class="form-horizontal">
		<form:hidden path="id"/>
		
		
		
		<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
			<tbody>
				<tr>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>订单号：</label>
					</td>					
					<td class="width-35">
						<form:input path="orderSn" htmlEscape="false" class="form-control" disabled="true" />
					</td>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>交易号：</label>
					</td>				
					<td class="width-35">
						<form:input path="tradeNo" htmlEscape="false" class="form-control" disabled="true" />
					</td>
				</tr>

				<tr>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>设备编号：</label>
					</td>					
					<td class="width-35">
						<form:input path="derviceSn" htmlEscape="false" class="form-control" disabled="true" />
					</td>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>商户：</label>
					</td>							
					<td class="width-35">
						<form:input path="businessName" htmlEscape="false" class="form-control" disabled="true" />
					</td>
				</tr>

				<tr>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>区域：</label>
					</td>					
					<td class="width-35">
						<form:input path="regionName" htmlEscape="false" class="form-control" disabled="true" />
					</td>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>点位：</label>
					</td>							
					<td class="width-35">
						<form:input path="positionName" htmlEscape="false" class="form-control" disabled="true" />
					</td>
				</tr>				

				<tr>		
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>订单原价：</label>
					</td>							
					<td class="width-35">
						<form:input path="orderPrice" htmlEscape="false" class="form-control" disabled="true" />
					</td>
					<td class="width-15 active">
						<label class="pull-right"><font color="red">*</font>实际支付价：</label>
					</td>							
					<td class="width-35">
						<form:input path="payPrice" htmlEscape="false" class="form-control" disabled="true" />
					</td>
				</tr>	
			</tbody>
		</table>
		
		<table  class="table table-bordered  table-condensed dataTables-example dataTable no-footer" >
			<tbody>
				<tr align="center" style="background-color:#f5f5f5">
					<td colspan="6"><h2>订单商品详情</h2></td>
				</tr>
				<tr align="center" style="background-color:#f5f5f5">
					<td>ID</td>
					<td>商品名称</td>
					<td>商品图片</td>
					<td>单价</td>
					<td>RFID码</td>
					<!--
					<th style="color:#0663A2;">操作</th>
					-->
				</tr>
				<c:forEach items="${orderInfo.detailList}" var="detail" varStatus="status">
									
					<tr align="center" style="background-color:#f5f5f5">
						<td>${detail.detailId}</td>
						<td>${detail.goodsName}</td>
						<td><img style="width: 50px;max-height: 50px;" src="${detail.goodsImage}"/></td>
						<td>${detail.goodsPrice}</td>
						<td>${detail.rfidCode}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		

		   
		   
	</form:form>
</body>
</html>