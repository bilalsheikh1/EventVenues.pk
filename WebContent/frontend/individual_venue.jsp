<%@page import="com.easybooking.model.Portion"%>
<%@page import="com.easybooking.daoImp.UserDaoImp"%>
<%@page import="com.easybooking.dao.UserDao"%>
<%@page import="com.easybooking.model.User"%>
<%@page import="com.easybooking.model.Gallery"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>Vacation Rental - Free Bootstrap 4 Template by Colorlib</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,400i,500,500i,600,600i,700,700i&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 
    <link rel="stylesheet" href="css/animate.css">
    
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">

    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">

    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/air-slider.min.css">
  </head>
  <%
	
  
	Marquee marqueeBean = new Marquee();
	MarqueeDao marqueeDao = new MarqueeDaoImp(); 
if(request.getParameter("id")!=null){	
	
	Integer id = null;
	String encrypt=request.getParameter("id");	
	String decrypt = "";
//	Integer id = null;
	for(int j = 0 ; j < encrypt.indexOf("M") ; j++){
		decrypt += encrypt.charAt(j);
	}
	   
	id = Integer.parseInt(decrypt);
	marqueeBean=marqueeDao.getDataById(id);
	
	
}
else {
	response.sendRedirect("index.jsp"); 
}
String name="" , contact="", email="";
if(session.getAttribute("id")!=null){
	String id = ""+session.getAttribute("id");
	User userBean = new User();
	UserDao userDao = new UserDaoImp(); 
	userBean = userDao.getDataById(Integer.parseInt(id));
	name=userBean.getName();
	email = userBean.getEmail();
	contact = userBean.getContact();
}
	

%> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script type="text/javascript">
var check = 2;   
<%
String ab="";  
	if(session.getAttribute("id")!=null){
		ab = ""+session.getAttribute("id");
	}
%>   

var session = <%=ab%>;
var sessionID = parseInt(session);
 
function checkAvailbility(){  
	if(sessionID > 0){
		var totalCapacity = <%=marqueeBean.getCapacity()%>;
		var  capacity = $('#capacity').val(); 
		if(capacity <= totalCapacity){   	
		$.ajax({   
				url : "../BookingServlet",    
				data : $("#getData").serialize(),    
				type : "post",
  
				success : function(msg){     
					if(msg == "Marquee already booked"){
		//					alert("Marquee already book on this day and shift please try another date and shift");
							$('#msg').text("Marquee already book on this day and shift please try another date and shift");
							$('#confirm').hide(); 
							$("#exampleModalCenter").modal();
							    
						 }   
					else if(msg == "marquee not book"){   
							$('#msg').text("Are You Sure To Confirm This Booking");
							$('#confirm').show();
							$("#exampleModalCenter").modal();    	
						} 
					else if(msg == "already requested"){
						$('#msg').text("Yor Request Already Farword to Hall Owner");   
						$('#confirm').hide();  
						$("#exampleModalCenter").modal();
						}
					else{
							var obj = JSON.parse(msg);
							var i=1;
							for(b in obj){ 
								if(i==1)  
 									$('#msg').html("<span>"+obj[b].portionName+" is Booked please select Another Portion</span> ");
								}   
							$('#confirm').hide();  
							$("#exampleModalCenter").modal();
						}        
					},
				error : function(){
						alert("Error in Booking method");
					} 
			})
		}
		else{
				alert("you have enter grather-then Hall Capacity");
			}
	}
	else {
		window.location.href="login.jsp";
	}
	return false;
}
	
	function booking(){
			if(sessionID > 0){	
				$.ajax({   
						url : "../BookingRequestServlet",   
						data : $("#getData").serialize(),    
						type : "post",
  
						success : function(msg){ 
								alert(msg);  
							},
						error : function(){
								alert("Error in Booking method");
							} 
					})
			}
			else {
					window.location.href="login.jsp";
				}
				return false;
		}
		 

</script>
  
  <body>
		 
	<jsp:include page="include/header.jsp"></jsp:include>	 		 
		 
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
          	<p class="breadcrumbs mb-2"><span class="mr-2"><a href="index.html">Home <i class="fa fa-chevron-right"></i></a></span> <span>Venues <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-0 bread"><%=marqueeBean.getName()%></h1>
          </div>
        </div>
      </div>
    </section>
   
    <section class="ftco-section bg-light">
    	<div class="row">
      

    </div>

    <div class="row" >
<div class="col-md-6" >
  <div class="air-slider">
	<% byte number = 0;	for(Gallery g : marqueeBean.getGalleries()){
		if(g.getImage()!=null){ number++;%> 
			<img src="${pageContext.request.contextPath}/img/<%=g.getImage()%>"  alt="slide<%=number%>"  />	
	<%	}
	 }   %>
		      
    </div>
</div>
<div class="col-md-6" >
      
      <form id="getData" onsubmit="return checkAvailbility();" >
		<input type="hidden" name="marqueeID" value="<%=marqueeBean.getId()%>" />
			  
      <div class="col-md-8">
         <label>Event Name</label>
         <input type="text" name="name" placeholder="Event Name" required="required" class="form-control">
      </div>
        <div class="col-md-8">
         <label>Mobile</label>
         <input type="text" name="contact" placeholder="Mobile" value="<%=contact%>" required class="form-control"> 
      </div>
      <div class="col-md-8">
         <label>Email</label>
         <input type="Email" name="email" placeholder="Email" value="<%=email%>" required class="form-control">
      </div>
      <div class="col-md-8">
        <label>Select Shift</label>
         <select name="shift" placeholder="Lunch/Dinner/Any" required="required" class="form-control">
            <option value="">Chooise Shift</option>
              <option value="Day">Lunch</option>  
              <option value="Night">Dinner</option>
         </select>
         <input type="hidden" name="check" value="availability" />
      </div>
      <div class="col-md-8">
         <label>No of Guest</label>
         <input type="number" name="capacity" placeholder="Capacity" id="capacity" required="required" class="form-control">
      </div>    
      <div class="col-md-8">
         <label>Book Date</label>
         <input type="date" name="date" placeholder="Event Date" class="form-control">
      </div>
      <div class="col-md-8">
      <%if(marqueeBean.getPortions()!=null){ %>
              <input type="hidden" value="<%=marqueeBean.getPortions().size()%>" name="portionRange">
              <% byte id = 0;for(Portion p : marqueeBean.getPortions()){%>        
              <input type="hidden" value="<%=p.getId()%>" name="portion<%=id%>">
              <div><input type="checkbox" name="portionID<%=id%>" value="<%=p.getId()%>" > <span><%=p.getName()%></span> <span>Capacity : <%=p.getPortionCapacity()%></span></div>
			<% id++;  } }  
              if(session.getAttribute("id")!=null){ %> 
              	<button type="submit" id="data" data-toggle="modal" style="background-color: #ec8d3b;margin-top:28px;color:white;border-radius: 0px;border:0px;height:55px;font-weight: bold; cursor: pointer;">Book Now<span style="margin-left:20px; "><img src="https://mybookpk.s3.amazonaws.com/assets/images/new/goarrow.png"></span></button>  
             <%} else{ %>    
             <a href="login.jsp"><button type="button" id="data" data-toggle="modal" style="background-color: #ec8d3b;margin-top:28px;color:white;border-radius: 0px;border:0px;height:55px;font-weight: bold; cursor: pointer;">Book Now<span style="margin-left:20px; "><img src="https://mybookpk.s3.amazonaws.com/assets/images/new/goarrow.png"></span></button></a>	
             <%} %>
        </div>
      </form>
</div>
</div>
    </section>
	
	<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Marquee Status</h5>
        
        
        
        
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        ...<h3>Hall Confirmation</h3>
      	<h4 style="color: #ec8d3b;" id="msg"></h4> 
      	  
      </div> 
      
      <div class="modal-footer"> 
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="confirm" data-dismiss="modal" style="background-color: #ec8d3b; border-color: #ec8d3b;" onclick="booking();">Confirm Booking</button>  
      </div>
    </div> 
  </div>
</div> 
	
	
    <section class="ftco-section bg-light ftco-no-pt">
			<div class="container">
				<div class="row no-gutters justify-content-center pb-5 mb-3">
          <div class="col-md-7 heading-section text-center ftco-animate">
            <h2>Venue Details</h2>
          </div>
        </div>
				<div class="row">
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-diet"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Tea Coffee</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div> 
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-workout"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Hot Showers</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div>
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-diet-1"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Laundry</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div>      
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-first"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Air Conditioning</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div>
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-first"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Free Wifi</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div> 
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-first"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Kitchen</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div> 
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-first"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Ironing</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div> 
          <div class="services-2 col-md-3 d-flex w-100 ftco-animate">
            <div class="icon d-flex justify-content-center align-items-center">
          		<span class="flaticon-first"></span>
            </div>
            <div class="media-body pl-3">
              <h3 class="heading">Lovkers</h3>
              <p>A small river named Duden flows by their place and supplies it with the necessary</p>
            </div>
          </div>
        </div>  
			</div>
		</section>
		
    <footer class="footer">
			<div class="container">
				<div class="row">
					<div class="col-md-6 col-lg-3 mb-md-0 mb-4">
						<h2 class="footer-heading"><a href="#" class="logo">Vacation Rental</a></h2>
						<p>A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
						<a href="#">Read more <span class="fa fa-chevron-right" style="font-size: 11px;"></span></a>
					</div>
					<div class="col-md-6 col-lg-3 mb-md-0 mb-4">
						<h2 class="footer-heading">Services</h2>
						<ul class="list-unstyled">
              <li><a href="#" class="py-1 d-block">Map Direction</a></li>
              <li><a href="#" class="py-1 d-block">Accomodation Services</a></li>
              <li><a href="#" class="py-1 d-block">Great Experience</a></li>
              <li><a href="#" class="py-1 d-block">Perfect central location</a></li>
            </ul>
					</div>
					<div class="col-md-6 col-lg-3 mb-md-0 mb-4">
						<h2 class="footer-heading">Tag cloud</h2>
						<div class="tagcloud">
	            <a href="#" class="tag-cloud-link">apartment</a>
	            <a href="#" class="tag-cloud-link">home</a>
	            <a href="#" class="tag-cloud-link">vacation</a>
	            <a href="#" class="tag-cloud-link">rental</a>
	            <a href="#" class="tag-cloud-link">rent</a>
	            <a href="#" class="tag-cloud-link">house</a>
	            <a href="#" class="tag-cloud-link">place</a>
	            <a href="#" class="tag-cloud-link">drinks</a>
	          </div>
					</div>
					<div class="col-md-6 col-lg-3 mb-md-0 mb-4">
						<h2 class="footer-heading">Subcribe</h2>
						<form action="#" class="subscribe-form">
              <div class="form-group d-flex">
                <input type="text" class="form-control rounded-left" placeholder="Enter email address">
                <button type="submit" class="form-control submit rounded-right"><span class="sr-only">Submit</span><i class="fa fa-paper-plane"></i></button>
              </div>
            </form>
            <h2 class="footer-heading mt-5">Follow us</h2>
            <ul class="ftco-footer-social p-0">
              <li class="ftco-animate"><a href="#" data-toggle="tooltip" data-placement="top" title="Twitter"><span class="fa fa-twitter"></span></a></li>
              <li class="ftco-animate"><a href="#" data-toggle="tooltip" data-placement="top" title="Facebook"><span class="fa fa-facebook"></span></a></li>
              <li class="ftco-animate"><a href="#" data-toggle="tooltip" data-placement="top" title="Instagram"><span class="fa fa-instagram"></span></a></li>
            </ul>
					</div>
				</div>
			</div>
			<div class="w-100 mt-5 border-top py-5">
				<div class="container">
					<div class="row">
	          <div class="col-md-6 col-lg-8">

	            <p class="copyright mb-0"><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
	  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib.com</a>
	  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
	          </div>
	          <div class="col-md-6 col-lg-4 text-md-right">
	          	<p class="mb-0 list-unstyled">
	          		<a class="mr-md-3" href="#">Terms</a>
	          		<a class="mr-md-3" href="#">Privacy</a>
	          		<a class="mr-md-3" href="#">Compliances</a>
	          	</p>
	          </div>
	        </div>
				</div>
			</div>
		</footer>
    
  <jsp:include page="include/footer.jsp"></jsp:include>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

  <script src="js/air-slider.min.js"></script>
		<script>
			var slider = new airSlider({
				autoPlay: true,
				width: '600px',
				height: '300px'
			});
		</script>


  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="js/popper.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/jquery.easing.1.3.js"></script>
  <script src="js/jquery.waypoints.min.js"></script>
  <script src="js/jquery.stellar.min.js"></script>
  <script src="js/jquery.animateNumber.min.js"></script>
  <script src="js/bootstrap-datepicker.js"></script>
  <script src="js/jquery.timepicker.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
  <script src="js/jquery.magnific-popup.min.js"></script>
  <script src="js/scrollax.min.js"></script>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
  <script src="js/google-map.js"></script>
  <script src="js/main.js"></script>

    
  </body>
</html>