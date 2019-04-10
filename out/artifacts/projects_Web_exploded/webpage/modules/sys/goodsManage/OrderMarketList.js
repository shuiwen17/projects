<%@ page contentType="text/html;charset=UTF-8" %>
<script>
//基于准备好的dom，初始化echarts实例4
var myChart;

function refreshCharts(){
 jp.get("${ctx}/sys/orderMarket/option", function (option) {
     // 指定图表的配置项和数据
     // 使用刚指定的配置项和数据显示图表。
     myChart.setOption(option);
 })
 $('#orderMarketTable').bootstrapTable('refresh');
}


$(document).ready(function() {
	
	myChart = echarts.init(document.getElementById('main'));
    window.onresize = myChart.resize;
	$('#orderMarketTable').bootstrapTable({
		 
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
               url: "${ctx}/sys/orderMarket/data",
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
                        jp.confirm('确认要删除该请假表单记录吗？', function(){
                       	jp.loading();
                       	jp.get("${ctx}/test/one/dialog/leave1/delete?id="+row.id, function(data){
                   	  		if(data.success){
                   	  			$('#orderDetailTable').bootstrapTable('refresh');
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
				field: 'goodsName',
				title: '商品名称',
				sortable: true,
				sortName: 'goodsName'
			 }
			,{
				field: 'salesPrice',
				title: '销售额',
				sortable: true,
				sortName: 'salesPrice'		
			}
			,{
				field: 'sales',
				title: '销量',
				sortable: true,
				sortName: 'sales'
		    }]
		});
		
	jp.get("${ctx}/sys/orderMarket/option", function (option) {
	        // 指定图表的配置项和数据
	        // 使用刚指定的配置项和数据显示图表。
	        myChart.setOption(option);
	    })
	  if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端
		  $('#orderMarketTable').bootstrapTable("toggleView");
		}
	  
	  $('#orderMarketTable').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
            $('#remove').prop('disabled', ! $('#orderMarketTable').bootstrapTable('getSelections').length);
            $('#view,#edit').prop('disabled', $('#orderMarketTable').bootstrapTable('getSelections').length!=1);
        });
		  
	  $("#search").click("click", function() {// 绑定查询按扭
		  $('#orderMarketTable').bootstrapTable('refresh');
		});
	 
	 $("#reset").click("click", function() {// 绑定查询按扭
		  $("#searchForm  input").val("");
		  $("#searchForm  select").val("");
		  $("#searchForm  .select-item").html("");
		  $('#orderMarketTable').bootstrapTable('refresh');
		});
		
		$('#beginCreateTime').datetimepicker({
			 format: "YYYY-MM-DD HH:mm:ss"
		});
		$('#endCreateTime').datetimepicker({
			 format: "YYYY-MM-DD HH:mm:ss"
		});
	});
		
  function getIdSelections() {
        return $.map($("#orderMarketTable").bootstrapTable('getSelections'), function (row) {
            return row.id
        });
    }
  
  function deleteAll(){

		jp.confirm('确认要删除该记录吗？', function(){
			jp.loading();  	
			jp.get("${ctx}/sys/orderMarket/delete?ids=" + getIdSelections(), function(data){
         	  		if(data.success){
         	  			$('#orderMarketTable').bootstrapTable('refresh');
         	  			jp.success(data.msg);
         	  		}else{
         	  			jp.error(data.msg);
         	  		}
         	  	})
          	   
		})
  }

    //刷新列表
  function refresh(){
  	$('#orderMarketTable').bootstrapTable('refresh');
  }
  
   function add(){
	  jp.openSaveDialog('新增商品', "${ctx}/sys/orderMarket/form",'900px', '600px');
  }


  
   function edit(id){//没有权限时，不显示确定按钮
       if(id == undefined){
	      id = getIdSelections();
	}
	jp.openSaveDialog('编辑商品类别', "${ctx}/sys/orderMarket/form?id=" + id, '900px', '600px');
  }
  
 function view(id){//没有权限时，不显示确定按钮
      if(id == undefined){
             id = getIdSelections();
      }
        jp.openViewDialog('查看商品类别', "${ctx}/sys/orderMarket/viewForm?id=" + id + "&operation=view", '900px', '600px');
 }

</script>