<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.easybooking.daoImp.PaymentDaoImp"%>
<%@page import="com.easybooking.dao.PaymentDao"%>
<%@page import="com.easybooking.model.Payment"%>
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
    <link rel="stylesheet" href="../frontend/assets/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
  
  
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="../frontend/assets/dist/css/skins/_all-skins.min.css">
  <!-- Morris chart -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/morris.js/morris.css">
  <!-- jvectormap -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/jvectormap/jquery-jvectormap.css">
  <!-- Date Picker -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
  <!-- Daterange picker -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/bootstrap-daterangepicker/daterangepicker.css">
   
    <link rel="stylesheet" href="../frontend/assets/plugins/iCheck/all.css">
  
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="../frontend/assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
<link rel="stylesheet" href="../frontend/assets/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
  <link rel="stylesheet" href="../frontend/assets/bower_components/select2/dist/css/select2.min.css">
 
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
   
    function submitFormData(){
        $.ajax({
          url : '../PaymentServlet' ,
          data : $("#formID").serialize(),
          type : 'post',
          success : function(msg){
               $('#month').val();
               $('#year').val();
               $('#marquee_id').val();
               $('#date').val(); 
               alert(msg); 
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
        $.ajax({
            url : '../FoodServicesServlet' ,
            data : "method=getData&id="+id,
            type : 'post',
            success : function(data){
              var obj = JSON.parse(data);                 
              $('#name').val(obj.name);
              $('#Action').val(id);
              updateId = id;          
              },
            error : function (msg){
                alert('error in getData');
              }
          })        
      }

  function payment(schedule){
      if(schedule == "month" ){
        $('#textfiled').empty();
        $('#textfiled').append('<label for="exampleInputEmail1">Per Month</label><input type="number" id="month" class="form-control" placeholder="Enter Monthly Charges " name="month" required="required" />');
        }
      else {
        $('#textfiled').empty();
        $('#textfiled').append('<label for="exampleInputEmail1">Per Year</label><input type="number" id="year" class="form-control" placeholder="Enter Yearly Charges "  name="year" required="required" /> '); 
        }
    }     
      

</script>
<%
  MarqueeDao marqueeDao = new MarqueeDaoImp();
  PaymentDao paymentDao = new PaymentDaoImp();
  ArrayList<Integer> list = new ArrayList<>();
  for(Payment p : paymentDao.getPaymentRecord()){
    list.add(p.getMarquees().getId());
  }
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
        Trial Version End
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

          <!--   <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Trial Version End</h3>
            </div>
            
          </div>  -->
  

  <div class="box">
            <div class="box-header with-border">
              <h3 class="box-title">Marquee Record</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                <th>S.No</th>
                  <th>Marquee Name</th>
                  <th>Join Date</th>
                  <th>Capacity</th>
                  <th>Contact</th>
                  <th>Email</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0 ;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date1=new Date();
                Date date=null;
                System.out.println("ok ");
                Calendar calendar = Calendar.getInstance();
                for(Marquee m : marqueeDao.getMarqueeData()){ 
                     boolean check = list.contains(m.getId());
                     System.out.println(check);  
                     if(check==false){  
                       System.out.println("ok ");
                    serialNo++;  
                      date = new Date();
//                      calendar = new GregorianCalendar(2,2,2);
//                      date  = sdf.parse(p.getMarquees().getCreated_at());
//                      date.setDate(Integer.parseInt(p.getMarquees().getCreated_at()));
                      //calendar.setTime(date);
                      String y = ""+sdf.format(sdf.parse(m.getCreated_at()));
                      String month = y;
                      String d=y;
    System.out.println(y);
                      y=y.substring(0,4);
                      month=month.substring(5,7);    
                      d=d.substring(8,10);  
       System.out.println(y+ " " + month+" "+d);  
                      calendar.set(Integer.parseInt(y),Integer.parseInt(month)-1,Integer.parseInt(d));
                       
                      y= sdf.format(date); // in y string here is using current date
                        
                      calendar.add(Calendar.MONTH, 2); 
                       System.out.println(calendar.getTime());
                      date = calendar.getTime();
                        
                      month=sdf.format(date); // in m string here is using database date
                       System.out.println(date+" -- "+(date1));  
                      if(date.before(date1)){ 
                %>
                <tr> 
                    <td><%=serialNo%></td>   
                    <td><%=m.getName()%></td>
                    <td><%=m.getCreated_at()%></td>
                    <td><%=m.getCapacity()%></td>
                    <td><%=m.getContact()%></td> 
                    <td><%=m.getEmail()%>
                  <!--  <a href="#"><input type="image" src="img/updateicon.png" onclick="getData(<%=m.getId()%>)" /></a>
                      <a href="#"><input type="image" id="image" src="img/deleteicon.png" onclick="deleterecord(<%=m.getId() %>)" /></a> -->
                    </td>
                </tr> 
                <% }}}%>
                </tbody>
                <tfoot>
                <tr>
                <th>S.No</th>
                  <th>Marquee Name</th>
                  <th>Join Date</th>
                  <th>Capacity</th>
                  <th>Contact</th>
                  <th>Email</th> 
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

<!-- jQuery 3 -->
<script src="../frontend/assets/bower_components/jquery/dist/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="../frontend/assets/bower_components/jquery-ui/jquery-ui.min.js"></script>
<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<!-- Bootstrap 3.3.7 -->
<script src="../frontend/assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- Morris.js charts -->
<script src="../frontend/assets/bower_components/raphael/raphael.min.js"></script>
<script src="../frontend/assets/bower_components/morris.js/morris.min.js"></script>
<!-- Sparkline -->
<script src="../frontend/assets/bower_components/jquery-sparkline/dist/jquery.sparkline.min.js"></script>
<!-- jvectormap -->
<script src="../frontend/assets/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../frontend/assets/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<!-- jQuery Knob Chart -->
<script src="../frontend/assets/bower_components/jquery-knob/dist/jquery.knob.min.js"></script>
<!-- daterangepicker assets/-->
<script src="../frontend/assets/bower_components/moment/min/moment.min.js"></script>
<script src="../frontend/assets/bower_components/bootstrap-daterangepicker/daterangepicker.js"></script>
<!-- datepicker -->
<script src="../frontend/assets/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<!-- Bootstrap WYSIHTML5 -->
<script src="../frontend/assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js"></script>
<!-- Slimscroll -->
<script src="../frontend/assets/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../frontend/assets/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../frontend/assets/dist/js/adminlte.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
<script src="../frontend/assets/dist/js/pages/dashboard.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../frontend/assets/dist/js/demo.js"></script>
<!-- DataTables --> 


<script src="../frontend/assets/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>  
<script src="../frontend/assets/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
   
<script>
  $(function () {
    $('input[type="radio"].minimal').iCheck({
        checkboxClass: 'icheckbox_minimal-blue',
        radioClass   : 'iradio_minimal-blue'
      })
  $('.select2').select2() 
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