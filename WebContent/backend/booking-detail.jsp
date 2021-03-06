<%@page import="java.util.ArrayList"%>
<%@page import="com.easybooking.model.Booked"%>
<%@page import="com.easybooking.daoImp.BookedDaoImp"%>
<%@page import="com.easybooking.dao.BookedDao"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><% if(session.getAttribute("admin")==null){ response.sendRedirect("index.jsp");}%>
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


function closeAlert(){
setTimeout(
		
		  function() 
		  {
			  $('#Dataupdate').css("display","block");
		  }, 3000) } 
		  

    function approved(id){
      var r = confirm ("Are You Sure to Approved This Marquee");
       if(r == true){
        $.ajax({
          url : '../Marquee' ,
          data : "id="+id+"&method=approved&type=approved" ,
          type : 'post' ,

          success: function (data){
            $("#getrecord").html(data);
        	    if(data !=""){
					$('#Dataupdate').css("display","block");
					closeAlert();
            	}
            } ,
          error : function () {
            alert("data not approved error in approved method");
          }

        })
       }
    }



</script>
<%
BookedDao bookedDao = new BookedDaoImp();
ArrayList<Booked> list = null;
Integer id = 0;
if(request.getParameter("id")!=null){ 
  
  
  String encrypt=request.getParameter("id");  
  String decrypt = "";
  
  for(int j = 0 ; j < encrypt.indexOf("M") ; j++){
    decrypt += encrypt.charAt(j);
  }
  	 id = Integer.parseInt(decrypt);
 	 list = bookedDao.getParticularMarqueeBooking(id);
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
        Dashboard
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
  
  		
    	<div class="alert alert-success alert-dismissible"  style="display: none" id="Dataupdate" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Marquee Accept.
              </div>  

  <div class="box">
  
  
            <div class="box-header"> 
              <h3 class="box-title"><%=list.get(0).getBookingRequest().getMarquee().getName()%> Booking Details</h3>
            </div> 
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>S.No</th>
                  <th>EventName</th>
                  <th>Capacity</th>
                  <th>Shift</th>
                  <th>BookedDate</th>
                  <th>Contact</th>
                  <th>Cost</th>
                  <th>Advance</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0; double totalCost = 0;
                for(Booked  b : list){  
                  serialNo++;
                  SimpleDateFormat sdf = new SimpleDateFormat("dmyyHHmmssz");
          Date date = new Date();
          String d = sdf.format(date);
          totalCost += b.getBookingRequest().getCost();
                %>
                <tr> 
                  <td><%=serialNo%></td>
                    <td><%=b.getBookingRequest().getEventName() %></td>
                    <td><%=b.getBookingRequest().getCapacity()%></td>
                    <td><%=b.getBookingRequest().getShift()%></td>
                    <td><%=b.getBookingRequest().getBookedDate()%></td>
                    <td><%=b.getBookingRequest().getContact()%></td>
                    <td><%=b.getBookingRequest().getCost()%></td>
                    <td><%=b.getBookingRequest().getAdvance()%></td>   
                </tr>
                <%} %>
                </tbody>
                <tfoot>
                <tr>
                  <th>S.No</th>
                  <th>EventName</th>
                  <th>Capacity</th>
                  <th>Shift</th>
                  <th>BookedDate</th>
                  <th>Contact</th>
                  <th>Cost</th>
                  <th>Advance</th> 
                </tr>
                </tfoot>
              </table>   <hr>
              <div style="font-size: 20px;"><b>Total Cost : <%=totalCost%></b></div>
            </div>
            <!-- /.box-body -->
            
            
            
          </div>
  
  </section>


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