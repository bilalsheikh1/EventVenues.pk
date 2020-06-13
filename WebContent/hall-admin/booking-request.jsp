<%@page import="com.easybooking.model.Portion"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.easybooking.daoImp.BookingRequestDaoImp"%>
<%@page import="com.easybooking.dao.BookingRequestDao"%>
<%@page import="com.easybooking.model.BookingRequest"%>
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
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> 
<script type="text/javascript">
var marqueeID=0;
var id=0;
var bookedDate="";
var shift = "";
var userID = 0;
var capacity = 0;
function getIDForApproved(id , marqueeID,bookedDate , shift ,userID ,capacity){
	this.id = id;
	this.marqueeID = marqueeID;
	this.bookedDate = bookedDate;
	this.shift = shift;
	this.userID = userID;
	this.capacity = capacity;
	$('#accept').css('display','block');
	$('#reject').css('display','none');
	$('#acceptBtn').css('display','block');
	$('#rejectBtn').css('display','none');
}
function getIDForDisApproved(id){
	this.id = id;
	$('#accept').css('display','none');
	$('#reject').css('display','block');
	$('#acceptBtn').css('display','none');
	$('#rejectBtn').css('display','block');
}
function closeAlert(){
	setTimeout(
			  function() 
			  {
				  $("#dataAccept").css("display","none");
					$("#dataDelete").css("display","none");
			  }, 3000) }

function approved(){  
    var cost = $('#cost').val();
    if (cost > 0){
      var advance = $('#advance').val();
      if(advance > 0){
        if(advance <= cost){
       var marqueeName = $('#marqueeName').val();
       var userName= $('#userName').val();
       var eventName = $('#eventName').val();
       var email = $('#email').val();  
    $.ajax({
        url : '../BookingServlet' ,
        data : "id="+id+"&method=approved&marqueeID="+marqueeID+"&bookedDate="+bookedDate+"&shift="+shift+"&cost="+cost+"&advance="+advance+"&marqueeName="+marqueeName+"&userName="+userName+"&eventName="+eventName+"&email="+email+"&userID="+userID+"&capacity="+capacity,
        type : 'post' ,       
  
        success: function (data){
            $("#getrecord").html(data);
					$("#dataAccept").css("display","block");
					$("#dataDelete").css("display","none");
					closeAlert();
          } ,
        error : function () {
          alert("data not approved error in approved method");
        }

      })
    } 
    else{
      alert("Not allowed advance greather then Total Cost");
    }
  }
  else {
      alert("Please Enter Advance Payment First");
    }
}
else {
    alert("Please Enter Payment First");
  }
  
}
     
  function disApproved (){
      $.ajax({
      url : '../BookingRequestServlet' ,
      data : "id="+id+"&method=disApproved" ,
      type : 'post' ,

      success: function (data){
        		$("#getrecord").html(data);
				$("#dataAccept").css("display","none");
				$("#dataDelete").css("display","block");
				closeAlert(); 
        } ,
      error : function () {
     	   alert("data not disaproved error in disapproved method");
        }
      })
  }
</script>

<%
  BookingRequest requestBean = new BookingRequest();
  BookingRequestDao requestDao = new BookingRequestDaoImp();
%>

<body class="hold-transition skin-blue sidebar-mini">



    	


<center>
<div id="myModal" class="modal fade">
	<div class="modal-dialog modal-confirm">
		<div class="modal-content">
			<div class="modal-header">
				<div class="icon-box">
					<i class="material-icons">&#xE5CD;</i>
				</div>				
				<h4 class="modal-title">Are you sure?</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body" id="accept" style="display : none">
				<p><b>Enter Total Cost</b></p>
				<input type="number" class="form-control" id="cost">
				
				<p><b>Enter Advance</b></p>
				<input type="number" class="form-control" id="advance">
			</div>     
			<div class="modal-body" id="reject" style="display : none">
			<p>Do you really want to delete these records? This process cannot be undone.</p>
			</div>   
			<div class="modal-footer">
				<button type="button" class="btn btn-info" data-dismiss="modal">Cancel</button>
				<button type="button" class="btn btn-success" onclick="approved();" data-dismiss="modal" id="acceptBtn">Accept Booking</button>
				<button type="button" class="btn btn-danger" onclick="disApproved();" data-dismiss="modal" id="rejectBtn">Reject Booking</button>
			</div>
		</div>
	</div>
</div> 
</center>    

 

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
    
 

	<div class="alert alert-success alert-dismissible"  style="display: none" id="dataAccept" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Booking Accpeted.
              </div>
                   
              
    	<div class="alert alert-danger alert-dismissible"  style="display: none" id="dataDelete" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Booking Rejected.
              </div>


      <div class="box">
            <div class="box-header">
              <h3 class="box-title">Booking Requests</h3>
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
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <tr> 
                  <% int serialNumber=0;
                  String marqueeName ="", userName="" , eventName="", email=""; 
                  if(session.getAttribute("marquee_id")!=null)
                    for(BookingRequest r : requestDao.getBooking(Integer.parseInt(""+session.getAttribute("marquee_id")))){ serialNumber++; 
                      marqueeName = r.getMarquee().getName();
                      userName = r.getUser_id().getName();
                      eventName = r.getEventName();
                      email = r.getUser_id().getEmail();
                    %> 
                    <tr> 
                      <td><%=serialNumber %></td>
                      <td><%=r.getEventName()%> (<% if(r.getMarquee().getPortions()!=null){ for(Portion p : r.getMarquee().getPortions()){ if(p.getId() == r.getPortion().getId()){ %><%=p.getName()%><% } }}%>)</td>
                      <td><%=r.getCapacity()%></td>
                      <td><%=r.getShift()%></td> 
                      <td><%=r.getBookedDate()%></td>
                      <td><%=r.getUser_id().getContact()%></td>  
                      <td><a href="#myModal" class="trigger-btn" data-toggle="modal"><input type="image" id="image" src="../backend/img/checked.png" onclick="getIDForApproved('<%=r.getId()%>', '<%=r.getMarquee().getId()%>' , '<%=r.getBookedDate()%>' , '<%=r.getShift() %>' , '<%=r.getUser_id().getId()%>' , '<%=r.getCapacity()%>');"  /></a>  
                        <a href="#myModal" class="trigger-btn" data-toggle="modal"><input type="image" id="image" src="../backend/img/cancel.png" onclick="getIDForDisApproved('<%=r.getId() %>')" /></a>
                        </td>
                    </tr>  
                  <%} %>
                </tr>
                </tbody>
                <tfoot>  
                <tr>   
                  <th>S.No</th>
                  <th>EventName</th>
                  <th>Capacity</th>
                  <th>Shift</th>
                  <th>BookedDate</th>
                  <th>Contact</th>
                  <th>Action</th>
                </tr>
                </tfoot>
              </table>
            </div>
              <input type="hidden" id="marqueeName" value="<%=marqueeName%>" name="marqueeName" />
               <input type="hidden" id="userName" value="<%=userName%>" name="userName" />
               <input type="hidden" id="eventName" value="<%=eventName%>" name="eventName" />
               <input type="hidden" id="email" value="<%=email%>" name="email" />
            <!-- /.box-body -->
          </div>
  

</section>





   <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- jQuery 3 -->
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