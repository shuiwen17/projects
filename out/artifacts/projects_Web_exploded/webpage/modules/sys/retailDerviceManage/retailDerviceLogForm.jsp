<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>商品分类</title>
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
			jp.post("${ctx}/sys/retailDerviceLog/save", $('#inputForm').serialize(),
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
		$("#logsType").val("${RetailDerviceLog.logsType}");
		
		if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}
		
		var validateForm = $("#inputForm").validate({
				rules: {
					derviceSn:{
						required:true
					},
					derviceName:{
						required:true
					},
					derviceType:{
						required:true,
						validateNum:true
					},
					userId:{
						validateNum:true
					},
					logsDescription:{
						validateInteger:true
					},
					logsType:{
						validateNum:true
					},
					//提交表单后，（第一个）未通过验证的表单获得焦点			
					focusInvalid:true,			
					//当未通过验证的元素获得焦点时，移除错误提示			
					focusCleanup:true

				},
				messages: {
					derviceSn:{
						required:"这是必填字段"
					},
					derviceName:{
						required:"这是必填字段"
					},
					derviceType:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					userId:{
						required:"这是必填字段"
					},
					logsDescription:{
						required:"这是必填字段"
					},
					logsType:{
						required:"这是必填字段"
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
	<form:form id="inputForm" modelAttribute="retailDerviceLog"
		class="form-horizontal">
		<form:hidden path="id" />
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">设备编号
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if> ：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="derviceSn" htmlEscape="false" maxlength="50"
								class="form-control" />
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">设备名称
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if>：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="derviceName" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
				
					
					<td class="width-15 active"><label class="pull-right">设备类型
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if>：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="derviceType" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">用户Id：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="userId" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
					
					<td class="width-15 active"><label class="pull-right">日志描述：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="logsDescription" htmlEscape="false"
								class="form-control number" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">日志类型：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 70%;">
							<select name="logsType" id="logsType"
								class='form-control required'>
								<option value='4'>本地掌纹识别开门</option>
								<option value='3'>掌纹识别开门</option>
								<option value='2'>掌纹注册开门</option>
								<option value='1'>扫码开门</option>
							</select>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</body>
</html>