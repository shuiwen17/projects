<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<title>商品管理</title>
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
			jp.post("${ctx}/sys/goodsInfo/save", $('#inputForm').serialize(),
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
		$("#discountUse").val("${goodsInfo.discountUse}");
		$("#virtualFlag").val("${goodsInfo.virtualFlag}");
		$("#saleState").val("${goodsInfo.saleState}");
		
		if (${operation=="view"}) {
			$(".form-control").attr("disabled", true);
		}
		
		var validateForm = $("#inputForm").validate({
				rules: {
					goodsName:{
						required:true
					},
					simpleName:{
						required:true
					},
					goodsPrice:{
						required:true,
						validateNum:true
					},
					discountPrice:{
						validateNum:true
					},
					virtualCount:{
						validateInteger:true
					},
					virtualDuration:{
						validateNum:true
					},
					goodsUnit:{
						required:true
					},
					goodsNet:{
						validateNum:true
					},
					caseQuantity:{
						validateInteger:true
					},
					goodsManufactor:{
						required:true
					},
					goodsSn:{
						required:true
					},
					//提交表单后，（第一个）未通过验证的表单获得焦点			
					focusInvalid:true,			
					//当未通过验证的元素获得焦点时，移除错误提示			
					focusCleanup:true

				},
				messages: {
					goodsName:{
						required:"这是必填字段"
					},
					simpleName:{
						required:"这是必填字段"
					},
					goodsPrice:{
						required:"这是必填字段",
						number:"必须输入数字"
					},
					goodsUnit:{
						required:"这是必填字段"
					},
					goodsManufactor:{
						required:"这是必填字段"
					},
					goodsSn:{
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
	<form:form id="inputForm" modelAttribute="goodsInfo"
		class="form-horizontal">
		<form:hidden path="id" />
		<table class="table table-bordered">
			<tbody>
				<tr>
					<td class="width-15 active"><label class="pull-right">商品全称
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if> ：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsName" htmlEscape="false" maxlength="50"
								class="form-control" />
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">商品简称
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if>：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="simpleName" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
				
					<td class="width-15 active"><label class="pull-right">商品类型：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 70%;">
							<sys:gridselect 
							url="${ctx}/sys/goodsType/data" 
							id="typeId" 
							name="typeId" 
							value="${goodsInfo.typeId}" 
							labelName="goodsInfo.typeName" 
							labelValue="${goodsInfo.typeName}"
							title="选择所类型" 
							cssClass="form-control "
							fieldLabels="商品类型ID|商品类型名称" 
							fieldKeys="id|typeName" 
							searchLabels="商品类型名称" 
							searchKeys="typeName" ></sys:gridselect>
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">商品原价
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if>：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsPrice" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">商品优惠价：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="discountPrice" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>	
				<tr>
					<td class="width-15 active"><label class="pull-right">商品图片：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<img style="width: 50px;max-height: 50px;" src="${goodsInfo.goodsImage}"/>
						</div>
					</td>	
					<td class="width-15 active"><label class="pull-right">商品图片上传：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<sys:fileUpload path="goodsImage" fileNumLimit="1" fileSizeLimit="50" 
							value="${goodsInfo.goodsImage}" type="image" uploadPath="s/upload/uploadFile" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">是否为虚拟商品：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 70%;">
							<select name="virtualFlag" id="virtualFlag"
								class='form-control required'>
								<option value='1'>是</option>
								<option value='0'>否</option>
							</select>
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">次数：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="virtualCount" htmlEscape="false"
								class="form-control number" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">时长：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="virtualDuration" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">商品单位
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if>：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsUnit" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">商品品牌：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsBrand" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">商品净含量：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsNet" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">每箱数量：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="caseQuantity" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">厂家
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if>：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsManufactor" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="width-15 active"><label class="pull-right">商品描述：</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsDescribe" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">商品编码
							<c:if test="${operation!='view'}">
								<font color="red">（*）</font>
							</c:if>：
					</label></td>
					<td class="width-35">
						<div class=" input-group">
							<form:input path="goodsSn" htmlEscape="false"
								class="form-control" style="height: 34px;" />
						</div>
					</td>
				</tr>
				<tr>
				<td class="width-15 active"><label class="pull-right">销售状态：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 70%;">
							<select name="saleState" id="saleState"
								class='form-control required'>
								<option value=''></option>
								<option value='1'>销售中</option>
								<option value='0'>下架</option>
							</select>
						</div>
					</td>
					<td class="width-15 active"><label class="pull-right">是否使用优惠价：</label></td>
					<td class="width-35">
						<div class=" input-group" style=" width: 70%;">
							<select name="discountUse" id="discountUse"
								class='form-control required'>
								<option value='1'>是</option>
								<option value='0'>否</option>
							</select>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</form:form>
</body>
</html>