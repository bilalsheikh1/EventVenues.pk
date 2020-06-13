<%@page import="com.easybooking.model.Gallery"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Portion"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>   
<head>

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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<style type="text/css">
.containers-img {
  position: relative;
  width: 351px; 
}

.image {
  opacity: 1;
  display: block;
  
  transition: .5s ease;
  backface-visibility: hidden;
}

.middle-img {
  transition: .5s ease;
  opacity: 0;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  text-align: center;
}

.containers-img:hover .image {
  opacity: 0.3;
}

.containers-img:hover .middle-img{
  opacity: 1;
}

</style>

<script type="text/javascript">

	function actionCheck(i){
	  	  if(i == 1){
				 $('#method').val('update');
		  	  }
	  	  else if (i == 2){
	  			$('#method').val('delete');
		  	  } 	
	  }
</script>

</head>


<%
  Marquee marqueeBean = new Marquee();
  Portion portionBean = new Portion();
  MarqueeDao marqueeDao = new MarqueeDaoImp();
  
  String folderName ="";
  String logo = "";
  if(session.getAttribute("marquee_id")!=null){  
    Integer id = Integer.parseInt(""+session.getAttribute("marquee_id"));
    marqueeBean = marqueeDao.getDataById(id);
    String folder="";

    for(Gallery g : marqueeBean.getGalleries()){
      if(g.getImage()!=null){
      folder=g.getImage();
      logo = g.getLogo();
      break;
      }
    }
    int index = folder.indexOf("/");  
    folderName =folder.substring(0,index); 
  }
  else {
     response.sendRedirect("../frontend/login.jsp");
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
        Marquee Details
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>

	 
    <div class="alert alert-success alert-dismissible"  style="display: none" id="dataUpdated" >
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-info"></i> Alert!</h4>
                Data Updated.
              </div> 
	       

  <div class="box">
            <div class="box-body">
              
              <div class="row">
        
        <div class="col-md-5">
        <% if(session.getAttribute("marquee_id")!=null){ %>
        <form id="marqueeDetail" onsubmit="return marqueeUpdate();">
        <input type="hidden" value="update" name="method"> 
        <input type="hidden" value="<%=session.getAttribute("marquee_id") %>" name="marquee_id">
        <input type="hidden" value="<%=marqueeBean.getCity().getId()%>" name="cityID">
        <input type="hidden" value="<%=marqueeBean.getArea().getId()%>" name="areaID" >
        <input type="hidden" value="<%=marqueeBean.getCreated_at()%>" name="createdAt">
        <input type="hidden" value="<%=marqueeBean.getUser().getId() %>" name="created_by"> 
         
        <h3 class="box-title">Marquee Details</h3> 
        
        <label> Name</label>
        <input type="text" class="form-control" style="margin:2px 0;" value="<%=marqueeBean.getName() %>" name="name" id="name"/>
        
        <label> Email</label>
        <input type="text" class="form-control" style="margin:2px 0;" value="<%=marqueeBean.getEmail()%>" name="email" id="email" />
        
        <label> Capacity</label>
        <input type="text" class="form-control" style="margin:2px 0;" value="<%=marqueeBean.getCapacity()%>" name="capacity" id="capacity" />
        
        <label> Address</label>
        <input type="text" class="form-control" style="margin:2px 0;" value="<%=marqueeBean.getAddress()%>" name="address" id="address" />
        
        <label> Contact</label>
        <input type="text" class="form-control" style="margin:2px 0;" value="<%=marqueeBean.getContact()%>" name="contact" id="contact" />
        
        <br>   
        <input type="submit" class="btn btn-primary" value="Update Marquee " >
         <%  }%>
         </form>
        </div>  
        
        
        <!-- Portion Area -->
         
        <div class="col-md-2"></div>
        <div class="col-md-5">
        <% if(session.getAttribute("marquee_id")!=null){ %>
              <form id="portionID" onsubmit="return portionDetail();" >
           
           		 
                <h3 class="box-title">Portion Details</h3> 
                <% int i = 0;for(Portion p : marqueeBean.getPortions()){  i++;%>
<br>  <br>            
				
				<input type="hidden" value="<%=p.getId()%>" name="portionID">
                
                <input type="hidden" value="" name="method" id="method"/>
                <input type="hidden" value="<%=session.getAttribute("marquee_id")%>" name="marquee_id" />
                
                <label>Portion Name</label> 
                <input type="text" class="form-control" style="margin: 2px 0;" value="<%=p.getName()%>" name="lawn" id="name<%=i%>" />
                
                 <label> Capacity</label> 
                 <input type="number" class="form-control" style="margin: 2px 0;" value="<%=p.getPortionCapacity()%>" name="capacity" id="name<%=i%>" /> <br>
                        
                  <input type="submit" class="btn btn-primary" value="Protion Update" onclick="actionCheck(1);"  /> 
                  <input type="submit" class="btn btn-danger" name="portion_delete" onclick="actionCheck(2);" value="Protion Delete" />  
                <%} }%>

              </form> 

            </div>             
              </div>
            
            
            <div > 
            <form id="formID-gallery" enctype="multipart/form-data" >
              <input type="hidden" name="img" value="add" >
              <input type="hidden" name="folderName" value="<%=folderName%>" />
              <input type="hidden" name="logo" value="<%=logo%>" /> 
              <h1>Marquee Images Upload</h1> 
              <p><b>Select Image</b></p>    
              <input type="file" name="image" id="m-img" multiple requried accept="image/*"/>
              <br>
              <br>   
              <input type="submit" name="sbt" class="btn btn-primary" value="Upload"/>
              </form>
            </div>
            
                  
            <div>
            
            <h1>Marquee Gallery</h1>  
              <div class="row" id="image" > <br><% if(session.getAttribute("marquee_id")!=null){ %>
       
      <%for (Gallery g : marqueeBean.getGalleries()){ 
        if(g.getImage()!=null){ %>  
       <div class="containers-img" style="display : inline-block;">  
          <img alt="" src="${pageContext.request.contextPath}/img/<%=g.getImage()%>" class="image" style="border: 2px solid #ec8d3b; width:350px; height:350px; " />    
              <div class="middle-img">     
            <div class="text-icon"><img src= "../backend/img/delete64.png" onclick="img_delete('<%=g.getId()%>' , '<%=g.getImage()%>');" style="cursor: pointer;" /></div> 
        </div> 
        </div>
      <% } } }%>
           </div>  
              </div>
              
              
             
              
              
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
<script type="text/javascript">
 
$('#formID-gallery').on('submit' , function(e){
  e.preventDefault();
    var data =  new FormData(this);
    if($('#m-img').val() != ""){
  $.ajax({
    type : 'post',
    url : '../GalleryServlet' ,
    data : data,
    cache : false,
        processData : false,
        contentType :  false,
        
    success : function(data){
        //$('#image').html(data);   
        location.reload();
      },
      error : function (data){
          alert('error in add');
        }
      
      })
    }
    else {
          alert("Please Select Image First");  
        } 
})

</script>
<script type="text/javascript">

function closeAlert(){
setTimeout(
		
		  function() 
		  {
			  $("#dataUpdated").css("display" , "none");
		  }, 3000) } 
		  
  function marqueeUpdate(){
      $.ajax({
          url : '../Marquee' ,
          data : $('#marqueeDetail').serialize() ,
          type : 'post' ,

          success : function (data){ 
              var obj = JSON.parse(data);
              for (b in obj) {      
            	  $("#dataUpdated").css("display" , "block"); 	  	
            	  closeAlert();	
                  $('#name').val(""+obj[b].name);
                  $('#email').val(""+obj[b].email);
                  $('#capacity').val(""+obj[b].capacity);
                  $('#address').val(obj[b].address);
                  $('#contact').val(obj[b].contact); 
                }
            } ,

          error : function (){
              alert("Error in marquee update");
            }
        })
      return false;  
    }

 
  function portionDetail(){

      $.ajax({
          url : '../Portion' ,
          data : $('#portionID').serialize() ,
          type : 'post' ,

          success  :function (data){   
              var obj = JSON.parse(data);
               for(b in obj){ 
            	   $("#dataUpdated").css("display" , "block");
            	   closeAlert();
            	      var capacityID = obj[b].capacityID;
	                  var nameID = obj[b].nameID;
    	              $('#'+nameID).val(obj[b].name);
        	          $('#'+capacityID).val(obj[b].capcity);     
                }    
            },
          error : function (){
              alert('error in portion details');
            }
        })
  
      return false;
    }


  function img_delete(imgID , imgName){ 
  var r=confirm("Are You Sure to Delete Image");
  if(r==true){
    $.ajax({  
          url : '../GalleryServlet' ,
          data : 'method=delete&id='+imgID+'&imgName='+imgName,
          type : 'post' ,

          success : function(data){
          //    $('#image').html(data);
              location.reload();
            },
        error : function(){
            alert("error in delte img method");
          } 
        })
  } 
}    
  
</script>

</body>
</html> 