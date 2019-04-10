<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/webpage/include/taglib.jsp" %>
<%@ include file="/webpage/include/bootstraptable.jsp" %>
<%@include file="/webpage/include/treeview.jsp" %>
<html>
<head>
    <title>首页</title>
    <meta name="decorator" content="ani"/>
    <style>
        #body-container {
            margin-left: 0px !important;
            /**padding: 10px;*/
            margin-top: 0px !important;
            overflow-x: hidden !important;
            transition: all 0.2s ease-in-out !important;
            height: 100% !important;
        }
    </style>
    <%@ include file="/webpage/include/echarts.jsp" %>
</head>


<body class="">


<div id="body-container" class="wrapper wrapper-content">
    <div class="conter-wrapper home-container">
        <div class="row home-row">
            <div class="col-md-4 col-lg-6">
                <div class="panel panel-primary">
                    <div class="panel-body">
                        <div id="cbar" style="width: 600px;height: 300px"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 col-lg-6">
                <div class="panel panel-primary">
                    <div class="panel-body">
                        <div id="goodChart" style="width: 600px;height: 300px"></div>
                    </div>
                </div>
            </div>
        </div>


        <div class="row home-row">
            <div class="col-lg-6 col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-body">
                        <div id="pie1" style="width: 600px;height: 300px"></div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-md-6">
                <div class="panel panel-primary">
                    <div class="panel-body">
                        <div id="pie2" style="width: 600px;height: 300px"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $(function () {
        $('#calendar2').fullCalendar({
            eventClick: function (calEvent, jsEvent, view) {
                alert('Event: ' + calEvent.title);
                alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
                alert('View: ' + view.name);
            }
        });

        $('#rtlswitch').click(function () {
            console.log('hello');
            $('body').toggleClass('rtl');

            var hasClass = $('body').hasClass('rtl');

            $.get('/api/set-rtl?rtl=' + (hasClass ? 'rtl' : ''));

        });
        $('.theme-picker').click(function () {
            changeTheme($(this).attr('data-theme'));
        });
        $('#showMenu').click(function () {
            $('body').toggleClass('push-right');
        });

    });

    function changeTheme(the) {
        $("#current-theme").remove();
        $('<link>')
            .appendTo('head')
            .attr('id', 'current-theme')
            .attr({type: 'text/css', rel: 'stylesheet'})
            .attr('href', '/css/app-' + the + '.css');
    }
</script>

<script>
    $(function () {
        setTimeout(function () {
            jp.get("${ctx}/sys/userBar/option", function (option) {
                var myChart = echarts.init(document.getElementById('cbar'))
                myChart.setOption(option);
            })
        }, 275);

        setTimeout(function () {
            jp.get("${ctx}/sys/orderBar/option", function (option) {
                var goodSaleTop5 = echarts.init(document.getElementById('goodChart'))
                goodSaleTop5.setOption(option);
            })
        }, 275);
        setTimeout(function () {
            jp.get("${ctx}/sys/orderDetailPie/option", function (option) {
                var orderSaleAndNumChart = echarts.init(document.getElementById('pie1'))
                orderSaleAndNumChart.setOption(option);
            })
        }, 275);

        setTimeout(function () {
            jp.get("${ctx}/sys/orderMarketPie/option", function (option) {
                var myChart = echarts.init(document.getElementById('pie2'))
                myChart.setOption(option);
            })
        }, 275);
    });
</script>
</body>
</html>