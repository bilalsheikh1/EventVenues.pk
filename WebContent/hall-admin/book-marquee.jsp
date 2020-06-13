<%@page import="com.easybooking.model.Marquee"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Portion"%>
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

/*  function book(){ 
    var date = $('#date').val();   
    var shift = $('#shift').val();
    var marquee_id = $('#marquee_id').val();
      $.ajax({
          url : '../BookingServlet' , 
          data : 'method=check&date='+date+'&shift='+shift+'&marquee_id='+marquee_id ,
          type : 'post',

          success : function (msg){
              if(msg == "not"){
                  bookNow();      
                }
              else{ 
                  alert(msg);
                } 
            },
          error : function (){
              alert('error in check method');
            }
        }) 
    }   */
    function closeAlert(){
    	setTimeout(
    			  function() 
    			  { 
    				  $("#insert").css("display","none");
    			  }, 3000) }
	  
  function bookNow(){   
      $.ajax({
          url : '../BookingRequestServlet',
          data : $('#formData').serialize() ,
          type : 'post' ,

          success : function (msg){
				if(msg != ""){
            		$('#insert').css('display' , 'block');
            		closeAlert(); 
				}
            } ,
          error : function (){
              alert("error in BookNOw method");
            }
        })
    
      return false;
    } 

</script>
<%
	Marquee marqueeBean = new Marquee();
	MarqueeDao marqueeDao = new MarqueeDaoImp();
	marqueeBean=marqueeDao.getDataById(Integer.parseInt(""+session.getAttribute("marquee_id")));
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
        Book Now
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    

    <div class="alert alert-success alert-dismissible"  style="display: none" id="insert" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Booking Inserted.
              </div>

<form id="formData" onsubmit="return bookNow();">
  <div class="box box-primary">
  
            <div class="box-header"> 
              <h3 class="box-title">Book</h3>
            </div>
            <div class="box-body">
              <!-- Date -->
              <div class="form-group">
                <label>Name:</label>

                <div class="input-group date">
                  <div class="input-group-addon">
                    <i class="fa fa-user"></i> 
                  </div>
                  <input type="hidden" value="admin-book" name="method">
  		<input type="hidden" value="<%=session.getAttribute("marquee_id") %>" name="marquee_id">
                  <input type="text" class="form-control pull-right" id="name" name="name" placeholder="Name" required> 
                </div>
                <!-- /.input group -->
              </div>
              <!-- /.form group -->

              <div class="form-group">
                <label>Event Name :</label>

                <div class="input-group">
                  <div class="input-group-addon">
                     <i class="fa fa-window-maximize"></i>
                  </div>
                  <input type="text" class="form-control pull-right" name="eventName" placeholder="Event Name" required> 
                </div>
                <!-- /.input group -->
              </div>

              <!-- Date range -->
              <div class="form-group">
                <label>Mobile Number :</label>     

                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-phone"></i>
                  </div>
                  <input type="number" class="form-control pull-right" name="contact" placeholder="Mobile Number"  required>
                </div>
                <!-- /.input group -->
              </div>
              <!-- /.form group -->



              <!-- Date and time range -->


      <div class="form-group">
                <label>Capacity:</label>     

                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-user-plus"></i> 
                  </div>
                  <input type="number" class="form-control pull-right" name="capacity" placeholder="Enter Gathering" required>
                </div>
                <!-- /.input group -->
              </div>


      <div class="form-group">
                <label>Total Cost:</label>     

                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-user-plus"></i> 
                  </div> 
                  <input type="number" class="form-control pull-right" name="cost" placeholder="Enter Gathering" required>
                </div>
                <!-- /.input group -->
              </div>
              
      <div class="form-group">
                <label>Advance Cost:</label>     

                <div class="input-group">
                  <div class="input-group-addon">
                    <i class="fa fa-user-plus"></i> 
                  </div> 
                  <input type="number" class="form-control pull-right" name="advance" placeholder="Enter Gathering" required>
                </div>
                <!-- /.input group -->
              </div>

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
              <!-- /.form group -->
  
      
    
    <div class="form-group">
                <label>Shift :</label>
                <select class="form-control select2" style="width: 100%;" id="shift" name="shift" required>
                  <option value="">Select Shift</option>
                  <option value="Day">Lunch</option>
                  <option value="Night">Dinner</option>  
                </select>  
              </div>    
                <div class="checkbox" required> 
                  <%byte i=0; for(Portion p : marqueeBean.getPortions()){ %>
                  <label>   
                    <input type="checkbox" name="portionID<%=i%>" value="<%=p.getId()%>" id="portion" ><%=p.getName()%>
                    </label>
                <%i++;} %>   
                <input type="hidden" value="<%=marqueeBean.getPortions().size()%>" name="portionRange" />
                </div>
  			
  			<input type="hidden" id="marquee_id" name="marquee_id" value="<%=session.getAttribute("marquee_id")%>"/>   
              <!-- Date and time range -->
              <div class="form-group">
        <input type="submit" class="btn btn-block btn-primary btn-lg" />  
              </div>
              <!-- /.form group -->

            </div>
            <!-- /.box-body -->
          </div>  
  </form>

    
  
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
<script type="text/javascript">

$('#datepicker').datepicker({
  autoclose: true
})
</script>
</body>
</html>