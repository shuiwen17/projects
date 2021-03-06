<%@ page contentType="text/html;charset=UTF-8" %>
    <script>
    $(document).ready(function() {
        $('#advertPushTable').bootstrapTable({

            //请求方法
            method: 'post',
            //类型json
            dataType: "json",
            contentType: "application/x-www-form-urlencoded",
            //显示检索按钮
            showSearch: true,
            //显示刷新按钮
            showRefresh: true,
            //显示切换手机试图按钮
            showToggle: true,
            //显示 内容列下拉框
            showColumns: true,
            //显示到处按钮
            showExport: true,
            //显示切换分页按钮
            showPaginationSwitch: true,
            //最低显示2行
            minimumCountColumns: 2,
            //是否显示行间隔色
            striped: true,
            //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            cache: false,
            //是否显示分页（*）
            pagination: true,
            //排序方式
            sortOrder: "asc",
            //初始化加载第一页，默认第一页
            pageNumber:1,
            //每页的记录行数（*）
            pageSize: 10,
            //可供选择的每页的行数（*）
            pageList: [10, 25, 50, 100],
            //这个接口需要处理bootstrap table传递的固定参数,并返回特定格式的json数据
            url: "${ctx}/marketing/advertPush/data",
            //默认值为 'limit',传给服务端的参数为：limit, offset, search, sort, order Else
            //queryParamsType:'',
            ////查询参数,每次调用是会带上这个参数，可自定义
            queryParams : function(params) {
                var searchParam = $("#searchForm").serializeJSON();
                searchParam.pageNo = params.limit === undefined? "1" :params.offset/params.limit+1;
                searchParam.pageSize = params.limit === undefined? -1 : params.limit;
                searchParam.orderBy = params.sort === undefined? "" : params.sort+ " "+  params.order;
                return searchParam;
            },
            //分页方式：client客户端分页，server服务端分页（*）
            sidePagination: "server",
            contextMenuTrigger:"right",//pc端 按右键弹出菜单
            contextMenuTriggerMobile:"press",//手机端 弹出菜单，click：单击， press：长按。
            contextMenu: '#context-menu',
            onContextMenuItem: function(row, $el){
                if($el.data("item") == "edit"){
                    edit(row.id);
                }else if($el.data("item") == "view"){
                    view(row.id);
                } else if($el.data("item") == "delete"){
                    jp.confirm('确认要删除该商户记录吗？', function(){
                        jp.loading();
                        jp.get("${ctx}/org/retailBusinessInfo/delete?id="+row.id, function(data){
                            if(data.success){
                                $('#retailBusinessInfoTable').bootstrapTable('refresh');
                                jp.success(data.msg);
                            }else{
                                jp.error(data.msg);
                            }
                        })

                    });

                }
            },

            onClickRow: function(row, $el){
            },
            onShowSearch: function () {
                $("#search-collapse").slideToggle();
            },
            columns: [{
                checkbox: true

            }
                ,{
                    field: 'subject',
                    title: '主题',
                    sortable: true,
                    sortName: 'subject'
                    ,formatter:function(value, row , index){
                        value = jp.unescapeHTML(value);
                    <c:choose>
                        <c:when test="${fns:hasPermission('marketing:advertPushList:edit')}">
                        return "<a href='javascript:edit(\""+row.id+"\")'>"+value+"</a>";
                    </c:when>
                        <c:when test="${fns:hasPermission('marketing:advertPushList:view')}">
                        return "<a href='javascript:view(\""+row.id+"\")'>"+value+"</a>";
                    </c:when>
                        <c:otherwise>
                        return value;
                    </c:otherwise>
                        </c:choose>
                    }

                }
                , {
                    field: 'createTime',
                    title: '创建时间',
                    sortable: true,
                    sortName: 'createTime'

                }
//			, {
//                field: 'operate',
//                title: '操作',
//                align: 'center',
//                events: {
//    		        'click .view': function (e, value, row, index) {
//    		        	jp.openViewDialog('查看', '${ctx}/org/retailBusinessInfo/form?id=' + row.id,'800px', '500px');
//    		        },
//    		        'click .edit': function (e, value, row, index) {
//    		        	jp.openSaveDialog('编辑', '${ctx}/org/retailBusinessInfo/form?id=' + row.id,'800px', '500px');
//    		        },
//    		        'click .del': function (e, value, row, index) {
//    		        	del(row.id);
//    		        }
//    		    },
//                formatter:  function operateFormatter(value, row, index) {
//    		        return [
//    		        	<shiro:hasPermission name="org:retailBusinessInfo:view">
//						'<a href="#" class="view" title="查看" ><i class="fa fa-eye"></i> </a>',
//						</shiro:hasPermission>
//						<shiro:hasPermission name="org:retailBusinessInfo:edit">
//						<c:if test="${(role.sysData eq fns:getDictValue('是', 'yes_no', '1') && fns:getUser().admin)||!(role.sysData eq fns:getDictValue('是', 'yes_no', '1'))}">
//							'<a href="#" class="edit" title="修改"><i class="fa fa-edit">修改</i> </a>',
//						</c:if>
//						</shiro:hasPermission>
//						<shiro:hasPermission name="org:retailBusinessInfo:del">
//						    '<a href="#" class="del" title="删除">删除<i class="fa fa-trash"></i> </a>',
//						</shiro:hasPermission>
//    		        ].join('');
//    		    }
//            }
            ]

        });


        if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端


            $('#retailBusinessInfoTable').bootstrapTable("toggleView");
        }

        $('#advertPushTable').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
            'check-all.bs.table uncheck-all.bs.table', function () {
            $('#remove').prop('disabled', ! $('#advertPushTable').bootstrapTable('getSelections').length);
            $('#view,#edit,#alipayconfig,#wechapayconfig').prop('disabled', $('#advertPushTable').bootstrapTable('getSelections').length!=1);
        });



        $("#search").click("click", function() {// 绑定查询按扭
            $('#advertPushTable').bootstrapTable('refresh');
        });

        $("#reset").click("click", function() {// 绑定查询按扭
            $("#searchForm  input").val("");
            $("#searchForm  select").val("");
            $("#searchForm  .select-item").html("");
            $('#advertPushTable').bootstrapTable('refresh');
        });


    });

function getIdSelections() {
    return $.map($("#advertPushTable").bootstrapTable('getSelections'), function (row) {
        return row.id
    });
}

function deleteAll(){

    jp.confirm('确认要删除该商户记录吗？', function(){
        jp.loading();
        jp.get("${ctx}/marketing/advertPush/deleteAll?ids=" + getIdSelections(), function(data){
            if(data.success){
                $('#advertPushTable').bootstrapTable('refresh');
                jp.success(data.msg);
            }else{
                jp.error(data.msg);
            }
        })

    })
}
function del(id){
    jp.confirm('确认要删除该商户记录吗？', function(){
        jp.loading();
        jp.get("${ctx}/marketing/advertPush/deleteAll?ids=" + id, function(data){
            if(data.success){
                $('#advertPushTable').bootstrapTable('refresh');
                jp.success(data.msg);
            }else{
                jp.error(data.msg);
            }
        })

    })
}
//刷新列表
function refresh(){
    $('#advertPushTable').bootstrapTable('refresh');
}

function add(){
    jp.openSaveDialog('新增商户', "${ctx}/org/retailBusinessInfo/form",'800px', '500px');
}


function edit(id){//没有权限时，不显示确定按钮
    if(id == undefined){
        id = getIdSelections();
    }
    jp.openSaveDialog('编辑商户', "${ctx}/org/retailBusinessInfo/form?id=" + id, '800px', '500px');
}

function view(id){//没有权限时，不显示确定按钮
    if(id == undefined){
        id = getIdSelections();
    }
    jp.openViewDialog('查看商户', "${ctx}/org/retailBusinessInfo/form?id=" + id , '800px', '500px');
}


</script>
