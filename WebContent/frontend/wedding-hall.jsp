<%@page import="com.easybooking.model.City"%>
<%@page import="com.easybooking.daoImp.CityDaoImp"%>
<%@page import="com.easybooking.dao.CityDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.easybooking.model.Gallery"%>
<%@page import="java.util.Set"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Easy Booking</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-state=1" />
	<link href="images/Favicon.png" rel="icon">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800" rel="stylesheet">
	<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  	<link href="lib/animate/animate.min.css" rel="stylesheet">
  	<link href="lib/venobox/venobox.css" rel="stylesheet">
  	<link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="stylesheet.css" />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
	function city(){
		var cityID = $('#cityID').val();   
		if(cityID > 0 ){  
		$.ajax({
			url : '../Marquee',
			data : 'method=searchCity&cityID='+cityID,
			type : 'post',

			success : function (msg){ 
				   if(msg==""){  
					   	$('#hallData').html("<p style='color:#ec8d3b; font-weight:bold;'>In this City Hall is Not Available</p>");
					   }
				   else{
					   $('#hallData').html(msg); 
					   }			
				},
				error : function (){
						alert("error in city method");
					}
			})
		} 		 	 
	} 
	
</script>
 
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	var check = 2;
</script>

<body> 
<jsp:include page="include/header.jsp"></jsp:include>

  	<main id="main">
    <section id="hall" class="wow fadeInUp" style="margin-top: 110px; ">
    	<div class="container">	 
    		<div class="hall-h2">
    			<h2>Wedding Hall</h2>
    			
     			<center>
     			<div class="hall-combo">
    			<select name="cityID" requried="requried" id="cityID" onchange="city();"> 
    			<option value="">Select City</option>
    			<%CityDao cityDao = new CityDaoImp();
    				for(City c : cityDao.getCities()){
    			%> 
    				<option value="<%=c.getId()%>"><%=c.getName()%></option>
    				<%} %>
    			</select>
    			</div>
    			</center>
    			 
    		</div>
    		<div class="row" id="hallData">
			<%  MarqueeDao marqueeDao  = new MarqueeDaoImp();
			SimpleDateFormat sdf = new SimpleDateFormat("dmyyHHmmssz");
			Date date = new Date();  
			for(Marquee m : marqueeDao.getMarqueeData()  ){ 
				String img=""; 
				for(Gallery g : m.getGalleries()){if(g.getImage()!=null){img=g.getImage();break;}}
			
			String d = sdf.format(date);
			%>
    			<div class="col-lg-4 col-md-6">
    				<div class="hall-img">
    					<img src="${pageContext.request.contextPath}/img/<%=img%>" width="100%" height="235px" />         
    					<div class="cost">     
    						<h6>Capacity : <%=m.getCapacity()%></h6>    	 					
    					</div>
    					    					<div class="city">
    						<h6>City : <%=m.getCity().getName()%></h6>
    						   
    					</div> 
    					
    					<div class="hall-n">
    						<h3><%=m.getName() %></h3>
    					</div>
    					<a href="hall-detail.jsp?id=<%=m.getId()%>Mb<%=d.replaceAll("\\s", "")%>Fw34QVe" ><input type="submit" value="Check Availability" /></a>
    				</div>
    				
    			</div>
    		  	     <% } %>       
          </div>

                      
          </div>

    			
    		</div>

    		
    	</div>
    	
    </section>
  		
  	</main>
  	
  	<footer id="footer">
  		<div class="footer-top">
  			<div class="container">
  				<div class="row">
  					<div class="col-lg-3 col-md-6 footer-info">
           			 <img src="images/logo.png" alt="TheEvenet" class="img-fluid">
            		<p>Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.</p>
          			</div>

          			<div class="col-lg-3 col-md-6 footer-links">
            <h4>Useful Links</h4>
            <ul>
              <li><i class="fa fa-angle-right"></i> <a href="#">Home</a></li>
              <li><i class="fa fa-angle-right"></i> <a href="#">About us</a></li>
              <li><i class="fa fa-angle-right"></i> <a href="#">Services</a></li>
              <li><i class="fa fa-angle-right"></i> <a href="#">Terms of service</a></li>
              <li><i class="fa fa-angle-right"></i> <a href="#">Privacy policy</a></li>
            </ul>
          </div>

          <div class="col-lg-3 col-md-6 sub-links">
            <h4>NEWSLETTER</h4>
            <label>Enter Your Email Address</label>
            <input type="text" name="">
            <input type="submit" value="Subscribe">
          </div>

          <div class="col-lg-3 col-md-6 footer-contact">
            <h4>Contact Us</h4>
            <p>
              A108 Adam Street <br>
              New York, NY 535022<br>
              United States <br>
              <strong>Phone:</strong> +1 5589 55488 55<br>
              <strong>Email:</strong> info@example.com<br>
            </p>

            <div class="social-links">
              <a href="#" class="twitter"><i class="fa fa-twitter"></i></a>
              <a href="#" class="facebook"><i class="fa fa-facebook"></i></a>
              <a href="#" class="instagram"><i class="fa fa-instagram"></i></a>
              <a href="#" class="google-plus"><i class="fa fa-google-plus"></i></a>
              <a href="#" class="linkedin"><i class="fa fa-linkedin"></i></a>
            </div>

          </div>
  					
  				
  				</div>
  				
  			</div>
  			
  		</div>
  		<div class="container">
      <div class="copyright">
        &copy; Copyright <strong>Easybooking</strong>. All Rights Reserved
      </div>
      </div>
  	</footer>

  

		<a href="#" class="back-to-top"><i class="fa fa-angle-up"></i></a>




	
  <script src="lib/jquery/jquery.min.js"></script>
  <script src="lib/jquery/jquery-migrate.min.js"></script>
  <script src="lib/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="lib/easing/easing.min.js"></script>
  <script src="lib/superfish/hoverIntent.js"></script>
  <script src="lib/superfish/superfish.min.js"></script>
  <script src="lib/wow/wow.min.js"></script>
  <script src="lib/venobox/venobox.min.js"></script>
  <script src="lib/owlcarousel/owl.carousel.min.js"></script>
  
  <!-- Contact Form JavaScript File -->
   

  <!-- Template Main Javascript File -->
  <script src="js/main.js"></script>
</body>
</html>