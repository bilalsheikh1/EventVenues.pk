<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.easybooking.encrypt.Encrypt"%>
<%@page import="com.easybooking.model.User"%>
<%@page import="com.easybooking.daoImp.UserDaoImp"%>
<%@page import="com.easybooking.dao.UserDao"%>
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
			  $("#dataUpdated").css("display" , "none");
		  }, 3000) } 
		  

function approvedRecord(id)
{
  
    //var id = e.target.value;
      $.ajax({
        url : '../UserServlet' ,
        data : "method=approved&id="+id,
        type : 'post',
        success : function(data){
           console.log(data);
           $("#getrecord").html(data);
           if(data !=""){
				$('#Dataupdate').css("display","block");
				closeAlert();
            }  
          },
          error : function (msg){
            alert('error in add');
          }
    })        
   
}


/*
 
 function deleterecord(id)
  {
    var r = confirm ("Are You Sure to Delete User");
     if(r == true){
      //var id = e.target.value;
        $.ajax({
          url : '../UserServlet' ,
          data : "method=delete&id="+id,
          type : 'post',
          success : function(data){
             console.log(data);
             $("#getrecord").html(data);  
            },
            error : function (msg){
              alert('error in add');
            }
      })        
     }
  }
  */
</script>

 
<body class="hold-transition skin-blue sidebar-mini">

<%
  UserDao userDao = new UserDaoImp();

%>

<div class="wrapper">

<jsp:include page="include/header.jsp"></jsp:include>
<jsp:include page="include/sidebar.jsp"></jsp:include>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Local Users
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    
    
    	<div class="alert alert-success alert-dismissible"  style="display: none" id="Dataupdate" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                User Active.
              </div>  
    
    <div class="box">
    
              
            <div class="box-header">
              <h3 class="box-title">Users</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>S.No</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Contact</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0;
                for(User u : userDao.getAllRecord(0)){  
                      serialNo++;
                      SimpleDateFormat sdf = new SimpleDateFormat("dmyyHHmmssz");
            Date date = new Date();
            String d = sdf.format(date);
                  %>
                <tr>  
                  <td><%=serialNo%></td>
                    <td><%=u.getName() %></td>
                    <td><%=u.getEmail() %></td>
                    <td><%=u.getContact() %></td>
                    <td><a href="#"><input type="image" src="img/checked.png" onclick="approvedRecord(<%=u.getId()%>)"></a></td>
                </tr>
                <%} %>
                </tbody>
                <tfoot>
                <tr>
                  <th>S.No</th>
                  <th>Name</th>
                  <th>Email</th>
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