	<%@page import="com.easybooking.model.MarqueeFoodService"%>
<%@page import="sun.misc.Perf.GetPerfAction"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.easybooking.model.Gallery"%>
<%@page import="java.util.HashSet"%>
<%@page import="com.easybooking.model.Portion"%>
<%@page import="java.util.Set"%>
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

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">

  $(document).ready(function(){
      
    })
    function approved(id){
      $.ajax({
          url : '../Marquee' ,
          data : "id="+id+"&method=approved" ,
          type : 'post' ,

          success: function (data){
            $("#getrecord").html(data);
            alert("Marquee Approved");
            window.location.href = "marquee-request.jsp";
            } ,
          error : function () {
            alert("data not approved error in approved method");
          }

        })
    }

  function disApproved (id){
    $.ajax({
      url : '../Marquee' ,
      data : "id="+id+"&method=disApproved" ,
      type : 'post' ,
  
      success: function (data){
        	alert("Marquee Rejected");
        	window.location.href="marquee-request.jsp";
        } ,
      error : function () {
        alert("data not disaproved error in disapproved method");
      }

    })
    }

</script>
</head>
<%
  Marquee marqueeBean = null;
  MarqueeDao marqueeDao = new MarqueeDaoImp();
  
  if(request.getParameter("id")!=null){ 
    
    Integer id = null;
    String encrypt=request.getParameter("id");  
    String decrypt = "";
//    Integer id = null;
    for(int j = 0 ; j < encrypt.indexOf("M") ; j++){
      decrypt += encrypt.charAt(j);
    }
    id = Integer.parseInt(decrypt);
    marqueeBean = marqueeDao.getDataById(id);
    
  } 
%>

<body class="hold-transition skin-blue sidebar-mini" >
 


<div class="wrapper" >

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
    </section>

  
    <div class="box box-default">
            <div class="box-header with-border">
              <h3 class="box-title">Marquee Detail</h3>
            </div>
            <div class="box-body">
             <div class="container"> 
              <div class="col-md-6"> 
        	<p style="color:#0e1b4d; font-family:Ralewayl; font-weight: 500; font-size:36px; text-transform: uppercase;"><%if(marqueeBean!=null)%><%=marqueeBean.getName()%></p>
              </div>
              <div class="col-md-4">
              
              
              
              <h4 style="color:#0e1b4d;font-family:Raleway; font-weight: 400; font-size:32px;"><b>Logo :</b></h4> 
              <% byte logo=0; 
              if(marqueeBean!=null){
              for(Gallery g : marqueeBean.getGalleries()){ logo++;
                if(logo==1){    %>
                <img src="${pageContext.request.contextPath}/img/<%=g.getLogo()%> " width="250px" height="150px" />
              <% } }
                }%>
              
              </div> 
              
             </div>
             
              <div class="container">
              <div class="col-md-4">
               
<h4 style="color:#0e1b4d;font-family:Raleway; font-weight: 400; font-size:25px;"><b>Portions Details : </b></h4> 
                <%byte portion = 0; if(marqueeBean!=null){ for (Portion p : marqueeBean.getPortions()) { portion++; %>
                
                  <p><b>Portion <%=portion%> : </b><%=p.getName()%></p>
                  <p><b>Capacity : </b><%=p.getPortionCapacity()%></p> 
              <% }} %> 
              </div>
              
              
              <div class="col-md-4">
              <ol>
                  <tr>
                  <th><h4 style="font-family:Raleway; font-weight: 400; font-size:25px;"><b>Marquee Services </b></h4></th>
                   </tr>
                   
                   <% if(marqueeBean!=null){
                   for (MarqueeFoodService s : marqueeBean.getMarqueeFoodServices()){ %>
                        </tr>
                        <li ><%=s.getFoodServices().getName()%></li></tr> 
                   <%}}%>
                   
                   </ol>
                  
              </div>
              
              
             <%if(marqueeBean!=null){ %>
              <div class="col-md-4">  
                <h4 style="font-family:Raleway; font-weight: 400; font-size:25px;"><b>Marquee Further Details:</b></h4>
                <p ><b>Email : </b><%=marqueeBean.getEmail() %></p>
                <p ><b>Contact : </b><%=marqueeBean.getContact() %></p> 
                <p ><b>Capacity : </b><%=marqueeBean.getCapacity() %></p>
                <p ><b>Address : </b><%=marqueeBean.getAddress() %></p>
                <p ><b>Created At : </b><%=marqueeBean.getCreated_at() %></p>
                <p ><b>City : </b><%=marqueeBean.getCity().getName()%></p>
                <p ><b>Area : </b><%=marqueeBean.getArea().getName()%></p>  
              </div>
              </div>
              <%} %>
              <div class="container">
              <h4 style="color:#0e1b4d;font-family:Raleway; font-weight: 400; font-size:25px;"><b>Marquee Images : </b></h4>
                <%if(marqueeBean!=null){ for(Gallery g : marqueeBean.getGalleries()){  %> 
                  <img alt="" src="${pageContext.request.contextPath}/img/<%=g.getImage()%>" width='350px' height="350px" style="border: 2px solid #ec8d3b; margin-top: 5px; "/>
                <%} }%>
              </div>
              
              
              <div>
              
              <hr style=" border-top: 2px solid; ">
              <%if(marqueeBean!=null){ %>
              <div style="float:right; width:14%; margin-left :7px;">
              <button class="btn btn-block btn-danger" onclick="disApproved(<%=marqueeBean.getId()%>)" >Reject</button>
              </div>
              <div style="float:right; width:14%;">
              <button class="btn btn-block btn-success" onclick="approved(<%=marqueeBean.getId()%>)" >Accept</button>
        </div> 
              <%} %> 
              <div style="clear: both;"></div>
              </div>
              
            </div>
          </div>
  
  
  
  
  
  
  



   <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- jQuery 3 -->
<script src="assets/bower_components/jquery/dist/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="assets/bower_components/jquery-ui/jquery-ui.min.js"></script>
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
</body>
</html>