<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<html>
<head>
    <title>广告管理</title>
    <meta name="decorator" content="ani"/>
    <%@include file="/webpage/include/summernote.jsp" %>
    <script type="text/javascript">

        $(document).ready(function () {
            $("#note").summernote({
                height:250,
                minHeight:250,
                maxHeight:250,
                focus:true,
                callbacks:{
                    onImageUpload:function (files,editor,$editable) {
                        console.log("test");
                    }
                }
            })

            $('#createTime').datetimepicker({
                format: "YYYY-MM-DD HH:mm:ss"
            });
            $("input[name='imgUrl']").bind('change input propertychange',function () {
                console.log("test");
                var imgUrl = $("input[name='imgUrl']").val();
                $("#imgPreview").attr("src",imgUrl);
            })
        });

        function save() {
            var isValidate = jp.validateForm('#inputForm');//校验表单
            if (!isValidate) {
                return false;
            } else {
                jp.loading();
                jp.post("${ctx}/sys/retail/advert/save", $('#inputForm').serialize(), function (data) {
                    if (data.success) {
                        jp.getParent().refresh();
                        var dialogIndex = parent.layer.getFrameIndex(window.name); // 获取窗口索引
                        parent.layer.close(dialogIndex);
                        jp.success(data.msg)

                    } else {
                        jp.error(data.msg);
                    }
                })
            }

        }
    </script>
</head>
<body class="bg-white">
<form:form id="inputForm" modelAttribute="retailAdvert" class="form-horizontal">
    <form:hidden path="advertId"/>
    <table class="table table-bordered">
        <tbody>
        <tr>
            <td class="width-15 active"><label class="pull-right">广告名称：</label></td>
            <td class="width-35">
                <form:input path="name" htmlEscape="false" class="form-control "/>
            </td>
        </tr>
        <tr>
            <td class="width-15 active"><label class="pull-right">广告描述：</label></td>
            <td class="width-35">
                <form:textarea path="note" htmlEscape="false" class="form-control summernote"/>
            </td>
        </tr>
        <tr>
            <td class="width-15 active"><label class="pull-right">图片：</label></td>
            <td class="width-35">
                <div class=" input-group">
                    <img id="imgPreview" style="width: 50px;max-height: 50px;" src="${retailAdvert.imgUrl}"/>
                </div>
            </td>
        </tr>
        <tr>
            <td class="width-15 active"><label class="pull-right">图片上传：</label></td>
            <td class="width-35">
                <div class=" input-group">
                    <sys:fileUpload path="imgUrl" fileNumLimit="1" fileSizeLimit="50"
                                    value="${retailAdvert.imgUrl}" type="image" uploadPath="s/upload/uploadFile"/>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
</form:form>
</body>
</html>