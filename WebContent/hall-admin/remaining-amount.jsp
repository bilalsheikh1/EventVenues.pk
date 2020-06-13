<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.easybooking.daoImp.BookedDaoImp"%>
<%@page import="com.easybooking.dao.BookedDao"%>
<%@page import="com.easybooking.model.Booked"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>    
<% if(session.getAttribute("marquee_id")==null) response.sendRedirect("../frontend/login.jsp");%>
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
  <!-- DataTables -->
  <link rel="stylesheet" href="../frontend/assets/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../frontend/assets/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="../frontend/assets/dist/css/skins/_all-skins.min.css">
   
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
   
  function cancelRequest(id){
      var r = confirm("Are You Sure Cancel This Booking"); 
      if( r == true){
          $.ajax({ 
              url : '../BookingServlet' , 
              data : 'method=delete&id='+id,   
              type : 'post',
 
              success : function (data){
                  $("#getrecord").html(data);  
                  if(data != ""){
						$("#Datacancel").css("display","block");
                	}
                },  
              error : function (){
                  alert('error in delete button');  
                }
            })  
        }   
    }
         
  function dataAmount(){
      $.ajax({
          url : '../BookingServlet',
          data : $('#formID').serialize(),
          type : 'post',

          success : function(data){
              $('#getrecord').html(data);    
            },
          error : function (){
              alert("error in filter method"); 
            }
        })
      return false;
    }
  

</script>
<% 
  BookedDao bookedDao = new BookedDaoImp();
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
        Booking Dates    
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    
	
    <div class="alert alert-danger alert-dismissible"  style="display: none" id="Datacancel" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Booking Canceled.
              </div>

      <div class="box">
           <form id="formID" onsubmit="return dataAmount();" >
            <div class="box-header">
              <h3 class="box-title">Filter</h3>
            </div>
            <input type="hidden" name="filter" value="date" />
            <input type="hidden" name="marquee_id" value="<%=session.getAttribute("marquee_id")%>" /> 
            
            <div class="box-body">   
                <div class="form-group">
                <label>Date :</label>

                <div class="input-group">
                  <div class="input-group-addon">
                     <i class="fa fa-calendar"></i>
                  </div> 
                  <input type="date" class="form-control pull-right" name="date" id="date" placeholder="Enter Date" required>
                </div>   
                <!-- /.input group -->
              </div>
              <input type="submit" class="btn btn-block btn-primary btn-lg" value="Search"/>   
     </div>    
     </form>

</div>  

                   
      <div class="box">
            <div class="box-header">
              <h3 class="box-title">Approved Request</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead> 
                <tr>
                  <th>S.No</th>
                  <th>Name</th>
                  <th>Cost</th>
                  <th>Advance</th>
                  <th>Remaining</th>
                  <th>BookedDate</th>
                  <th>Contact</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0;  
                if(session.getAttribute("marquee_id")!=null){
                for(Booked b : bookedDao.getRemainingData("", Integer.parseInt(""+session.getAttribute("marquee_id")))) {  
                    serialNo++;  
                      String userName = "";
                      double remaining = b.getBookingRequest().getCost() - b.getBookingRequest().getAdvance();
                      if(b.getBookingRequest().getUser_id()!=null){  
                        userName = b.getBookingRequest().getUser_id().getName();
                      }
                      else{
                        userName=b.getBookingRequest().getBookName();   
                      } 

                      SimpleDateFormat sdf = new SimpleDateFormat("dmyyHHmmssz");
            Date date = new Date(); 
            String d = sdf.format(date);
                  %>
                <tr>   
                  <td><%=serialNo%></td>
                  <td><%=userName%></td> 
                    <td><%=b.getBookingRequest().getCost()%></td>
                    <td><%=b.getBookingRequest().getAdvance()%></td>
                    <td><%=remaining%></td> 
                    <td><%=b.getBookingRequest().getBookedDate()%></td>  
                    <td><%=b.getBookingRequest().getContact()%></td>    
                    <td> 
                      <input type="image" id="image" src="../backend/img/deleteicon.png" onclick="cancelRequest(<%=b.getId() %>)" value="<%=b.getId() %>" />
                      <a href="booking-detail.jsp?id=<%=b.getId()%>Mb<%=d.replaceAll("\\s", "")%>qOXa33T" ><input type="image" id="image" src="../backend/img/detail.png"   /></a>
                    </td> 
                </tr> 
                <%} }%>  
                </tbody>
                <tfoot>
                <tr> 
                  <th>S.No</th>
                  <th>Name</th>
                  <th>Cost</th>
                  <th>Advance</th>
                  <th>Remaining</th>
                  <th>BookedDate</th>
                  <th>Contact</th>
                  <th>Action</th>
                </tr>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
  


</section>

   <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

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