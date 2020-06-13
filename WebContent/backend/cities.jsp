<%@page import="com.easybooking.daoImp.CityDaoImp"%>
<%@page import="com.easybooking.dao.CityDao"%>
<%@page import="com.easybooking.model.City"%>
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
  <link rel="stylesheet" href="assets/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
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

  var btn_action = "Add City";
    $(document).ready(function(){
          $('#submit').val(btn_action);
          $('#Action').val(btn_action);
      }) 
      
function closeAlert(){
setTimeout(
		
		  function() 
		  {
			  $('#Dataaffected').css("display","none");
			  $('#Datadeleted').css("display","none");
		  }, 3000) } 
		  
    function submitFormData(){
        $.ajax({ 
          url : '../CityServlet' , 
          data : $("#formID").serialize(),
          type : 'post',
          success : function(data){ 
              
              if(data != ""){
            	  $("#formID")[0].reset();
                  $('#getrecord').html(data); 
                  $('#submit').val("Add City");
                  $('#Action').val("Add City");
                  
                   closeAlert();
         	      $('#Dataaffected').css("display","block");
         	     $('#Datadeleted').css("display","none");
              }
              
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
              url : '../CityServlet' ,
              data : "method=delete&id="+id,
              type : 'post', 
              success : function(data){
                 	if(data != ""){
                 			$("#getrecord").html(data);
             				closeAlert();
							$('#Datadeleted').css("display","block");
							$('#Dataaffected').css("display","none");
                     	}  
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
        btn_action = "Update City";
        $.ajax({
            url : '../CityServlet' ,
            data : "method=getData&id="+id,
            type : 'post',
            success : function(data){
              var obj = JSON.parse(data);                 
              $('#name').val(obj.cityName);
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
  
  //Integer id = 0;
  String btnName = "Add City";
  
  CityDao cityDao = new CityDaoImp();
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
        Cities
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    

	  
    	<div class="alert alert-danger alert-dismissible"  style="display: none" id="Datadeleted" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                City Deleted. 
              </div>
              
    	<div class="alert alert-success alert-dismissible"  style="display: none" id="Dataaffected" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Data Affected. 
              </div>
              
              
	 
   <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Add City</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="formID" onsubmit="return submitFormData();" >
              <div class="box-body">
                   <div class="form-group">
                    <input type="hidden" name="Action" id="Action" />
                  <label for="exampleInputEmail1">City</label>
                  <input type="text" class="form-control" id="name"  placeholder="City Name" value="" name="name" required="required" />
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
              <h3 class="box-title">Cities</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                  <th>S.No</th>
                  <th>Cities Name</th>
                  <th>CreatedAt</th>
                  <th>UpdatedAt</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0 ; 
                for(City c : cityDao.getCities()){  
                  serialNo++;
                %>
                <tr> 
                   <td><%=serialNo%></td>
                    <td><%=c.getName()%></td>
                    <td><%=c.getCreated_at()%></td>
                    <td><%=c.getUpdated_at()%></td>
                    <td><a href="#"><input type="image" src="img/updateicon.png" onclick="getData(<%=c.getId()%>)" /></a>
                      <input type="image" id="image" src="img/deleteicon.png" onclick="deleterecord(<%=c.getId() %>)" value="<%=c.getId()%>" />
                    </td>
                </tr>
                <%} %>
                </tbody>
                <tfoot>
                <tr>
                  <th>S.No</th>
                  <th>Cities Name</th>
                  <th>CreatedAt</th>
                  <th>UpdatedAt</th>
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