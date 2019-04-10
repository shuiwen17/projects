<%@ page contentType="text/html;charset=UTF-8" %>
<script>
$(document).ready(function () {
    $('#retailAdvertTable').bootstrapTable({

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
        pageNumber: 1,
        //每页的记录行数（*）
        pageSize: 10,
        //可供选择的每页的行数（*）
        pageList: [10, 25, 50, 100],
        //这个接口需要处理bootstrap table传递的固定参数,并返回特定格式的json数据
        url: "${ctx}/sys/retail/advert/data",
        //默认值为 'limit',传给服务端的参数为：limit, offset, search, sort, order Else
        //queryParamsType:'',
        ////查询参数,每次调用是会带上这个参数，可自定义
        queryParams: function (params) {
            var searchParam = $("#searchForm").serializeJSON();
            searchParam.pageNo = params.limit === undefined ? "1" : params.offset / params.limit + 1;
            searchParam.pageSize = params.limit === undefined ? -1 : params.limit;
            searchParam.orderBy = params.sort === undefined ? "" : params.sort + " " + params.order;
            return searchParam;
        },
        //分页方式：client客户端分页，server服务端分页（*）
        sidePagination: "server",
        contextMenuTrigger: "right",//pc端 按右键弹出菜单
        contextMenuTriggerMobile: "press",//手机端 弹出菜单，click：单击， press：长按。
        contextMenu: '#context-menu',
        onContextMenuItem: function (row, $el) {
            if ($el.data("item") == "edit") {
                edit(row.advertId);
            } else if ($el.data("item") == "view") {
                view(row.advertId);
            } else if ($el.data("item") == "delete") {
                jp.confirm('确认要删除该广告信息记录吗？', function () {
                    jp.loading();
                    jp.get("${ctx}/sys/retail/advert/delete?id=" + row.advertId, function (data) {
                        if (data.success) {
                            $('#retailAdvertTable').bootstrapTable('refresh');
                            jp.success(data.msg);
                        } else {
                            jp.error(data.msg);
                        }
                    })

                });

            }
        },

        onClickRow: function (row, $el) {
        },
        onShowSearch: function () {
            $("#search-collapse").slideToggle();
        },
        columns: [{
            checkbox: true

        }, {
            field: 'advertId',
            title: '广告ID',
        }, {
                field: 'name',
                title: '名称',
                sortable: false,
                sortName: 'advert_name'

            }
            , {
                field: 'imgUrl',
                title: '图片',
                sortable: false,
                sortName: 'imgUrl',
                align: 'center',
                formatter: function(value,row,index){
                    return '<img  src='+row.imgUrl+' width="50" height="50">';
                }
            }
            , {
                field: 'createTime',
                title: '创建时间',
                sortable: true,
                sortName: 'advert_create_time'

            }, {
                field: 'status',
                title: '状态',
                sortable: true,
                sortName: 'advert_status',
                formatter: function(value,row,index){
                    if (row.status == "0") {
                        return "待审核";
                    }else if(row.status == "1"){
                        return "上线";
                    }else if(row.status == "2"){
                        return "审核失败";
                    }else{
                        return "下线";
                    }
                }
            }, {
                field: 'createrName',
                title: '创建者',
                sortable: false,
                sortName: 'createrName'
            }
        ]
    });


    if (navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)) {//如果是移动端


        $('#retailAdvertTable').bootstrapTable("toggleView");
    }

    $('#retailAdvertTable').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
        'check-all.bs.table uncheck-all.bs.table', function () {
        $('#remove').prop('disabled', !$('#retailAdvertTable').bootstrapTable('getSelections').length);
        $('#view,#edit').prop('disabled', $('#retailAdvertTable').bootstrapTable('getSelections').length != 1);
    });

    $("#btnImport").click(function () {
        jp.open({
            type: 2,
            area: [500, 200],
            auto: true,
            title: "导入数据",
            content: "${ctx}/tag/importExcel",
            btn: ['下载模板', '确定', '关闭'],
            btn1: function (index, layero) {
                jp.downloadFile('${ctx}/sys/retail/advert/import/template');
            },
            btn2: function (index, layero) {
                var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
                iframeWin.contentWindow.importExcel('${ctx}/sys/retail/advert/import', function (data) {
                    if (data.success) {
                        jp.success(data.msg);
                        refresh();
                    } else {
                        jp.error(data.msg);
                    }
                    jp.close(index);
                });//调用保存事件
                return false;
            },

            btn3: function (index) {
                jp.close(index);
            }
        });
    });


    $("#export").click(function () {//导出Excel文件
        jp.downloadFile('${ctx}/sys/retail/advert/export');
    });
    $("#search").click("click", function () {// 绑定查询按扭
        $('#retailAdvertTable').bootstrapTable('refresh');
    });

    $("#reset").click("click", function () {// 绑定重置按扭
        $("#searchForm  input").val("");
        $("#searchForm  select").val("");
        $("#searchForm  .select-item").html("");
        $('#retailAdvertTable').bootstrapTable('refresh');
    });

});

function getIdSelections() {
    return $.map($("#retailAdvertTable").bootstrapTable('getSelections'), function (row) {
        return row.advertId
    });
}

function deleteAll() {

    jp.confirm('确认要删除该广告信息记录吗？', function () {
        jp.loading();
        jp.get("${ctx}/sys/retail/advert/deleteAll?ids=" + getIdSelections(), function (data) {
            if (data.success) {
                $('#retailAdvertTable').bootstrapTable('refresh');
                jp.success(data.msg);
            } else {
                jp.error(data.msg);
            }
        })

    })
}

//刷新列表
function refresh() {
    $('#retailAdvertTable').bootstrapTable('refresh');
}

function add() {
    jp.openSaveDialog('新增广告', "${ctx}/sys/retail/advert/form", '800px', '500px');
}


function edit(id) {//没有权限时，不显示确定按钮
    if (id == undefined) {
        id = getIdSelections();
    }
    jp.openSaveDialog('编辑广告', "${ctx}/sys/retail/advert/form?id=" + id, '800px', '500px');
}

function view(id) {//没有权限时，不显示确定按钮
    if (id == undefined) {
        id = getIdSelections();
    }
    jp.openViewDialog('查看广告', "${ctx}/sys/retail/advert/form?id=" + id, '800px', '500px');
}

</script>