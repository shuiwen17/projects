<%@ page contentType="text/html;charset=UTF-8" %>
<script>
$(document).ready(function() {
	$('#retailUserDiscountTable').bootstrapTable({
		 
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
               url: "${ctx}/marketing/retailUserDiscount/data",
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
                        jp.confirm('确认要删除该会员信息记录吗？', function(){
                       	jp.loading();
                       	jp.get("${ctx}/marketing/retailUserDiscount/delete?id="+row.id, function(data){
                   	  		if(data.success){
                   	  			$('#retailUserDiscountTable').bootstrapTable('refresh');
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
            },{
            	
   		    	field: 'userMobile',
   		    	title: '用户手机号',
   		    	sortable: true,
   		    	sortName: 'userMobile'
   		    	,formatter:function(value, row , index){
			        	value = jp.unescapeHTML(value);
					   <c:choose>
						   <c:when test="${fns:hasPermission('marketing:retailUserDiscount:edit')}">
						      return "<a href='javascript:view(\""+row.id+"\")'>"+value+"</a>";
					      </c:when>
						  <c:otherwise>
						      return value;
					      </c:otherwise>
					   </c:choose>
		        	}
		    },
		    {
		        field: 'discountName',
		        title: '红包名称',
		        sortable: true,
		        sortName: 'discountName'
		       
		    }
			,{
		        field: 'discountTypeName',
		        title: '红包类型',
		        sortable: true,
		        sortName: 'discountTypeName'
		       
		    }
			,{
		        field: 'discountFrom',
		        title: '红包来源',
		        sortable: true,
		        sortName: 'discountFrom'
		       
		    }
			,{
		        field: 'createTime',
		        title: '注册时间',
		        sortable: true,
		        sortName: 'createTime'
		       
		    },{
		    	field: 'discountExpiry',
		    	title: '过期时间',
		    	sortable: false,
		    	sortName: 'discountExpiry'

				       
		    },{
		    	field: 'useTime',
		    	title: '使用时间',
		    	sortable: false,
		    	sortName: 'useTime'
		    },{
		    	field: 'useStatusName',
		    	title: '使用状态',
		    	sortable: false,
		    	sortName: 'useStatusName'
				             
		    },{
				field: 'achieveAmount',
				title: '满减卷使用的条件金额',
				sortable: false,
				sortName: 'achieveAmount'
						       
			},{
				field: 'discountRate',
				title: '折扣比率',
				sortable: false,
				sortName: 'discountRate'
		    },{
		    	field: 'discountAmount',
		    	title: '红包金额无门槛红包及满减红包使用金额',
		    	sortable: true,
		    	sortName: 'discountAmount'
		    }
		
		     ]
		
		});
		
		  
	  if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){//如果是移动端

		 
		  $('#retailUserDiscountTable').bootstrapTable("toggleView");
		}
	  
	  $('#retailUserDiscountTable').on('check.bs.table uncheck.bs.table load-success.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
            $('#remove').prop('disabled', ! $('#retailUserDiscountTable').bootstrapTable('getSelections').length);
            $('#view,#edit').prop('disabled', $('#retailUserDiscountTable').bootstrapTable('getSelections').length!=1);
        });
		  
		
		
		
	 $("#export").click(function(){//导出Excel文件
			jp.downloadFile('${ctx}/marketing/retailUserDiscount/export');
	  });

		    
	  $("#search").click("click", function() {// 绑定查询按扭
		  $('#retailUserDiscountTable').bootstrapTable('refresh');
		});
	 
	 $("#reset").click("click", function() {// 绑定查询按扭
		  $("#searchForm  input").val("");
		  $("#searchForm  select").val("");
		  $("#searchForm  .select-item").html("");
		  $('#retailUserDiscountTable').bootstrapTable('refresh');
		});
		
		$('#beginCreateTime').datetimepicker({
			 format: "YYYY-MM-DD HH:mm:ss"
		});
		$('#endCreateTime').datetimepicker({
			 format: "YYYY-MM-DD HH:mm:ss"
		});
		
	});
		
  function getIdSelections() {
        return $.map($("#retailUserDiscountTable").bootstrapTable('getSelections'), function (row) {
            return row.id
        });
    }
  
  function deleteAll(){

		jp.confirm('确认要删除该优惠卷信息记录吗？', function(){
			jp.loading();  	
			jp.get("${ctx}/marketing/retailUserDiscount/deleteAll?ids=" + getIdSelections(), function(data){
         	  		if(data.success){
         	  			$('#retailUserDiscountTable').bootstrapTable('refresh');
         	  			jp.success(data.msg);
         	  		}else{
         	  			jp.error(data.msg);
         	  		}
         	  	})
          	   
		})
  }

    //刷新列表
  function refresh(){
  	$('#retailUserDiscountTable').bootstrapTable('refresh');
  }
  
   function add(){
	  jp.openSaveDialog('新增优惠卷信息', "${ctx}/marketing/retailUserDiscount/form",'800px', '500px');
  }


  
   function edit(id){//没有权限时，不显示确定按钮
       if(id == undefined){
	      id = getIdSelections();
	}
	jp.openSaveDialog('编辑优惠卷信息', "${ctx}/marketing/retailUserDiscount/form?id=" + id, '800px', '500px');
  }
  
 function view(id){//没有权限时，不显示确定按钮
      if(id == undefined){
             id = getIdSelections();
      }
        jp.openViewDialog('查看优惠卷信息', "${ctx}/marketing/retailUserDiscount/form?id=" + id, '800px', '500px');
 }



</script>