<%@ page contentType="text/html;charset=UTF-8" %>
<script>
$(document).ready(function() {
	$('#orderInfoTable').bootstrapTable({
		 
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
               cache: true,    
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
               url: "${ctx}/sys/orderInfo/data",
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
                        jp.confirm('确认要删除该记录吗？', function(){
                       	jp.loading();
                       	jp.get("${ctx}/test/one/dialog/leave1/delete?id="+row.id, function(data){
                   	  		if(data.success){
                   	  			$('#table').bootstrapTable('refresh');
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
		        field: 'orderSn',
		        title: '订单号',
		        sortable: true,
		        sortName: 'orderSn'
		        ,formatter:function(value, row , index){
			        	value = jp.unescapeHTML(value);
					   <c:choose>
						   <c:when test="${fns:hasPermission('sys:orderInfo:view')}">
						      return "<a href='javascript:view(\""+row.id+"\")'>"+value+"</a>";
					      </c:when>
						  <c:otherwise>
						      return value;
					      </c:otherwise>
					   </c:choose>
		        	}
		    }
			,{
				field: 'businessName',
				title: '商户',
				sortable: true,
				sortName: 'businessName'
					
			}
			,{
				field: 'regionName',
				title: '区域',
				sortable: true,
				sortName: 'regionName'
					
			}
			,{
				field: 'positionName',
				title: '点位',
				sortable: true,
				sortName: 'positionName'
					
			}
			,{
				field: 'derviceName',
				title: '设备',
				sortable: true,
				sortName: 'derviceName'
					
			}
			,{
		        field: 'fromDerviceName',
		        title: '订单来源设备',
		        sortable: true,
		        sortName: 'fromDerviceName'
		       
		    }
			,{
				field: 'mobilePhone',
				title: '用户手机号',
				sortable: true,
				sortName: 'mobilePhone'
					
			}
			,{
				field: 'orderPrice',
				title: '订单价格',
				sortable: true,
				sortName: 'orderPrice'
			}
			,{
				field: 'orderStatusName',
				title: '订单状态',
				sortable: true,
				sortName: 'orderStatusName'
			}
			,{
				field: 'orderTime',
				title: '订单时间',
				sortable: true,
				sortName: 'orderTime'
			}
			,{
				field: 'refundStatusName',
				title: '退款状态',
				sortable: true,
				sortName: 'refundStatusName'
			}
			,{
				field: 'refundTime',
				title: '退款时间',
				sortable: true,
				sortName: 'refundTime'
			}
			,{
				field: 'payTypeName',
				title: '支付类型',
				sortable: true,
				sortName: 'payTypeName'	
			}
			,{
				field: 'payStatusName',
				title: '支付状态',
				sortable: true,
				sortName: 'payStatusName'
			}
			,{
				field: 'payTime',
				title: '支付时间',
				sortable: true,
				sortName: 'payTime'
			}
			,{
				field: 'tradeNo',
				title: '交易流水号',
				sortable: true,
				sortName: 'tradeNo'
			}
			,{
				field: 'discountFlgName',
				title: '红包使用',
				sortable: true,
				sortName: 'discountFlgName'
			}
			,{
				field: 'discountName',
				title: '红包',
				sortable: true,
				sortName: 'discountName'
										
			}
			,{
				field: 'payPrice',
				title: '实际支付金额',
				sortable: true,
				sortName: 'payPrice'
					
			/*}
			,{
				field: 'detailId',
				title: 'id',
				sortable: true,
				sortName: 'detailId'*/
			
		    /*}, {
                field: 'operate',
                title: '操作',
                align: 'center',
                events: {
                	 'click .view': function (e, value, row, index) {
     		        	jp.openViewDialog('查看细则', '${ctx}/sys/orderInfo/form?id=' + row.id,'1200px', '800px');   		        	
     		        },      
    		    },
                formatter:  function operateFormatter(value, row, index) {
    		        return [
    		        	<shiro:hasPermission name="sys:dict:view">
						'<a href="#" class="view" title="查看" ><i class="fa fa-eye"></i> </a>',
						</shiro:hasPermission>
						
    		        ].join('');
    		    }
            
            */}]
		});
		
		  
	  if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端
		  $('#orderInfoTable').bootstrapTable("toggleView");
		}
	  
	  $('#orderInfoTable').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
            $('#remove').prop('disabled', ! $('#orderInfoTable').bootstrapTable('getSelections').length);
            $('#view,#edit').prop('disabled', $('#orderInfoTable').bootstrapTable('getSelections').length!=1);
        });
	  
	  $("#btnImport").click(function(){
			jp.open({
			    type: 2,
              area: [500, 200],
              auto: true,
			    title:"导入数据",
			    content: "${ctx}/tag/importExcel" ,
			    btn: ['下载模板','确定', '关闭'],
				    btn1: function(index, layero){
					  jp.downloadFile('${ctx}/sys/orderInfo/import/template');
				  },
			    btn2: function(index, layero){
				        var iframeWin = layero.find('iframe')[0]; //得到iframe页的窗口对象，执行iframe页的方法：iframeWin.method();
						iframeWin.contentWindow.importExcel('${ctx}/sys/orderInfo/import', function (data) {
							if(data.success){
								jp.success(data.msg);
								refresh();
							}else{
								jp.error(data.msg);
							}
					   		jp.close(index);
						});//调用保存事件
						return false;
				  },
				 
				  btn3: function(index){ 
					  jp.close(index);
	    	       }
			}); 
		});
		
		
	  $("#export").click(function(){//导出Excel文件
			jp.downloadFile('${ctx}/sys/orderInfo/export');
	  	});

	$(document).keydown(function(event){
		if(event.keyCode==13){
			$("#search").click();
		}
	});
	$("#search").click("click", function() {// 绑定查询按扭
		  $('#orderInfoTable').bootstrapTable('refresh');
		});
	 
	 $("#reset").click("click", function() {// 绑定查询按扭
		  $("#searchForm  input").val("");
		  $("#searchForm  select").val("");
		  $("#searchForm  .select-item").html("");
		  $('#orderInfoTable').bootstrapTable('refresh');
		});
		
		$('#beginCreateTime').datetimepicker({
			 format: "YYYY-MM-DD HH:mm:ss"
		});
		$('#endCreateTime').datetimepicker({
			 format: "YYYY-MM-DD HH:mm:ss"
		});
	});
		
  function getIdSelections() {
        return $.map($("#orderInfoTable").bootstrapTable('getSelections'), function (row) {
            return row.id
        });
    }
  
  function deleteAll(){

		jp.confirm('确认要删除该记录吗？', function(){
			jp.loading();  	
			jp.get("${ctx}/sys/orderInfo/delete?ids=" + getIdSelections(), function(data){
         	  		if(data.success){
         	  			$('#orderInfoTable').bootstrapTable('refresh');
         	  			jp.success(data.msg);
         	  		}else{
         	  			jp.error(data.msg);
         	  		}
         	  	})
          	   
		})
  }

    //刷新列表
  function refresh(){
  	$('#orderInfoTable').bootstrapTable('refresh');
  }
  
   function add(){
	  jp.openSaveDialog('新增订单信息', "${ctx}/sys/orderInfo/form",'800px', '500px');
  }


  
   function edit(id){//没有权限时，不显示确定按钮
       if(id == undefined){
	      id = getIdSelections();
	}
	jp.openSaveDialog('编辑订单信息', "${ctx}/sys/orderInfo/form?id=" + id, '800px', '500px');
  }
  
 function view(id){//没有权限时，不显示确定按钮
      if(id == undefined){
             id = getIdSelections();
      }
        jp.openViewDialog('查看订单信息', "${ctx}/sys/orderInfo/form?id=" + id, '800px', '500px');
 }
 $(document).ready(function() {
		var $orderDetailTable =	$('#orderDetailTable').bootstrapTable({
				  //请求方法
					method: 'post',
					//类型json
					dataType: "json",
					contentType: "application/x-www-form-urlencoded",
	                 //是否显示行间隔色
	                striped: true,
	                //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）     
	                cache: false,    
	                //是否显示分页（*）  
	                pagination: false,   
	                //这个接口需要处理bootstrap table传递的固定参数,并返回特定格式的json数据  
	                url: "${ctx}/sys/orderInfo/getOrderDetail",
	                //默认值为 'limit',传给服务端的参数为：limit, offset, search, sort, order Else
	                //queryParamsType:'',   
	                ////查询参数,每次调用是会带上这个参数，可自定义                         
	                queryParams : function(params) {
	                    return {orderSn:$("#orderSn").val()};
	                },
	                //分页方式：client客户端分页，server服务端分页（*）
	                sidePagination: "server",
	                columns: [{
				        field: 'orderSn',
				        title: '订单号'
				    }, {
				    	field: 'goodsName',
				        title: '商品名称'
				    }, {
				    	field: 'goodsPrice',
				        title: '商品价格'
				    },{
				    	field: 'rfidCode',
				        title: 'rfid码'
				       
				     }]
				
				});
			
			  if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端
				  $('#orderDetailTable').bootstrapTable("toggleView");
				}
			  
			  $("#orderDetailButton").click(function(){
					
					jp.openSaveDialog('添加键值', '${ctx}/sys/goodsManage/orderInfoForm?orderSn=' + $("#orderSn").val(),'800px', '500px');
				});
			  
			  });
$('#orderInfoTable').on('load-success.bs.table', function () {
	alert()
})
</script>