<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>广告管理</title>
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
			jp.post("${ctx}/sys/retailAdvertisingInfo/save", $('#inputForm').serialize(),
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
		
		if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}
		
		var validateForm = $("#inputForm").validate({
				rules: {
					advertisingName:{
						required:true
					},
					advertisingId:{
						required:true
					},
					//提交表单后，（第一个）未通过验证的表单获得焦点			
					focusInvalid:true,			
					//当未通过验证的元素获得焦点时，移除错误提示			
					focusCleanup:true

				},
				messages: {
					advertisingName:{
						required:"这是必填字段"
					},
					advertisingId:{
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
	<form:form id="inputForm" modelAttribute="retailAdvertisingInfo"
		class="form-horizontal">
		<form:hidden path="id" />
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">广告名称
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if> ：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="advertisingName" htmlEscape="false" maxlength="50"
								class="form-control" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">广告图片上传：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<sys:fileUpload path="advertisingImage" fileNumLimit="1" fileSizeLimit="50" 
							value="${retailAdvertisingInfo.advertisingImage}" type="image" uploadPath="s/upload/uploadFile" />
						</div>
					</td>				
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">广告图片：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<img style="width: 500px;max-height: 500px;" src="${retailAdvertisingInfo.advertisingImage}"/>
						</div>
					</td>	
					
				</tr>
				
			</tbody>
		</table>
	</form:form>
</body>
</html>