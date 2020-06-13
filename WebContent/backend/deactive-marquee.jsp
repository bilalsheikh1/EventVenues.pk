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
			  $('#Dataupdate').css("display","none");
		  }, 3000) } 

var id=0;

function getID(id){
	this.id = id;
}

    function approved(){ 
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



</script>
<%
  MarqueeDao marqueeDao = new MarqueeDaoImp();
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
				<h4 class="modal-title">Are you sure? To Approve This Marquee</h4>	
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body" id="reject" style="display : none">
				<p>Do you really want to delete these records? This process cannot be undone.</p>
			</div>   
			<div class="modal-footer">
	   			<button type="button" class="btn btn-info" data-dismiss="modal">Cancel</button> 
				<button type="button" class="btn btn-success" onclick="approved();" data-dismiss="modal" id="rejectBtn">Approve...?</button>
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
  
  		
    	<div class="alert alert-success alert-dismissible"  style="display: none" id="Dataupdate" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Marquee Approved.
              </div>  

  <div class="box">
  
  
            <div class="box-header">
              <h3 class="box-title">Rejected Marquee</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>S.No</th>
                  <th>Marquee Name</th>
                  <th>address</th>
                  <th>Contact</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0;
                for(Marquee m : marqueeDao.getMarqueeDataForApproved(2)){  
                  serialNo++;
                  SimpleDateFormat sdf = new SimpleDateFormat("dmyyHHmmssz");
          Date date = new Date();
          String d = sdf.format(date);
                %>
                <tr>
                  <td><%=serialNo%></td>
                    <td><%=m.getName() %></td>
                    <td><%=m.getAddress() %></td>
                    <td><%=m.getContact() %></td>
                    <td><a href="#myModal" class="trigger-btn" data-toggle="modal"><input type="image" id="image" src="img/checked.png" onclick="getID(<%=m.getId()%>)" value="<%=m.getId() %>" /></a>
                    <a href="booking-detail.jsp?id=<%=m.getId()%>Mb<%=d.replaceAll("\\s", "")%>Ne3Gj3I7"><input type="image" id="image" src="img/detail.png" /></a>
                    </td>   
                </tr>
                <%} %>
                </tbody>
                <tfoot>
                <tr>
                  <th>S.No</th>
                  <th>Marquee Name</th>
                  <th>address</th>
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