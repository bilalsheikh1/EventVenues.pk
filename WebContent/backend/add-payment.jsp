<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="sun.security.jca.GetInstance"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.easybooking.model.Payment"%>
<%@page import="com.easybooking.daoImp.PaymentDaoImp"%>
<%@page import="com.easybooking.dao.PaymentDao"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@page import="com.easybooking.daoImp.FoodServicesDaoImp"%>
<%@page import="com.easybooking.dao.FoodServicesDao"%>
<%@page import="com.easybooking.model.FoodServices"%>
<%@page import="com.easybooking.daoImp.CityDaoImp"%>
<%@page import="com.easybooking.dao.CityDao"%>
<%@page import="com.easybooking.model.City"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% if(session.getAttribute("admin")==null){ response.sendRedirect("index.jsp");}%> 
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>EasyBooking</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.7 -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/bootstrap/dist/css/bootstrap.min.css">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/font-awesome/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/Ionicons/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../frontend/assets/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloadin../frontend/g all of them to reduce the load. -->
  <link rel="stylesheet" href="../frontend/assets/dist/css/skins/_all-skins.min.css">
  <!-- Morris chart -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/morris.js/morris.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/jvectormap/jquery-jvectormap.css">
  <!-- Date Picker -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/bootstrap-daterangepicker/daterangepicker.css">
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="../frontend/assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
<link rel="stylesheet" href="../frontend/assets/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

  var btn_action = "Add Service";
    $(document).ready(function(){
          $('#submit').val(btn_action);
          $('#Action').val(btn_action);
      })
    function submitFormData(){
        $.ajax({
          url : '../FoodServicesServlet' ,
          data : $("#formID").serialize(),
          type : 'post',
          success : function(data){
              $("#formID")[0].reset();
              $('#getrecord').html(data);
              $('#submit').val("Add Service");
            },
            error : function (msg){
                alert('error in add');
              }
            
            })
      return false;
        
     }      

     function deleterecord(id)
      {
        var r = confirm ("Are You Sure to Delete User");
         if(r == true){
          //var id = e.target.value;
            $.ajax({
              url : '../FoodServicesServlet' ,
              data : "method=delete&id="+id,
              type : 'post',
              success : function(data){
                 $("#getrecord").html(data);  
                },
                error : function (msg){
                  alert('error in delete');
                }
          })        
         }
      }
      var updateId ;
     function getData(id)
      {
        btn_action = "Update Service";
        $.ajax({
            url : '../FoodServicesServlet' ,
            data : "method=getData&id="+id,
            type : 'post',
            success : function(data){
              var obj = JSON.parse(data);                 
              $('#name').val(obj.name);
              $('#Action').val(id);
              $('#submit').val(btn_action);
              updateId = id;          
              },
            error : function (msg){
                alert('error in getData');
              }
          })        
      }

      
      

</script>
<%
  
  Integer id = 0;
  String btnName = "Add Services";
  
  FoodServicesDao foodServicesDao = new FoodServicesDaoImp();
  //City cityBean = new City();
  
  //if(request.getParameter("id")!=null){
    //id = Integer.parseInt(request.getParameter("id"));
    
  //  btnName = "Update City";
  //}
  
%>


<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">

<jsp:include page="include/header.jsp"></jsp:include>
<jsp:include page="include/sidebar.jsp"></jsp:include>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Payment
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

             <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Add Payment</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="formID" onsubmit="return submitFormData();" >
              <div class="box-body">
                   <div class="form-group">
                    <input type="hidden" name="Action" id="Action" />
                  <label for="exampleInputEmail1">Service</label>
                  <input type="text" class="form-control" id="name"  placeholder="Service Name" value="" name="name" required="required" />
                </div>
                
              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <input type="submit" id = "submit" name="submit" class="btn btn-primary"  />
              </div>
            </form>
          </div>
          
  

  <div class="box">
            <div class="box-header">
              <h3 class="box-title">Marquees</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                <th>S.No</th> 
                  <th>Marquee Name</th>
                  <th>Per Month</th>
                  <th>Per Year</th>
                  <th>WhichMonthYearPay</th>
                  <th>Last Payment</th> 
                  <th>Add Payment</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0 ;
                PaymentDao paymentDao = new PaymentDaoImp();
                Calendar calendar = Calendar.getInstance();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat sdf1 = new SimpleDateFormat("MM");  
                SimpleDateFormat sdf2 = new SimpleDateFormat("dd");
                Date date = null;
                
                //calendar.set(2,2,2);
                for(Payment p : paymentDao.getPaymentPending()){ 
                  serialNo++;
                  date = new Date();
                  Date date1 = new Date();
//                  calendar = new GregorianCalendar(2,2,2);
//                  date  = sdf.parse(p.getMarquees().getCreated_at());
//                  date.setDate(Integer.parseInt(p.getMarquees().getCreated_at()));
                  //calendar.setTime(date);
                  String y = ""+sdf.format(sdf.parse(p.getMarquees().getCreated_at()));
                  String m = y;
                  String d=y;

                  y=y.substring(0,4);
                  m=m.substring(5,7);    
                  d=d.substring(8,10);
    
                  calendar.set(Integer.parseInt(y),Integer.parseInt(m)-1,Integer.parseInt(d));
                   
                  y= sdf.format(date); // in y string here is using current date
                  
                  calendar.add(Calendar.MONTH, 2);
                   
                  date = calendar.getTime();
                  
                  
                  m=sdf.format(date); // in m string here is using database date
                   
                  if(date.after(date1)){
                  System.out.println("date is "+m+" "+y); 
                %>
                <tr> 
                    <td><%=serialNo%></td>
                    <td><%=p.getMarquees().getName()%></td> 
                    <td><%=p.getPerMonth()%></td>
                    <td><%=p.getPerYear()%></td> 
                    <td><%=p.getWhichMonthYearDate()%></td>   
                    <td><%=p.getPaymentdate()%></td>
                    <td><a href="#"><input type="image" src="img/cash.png" onclick="getData(<%=p.getId()%>)" /></a>
                    </td>
                </tr>
                <%}} %>
                </tbody>
                <tfoot>
                <tr>
                <th>S.No</th> 
                  <th>Marquee Name</th>
                  <th>Per Month</th>
                  <th>Per Year</th>
                  <th>WhichMonthYearPay</th>
                  <th>Last Payment</th>
                  <th>Add Payment</th>
                </tr>
                </tfoot>  
              </table>
            </div>
            <!-- /.box-body -->
          </div>
  



   <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<!-- Bootstrap 3.3.7 -->

<script src="../frontend/assets/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="../frontend/assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="../frontend/assets/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="../frontend/assets/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="../frontend/assets/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../frontend/assets/bower_components/fastclick/lib/fastclick.js"></script><!-- AdminLTE App -->
<script src="../frontend/assets/dist/js/adminlte.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->

<!-- AdminLTE for demo purposes -->
<script src="../frontend/assets/dist/js/demo.js"></script>
<script>
  $(function () {
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
    })
  })
</script>
</body>
</html>