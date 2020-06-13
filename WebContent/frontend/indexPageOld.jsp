<%@page import="java.util.ArrayList"%>
<%@page import="com.easybooking.model.Gallery"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.easybooking.daoImp.CityDaoImp"%>
<%@page import="com.easybooking.dao.CityDao"%>
<%@page import="com.easybooking.model.City"%>
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

</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function (){ 

	var options="<option value=''>Select Area</option>";    
	$('#areaCity').append(options); 

	bootbox.confirm("Are you sure?", function(result) {
		  Example.show("Confirm result: "+result);
		}); 	

			})
			
function town(){
	  
	var city_id = $('#city').val();   
	if(city_id > 0 ){
	$.ajax({
			url : '../AreaServlet',
			data : 'method=getAreaById&city_id='+city_id,
			type : 'post', 
			success : function (msg){  
				var obj = JSON.parse(msg); 
				$('#areaCity').empty();
				var options="<option value=''>Select Area</option>";    
				$('#areaCity').append(options); 
					for(b in obj){ 
						var cels = "<option value="+obj[b].id+">"+obj[b].name+"</option>";
						$('#areaCity').append(cels);    
						}   		
				},   
			error : function(){
					alert("error in town method");
				}
		})  
	}  
}

	function find(){

		var cityID = $('#city').val();
		var areaID = $('#areaCity').val();
		$('#result').css("display" , "block"); 
		if(cityID > 0 && areaID > 0){
				$.ajax({ 
						url : '../Marquee',
 						data : 'method=findMarquee&cityID='+cityID+"&areaID="+areaID,
						type : 'post',

						success : function (msg){  
							if(msg==""){ 
								$('#searched').html("<p style='color:#ec8d3b; font-weight:bold;'>In this City and Area Hall is Not Available</p>");
								}
								else {
							 		$('#searched').html(msg);
								}
							},
						error : function (){
								alert("error in find method");
							}
					})
			}
	}
</script>
<%
	MarqueeDao dao = new MarqueeDaoImp();
if(session.getAttribute("id")!=null){   
	Integer sessionID = Integer.parseInt(""+session.getAttribute("id"));	
	
	Marquee marqueeBean = new Marquee();
	MarqueeDao marqueeDao = new MarqueeDaoImp();
	ArrayList<Marquee> list = marqueeDao.getDataByUserId(sessionID);
	if(list.size() > 0){ 
	String marquee_id = ""+list.get(0).getId();
	session.setAttribute("marquee_id", marquee_id);
	session.setAttribute("hall-name", list.get(0).getName());
	}
}
 
%>
<body>
		
	<header id="header" style="background: rgba(6, 12, 34, 1);">
			<div class="container">
				<div id="logo" class="pull-letf">
					<a href="#intro" class="scrollto"><img src="images/logo.png" alt="" title=""></a>  
				</div>
				<nav id="nav-menu-container">
        	<ul class="nav-menu">
          	<li class="menu-active"><a href="#intro">Home</a></li>
          	<li><a href="#about">About Us</a></li>
          	<li><a href="#speakers">Our Services</a></li>
          	<li><a href="#hall">Wedding Halls</a></li> 
          	<%if(session.getAttribute("marquee_id")==null){ %>
          	<li><a href="marquee-register.jsp">Become Partner</a></li> 
          	<% }if(session.getAttribute("userName")==null){ %>
          	<li ><a href="login.jsp">Login</a></li> 
          	<%} else  { %>  
          	<li><a href="../UserServletF?session=logout">Logout</a></li>
          	<li id="" ><a href="../hall-admin/index.jsp">Dashboard</a></li>   	
          	<%} %>   
        </ul>
      </nav>
			</div>

		</header>

		<section id="intro">
    <div class="intro-container wow fadeIn">
      		<h1 class="mb-4 pb-0">WELCOME TO EASYBOOKING</h1>
      		<h5 class="mb-4 pb-0">FIND THE BEST WEDDING HALL FOR YOUR BIG DAY</h5>
      		<h3 class="mb-4 pb-0">FOR BOOKING</h3>

      		<div class="container">
      			<div class="row">
      				<div class="col-lg-7 combo">

      					<div class="container">
      							<div class="row">
								
      								<div class="col-md-3 slct"> 
      									<select name="city" id="city" onchange="town();" >
      									<option value="">Select City</option>
      										<% CityDao cityDao = new CityDaoImp(); for (City c : cityDao.getCities()){ %>
      											<option value="<%=c.getId()%>"><%=c.getName() %></option>  
      										<%} %>
        								</select>
      								</div>

      								<div class="col-md-3 slct">
      									<select name="area" id="areaCity" ></select>
      								</div>

      								<div class="col-md-3 slct">
      									<select>
      										<option>Capacity</option>
      										<option>100-200</option>
      										<option>200-300</option>
      										<option>400-500</option>
        								</select>
      								</div>  

      							</div>
      						</div> 
      					<a href="#result" id="find"><input type="submit" value="FIND"  onclick="find();"></a>

      				</div>
      			</div>
      		</div>

      		
    </div>
  </section>

  	<main id="main">

  			<section id="about">
      <div class="container">
        <div class="row">
          <div class="col-lg-6">
            <h2>About The Event</h2>
            <p>Sed nam ut dolor qui repellendus iusto odit. Possimus inventore eveniet accusamus error amet eius aut
              accusantium et. Non odit consequatur repudiandae sequi ea odio molestiae. Enim possimus sunt inventore in
              est ut optio sequi unde.</p>
          </div>
          <div class="col-lg-3">
            <h3>Where</h3>
            <p>Downtown Conference Center, New York</p>
          </div>
          <div class="col-lg-3">
            <h3>When</h3>
            <p>Monday to Wednesday<br>10-12 December</p>
          </div>
        </div>
      </div>
    </section>

    <section id="speakers" class="wow fadeInUp">
    	<div class="container">
    		<div class="section-header">
          <h2>Our Services</h2>
          <p>Here are some of our Services</p>
        </div>

        <div class="row">
        	<div class="col-lg-4 col-md-6">
            <div class="speaker">
              <img src="images/ser1.jpg" alt="Speaker 1" class="img-fluid">
              <div class="details">
                <h3><a href="#">Event Planer</a></h3>
                <p>Provide Best Ideas</p>
                
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6">
            <div class="speaker">
              <img src="images/ser2.jpg" alt="Speaker 1" class="img-fluid">
              <div class="details">
                <h3><a href="#">Hall Decorators</a></h3>
                <p>Provide Best Decortion</p>
                
              </div>
            </div>
          </div>

          <div class="col-lg-4 col-md-6">
            <div class="speaker">
              <img src="images/ser3.jpg" alt="Speaker 1" class="img-fluid">
              <div class="details">
                <h3><a href="#">Entry Setup</a></h3>
                <p>Provide Best Entry Setup</p>
                
              </div>
            </div>
          </div>
        	
        </div>
    		
    	</div>

    </section>
    
    <section id="result" style="display : none;" class="wow fadeInUp">
    	<div class="container">
    		<div class="hall-h2">
    			<h2>Searched Hall</h2>
    			
    		</div>

    		<div class="row"  id="searched" > </div>
		
		</div>
    	
    </section>

    <section id="hall" class="wow fadeInUp">
    	<div class="container">
    		<div class="hall-h2">
    			<h2>Wedding Hall</h2>
    			
    		</div>

    		<div class="row">
			<%	
				SimpleDateFormat sdf = new SimpleDateFormat("dmyyHHmmssz");
				Date date = new Date();
			for(Marquee m : dao.getMarqueeData()){  String img=""; for(Gallery g : m.getGalleries()){if(g.getImage()!=null){img=g.getImage();break;}}
			  
				String d = sdf.format(date);
				%>		
    			<div class="col-lg-4 col-md-6 hall-box-center" >
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
		
	
    			<div class="hall-view col-md-3"> 

    				<a href="wedding-hall.jsp">VIEW ALL<i class="fa fa-arrow-right"></i></a>
    				
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
  <script src="contactform/contactform.js"></script>

  <!-- Template Main Javascript File -->
  <script src="js/main.js"></script>
</body>
</html>