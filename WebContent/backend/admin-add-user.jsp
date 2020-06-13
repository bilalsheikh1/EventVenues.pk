<%@page import="com.easybooking.model.Admin"%>
<%@page import="com.easybooking.daoImp.AdminDaoImp"%>
<%@page import="com.easybooking.dao.AdminDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.easybooking.daoImp.FoodServicesDaoImp"%>
<%@page import="com.easybooking.dao.FoodServicesDao"%>
<%@page import="com.easybooking.model.FoodServices"%>
<%@page import="com.easybooking.daoImp.MarqueeFoodServiceDaoImp"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeFoodServiceDao"%>
<%@page import="com.easybooking.model.MarqueeFoodService"%>
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
  <!-- bootstrap wysihtml5 - text editor -->
  <link rel="stylesheet" href="../frontend/assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

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
				  $("#Datadeleted").css("display","none");
        			$("#Dataaffected").css("display","none");
			  }, 3000) }
  
  function insertUser(){
      $.ajax({
          url : '../AdminServlet', 
          data : $('#formID').serialize(),
          type : 'post',
  
          success : function(data){ 
              if(data != ""){ 
            	  $('#getrecord').html(data); 
                  $('#id').val("");  
    				$('#name').val("");
    				$('#email').val("");
    				$('#password').val("");
    				$('#method').val("insert");
    				$('#submit').val("Add User"); 
    				 
                  closeAlert();
          			$("#Datadeleted").css("display","none");
          			$("#Dataaffected").css("display","block");
          		}
            },
          error : function(){
              alert("error in service method");
            }
        })
        return false;   
    }

  function getUserByID(id){
      $.ajax({
          url : '../AdminServlet' ,
          data : "method=getDataByID&id="+id ,
          type : 'post' ,
 
          success : function (data){
              console.log(data);
        	  var obj = JSON.parse(data);   
             	  	$('#id').val(obj.id);  
					$('#name').val(""+obj.name);
					$('#email').val(obj.email);
					$('#password').val(obj.password);
					
              $('#submit').val("Update User");
        	  $('#method').val("update"); 
            } ,
          error : function (){
              alert("error in insert service method");
            }
        
        })
      return false;
    }  

    function deleteUser(id){
        var a = confirm("Are You Sure Delete This User");
        if(a){
        $.ajax({
            url : '../AdminServlet',
            data : 'method=delete&id='+id,
            type : 'post', 

            success : function (data){  
            	$('#getrecord').html(data); 
            	if(data != ""){
                		$("#Datadeleted").css("display","block");
                		$("#Dataaffected").css("display","none");
                		closeAlert();
                	}
              }, 
            error : function(){
                alert("error in delete method");
              }
          })  
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
        Admin User Crud
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol> 
      
      <div class="alert alert-danger alert-dismissible"  style="display: none" id="Datadeleted" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Area Deleted. 
              </div>
              
	    	<div class="alert alert-success alert-dismissible"  style="display: none" id="Dataaffected" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Data Affected. 
              </div>
      

     <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Add User</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="formID" onsubmit="return insertUser();" >
              <div class="box-body">
              <input type="hidden" name="method" value="insert"  id="method"/>
              <input type="hidden" name="id" id="id"/>  
                   <div class="form-group">

                  <label for="exampleInputEmail1">Name</label>
                  <input type="text" id="name" class="form-control"  placeholder="Enter Name (Allow only letters)" name="name" required="required" minlength="3" maxlength="40" pattern="[A-Za-z ]+" title="(Allow only letters & Min length 3)"/>
                </div>
                
                <div class="form-group">
                  <label for="exampleInputEmail1">Email</label>
                  <input type="email" id="email" class="form-control"  placeholder="Enter Email " name="email" required="required" />
                </div>
                
                <div class="form-group">
                  <label for="exampleInputEmail1">Password</label>
                  <input type="password" id="password" class="form-control"  placeholder="Enter Password "  name="password" required="required" />
                </div>
                
            
              </div>
              <!-- /.box-body --> 

              <div class="box-footer"> 
                <input type="submit" id = "submit" name="submit" value="Add User" class="btn btn-primary"  />
              </div>
            </form>
          </div>

      <div class="box">
            <div class="box-header">
              <h3 class="box-title">Admin User Data</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>S.No</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Password</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% AdminDao adminDao = new AdminDaoImp();
                		  byte serial = 0; 
                for(Admin a : adminDao.getData()){ serial++;%>
                	<tr>
                		<td><%=serial%></td>
                		<td><%=a.getName()%></td>
                		<td><%=a.getEmail()%></td>
                		<td><%=a.getPassword()%></td>
                		<td><img src="img/updateicon.png" style="cursor: pointer;" onclick="getUserByID(<%=a.getId()%>)" /><img src="img/deleteicon.png" style="cursor: pointer;" onclick="deleteUser(<%=a.getId()%>)" /></td>
                	</tr>
                <%} %>
                </tbody>
                <tfoot>  
                <tr>    
                  <th>S.No</th>
                  <th>Name</th>
                  <th>Email</th>
                  <th>Password</th>
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