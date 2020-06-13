<%@page import="java.util.ArrayList"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="sun.security.jca.GetInstance"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.easybooking.model.Payment"%>
<%@page import="com.easybooking.daoImp.PaymentDaoImp"%>
<%@page import="com.easybooking.dao.PaymentDao"%>
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
  var marqueeID = 0; 
  
  function addPayment(id){ 
    marqueeID = id;
      $("#myModal").modal();
    }   
  function paymentAdd(){ 
    $('#marqueeID').val(marqueeID);
      $.ajax({
          url : '../PaymentServlet',
          data : $("#formID").serialize(),
          type : 'post',
          success : function (msg){
                  alert(msg); 
                  location.reload();
            }, 
          error  : function (){
              alert("error in payment method ");
            }
        })
      return false;
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
  

  <div class="box">
            <div class="box-header">
              <h3 class="box-title">Add Marquees Payment</h3>
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
                  <th>Payment Date</th> 
                  <th>Add Payment</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0 ;
                PaymentDao paymentDao = new PaymentDaoImp();
                Calendar calendar = Calendar.getInstance();
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = null;
                  
                for(Payment p : paymentDao.getPaymentPending()){ 
                  serialNo++;
                  date = new Date();
                  Date date1 = new Date();
//                  calendar = new GregorianCalendar(2,2,2);
//                  date  = sdf.parse(p.getMarquees().getCreated_at());
//                  date.setDate(Integer.parseInt(p.getMarquees().getCreated_at()));
                  //calendar.setTime(date);
                  String y = ""+sdf.format(sdf.parse(p.getWhichMonthYearDate())); 
                  String m = y; 
                  String d=y;

                  y=y.substring(0,4); 
                  m=m.substring(5,7);    
                  d=d.substring(8,10);
    
                  calendar.set(Integer.parseInt(y),Integer.parseInt(m)-1,Integer.parseInt(d));

                  y= sdf.format(date); // in y string here is using current date
                  if(p.getPerMonth() > 0){  
                    calendar.add(Calendar.MONTH, 1);
                  }
                  else{
                    calendar.add(Calendar.YEAR, 1); 
                  }
                  date = calendar.getTime();
                  
                  m=sdf.format(date); // in m string here is using database date
      
                  if(date.before(date1)){ 
                %>
                <tr>  
                    <td><%=serialNo%></td> 
                    <td><%=p.getMarquees().getName()%></td> 
                    <td><%=p.getPerMonth()%></td>
                    <td><%=p.getPerYear()%></td> 
                    <td><%=p.getWhichMonthYearDate()%></td>   
                    <td><%=p.getPaymentdate()%></td>    
                    <td><a id="add" data-toggle="modal" onclick="addPayment(<%=p.getMarquees().getId()%>);"><input type="image" src="img/cash.png"  /></a>
                    </td>  
                </tr>
                <%} }%>
                </tbody>
                <tfoot>
                <tr>
                <th>S.No</th> 
                  <th>Marquee Name</th>
                  <th>Per Month</th>
                  <th>Per Year</th>
                  <th>WhichMonthYearPay</th>
                  <th>Payment Date</th> 
                  <th>Add Payment</th>
                </tr>
                </tfoot>  
              </table>
            </div>
            <!-- /.box-body -->
          </div>
  

  <div class="container">
      <div class="modal fade" id="myModal" role="dialog">
        <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
           
          <button type="button" class="close" data-dismiss="modal&times"></button>
        
           
        
          <h4 class="modal-title">Add Payment</h4>
        </div>
          
        
        <div class="modal-body">
         
        <form onsubmit="return paymentAdd();" id="formID">
        
        <input type="hidden" name="marqueeID" id="marqueeID" />
        <input type="hidden" name="Action" value="add-payment" />   
              
              <div class="form-group">
                
                <label>   
                <span>Per Month</span>
                  <input type="radio" name="r1" class="minimal" onclick="payment('month');"  required="required"/>
                </label>
                
                <label>
                <span>Per Year</span> 
                  <input type="radio" name="r1" class="minimal" onclick="payment('year');" required="required" />
                </label> 
                
              </div>
              
              
          <div class="form-group" id="textfiled" ></div> 
                    
          <div class="form-group">
          <label>Which Month/Year Payment</label> 
          <input type="date" name="date"  class="form-control" required="required" />
          </div>
             
          <div class="form-group">
          <input type="submit" class="btn btn-info" name="sbt" />
           </div>  
        </form>    
        </div>

        <div class="modal-footer"> 
          <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
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