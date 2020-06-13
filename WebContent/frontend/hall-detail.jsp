<%@page import="com.easybooking.model.Portion"%>
<%@page import="com.easybooking.model.User"%>
<%@page import="com.easybooking.daoImp.UserDaoImp"%>
<%@page import="com.easybooking.dao.UserDao"%>
<%@page import="com.easybooking.model.MarqueeFoodService"%>
<%@page import="com.easybooking.model.Gallery"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
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
<%

	Marquee marqueeBean = new Marquee();
	MarqueeDao marqueeDao = new MarqueeDaoImp();
	String img=""; 
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
	for(Gallery g : marqueeBean.getGalleries()){
		if(g.getImage()!=null){
			img  = g.getImage();
			break;
		}
	}
	
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

  	<main id="main">

  			
      <section id="gallery" class="wow fadeInUp" style="margin-top: 110px;">

          <div class="container">

              <div class="section-header">
          <h2><%=marqueeBean.getName() %></h2>
        </div>
     
            
          

          <div class="row gal-det">

            <div class="col-lg-7 gal-img">
 
               <img src="${pageContext.request.contextPath}/img/<%=img%>" style=" width : 580px ;height : 420px"  />  
              
            </div>

            <div class="col-lg-5 book-det">

			  <form id="getData" onsubmit="return checkAvailbility();" >
			     
			  <input type="hidden" name="marqueeID" value="<%=marqueeBean.getId()%>" />
              
              <input type="Email" name="email" placeholder="Email" value="<%=email%>" required="required"> 
              <input type="text" name="contact" placeholder="Mobile" value="<%=contact%>" required="required">
              <input type="text" name="name" placeholder="Event Name" required="required"> 
              <select name="shift" placeholder="Lunch/Dinner/Any" required="required" >
              <option value="">Chooise Shift</option>
              <option value="Day">Lunch</option>  
              <option value="Night">Dinner</option> 
              </select>
              <input type="hidden" name="check" value="availability" />
              <input type="number" name="capacity" placeholder="Capacity" id="capacity" required="required">
              <input type="date" name="date" placeholder="Event Date">
              
              <%if(marqueeBean.getPortions()!=null){ %>
              <input type="hidden" value="<%=marqueeBean.getPortions().size()%>" name="portionRange">
              <% byte id = 0;for(Portion p : marqueeBean.getPortions()){%>        
              <input type="hidden" value="<%=p.getId()%>" name="portion<%=id%>">
              <div><input type="checkbox" name="portionID<%=id%>" value="<%=p.getId()%>" > <span><%=p.getName()%></span> <span>Capacity : <%=p.getPortionCapacity()%></span></div>
			<% id++;  } }  
              if(session.getAttribute("id")!=null){ %> 
              	<button type="submit" id="data" data-toggle="modal" style="background-color: #ec8d3b;margin-top:28px;color:white;border-radius: 0px;border:0px;height:55px;font-weight: bold; cursor: pointer;">Book Now<span style="margin-left:20px; "><img src="https://mybookpk.s3.amazonaws.com/assets/images/new/goarrow.png"></span></button>  
             <%} else{ %>    
             <	a href="login.jsp"><button type="button" id="data" data-toggle="modal" style="background-color: #ec8d3b;margin-top:28px;color:white;border-radius: 0px;border:0px;height:55px;font-weight: bold; cursor: pointer;">Book Now<span style="margin-left:20px; "><img src="https://mybookpk.s3.amazonaws.com/assets/images/new/goarrow.png"></span></button></a>	
             <%} %>

</form> 
<!-- Modal pop up  -->



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

            </div>
            
           

          </div>
          
          
          
          <div class="section-header">
          
          <p>Marquee Gallery</p>
        </div>
        <div class="owl-carousel gallery-carousel">    
        <% if(marqueeBean.getGalleries()!=null){ for(Gallery g : marqueeBean.getGalleries()){ if(g.getImage()!=null){ %>
        	<a href="${pageContext.request.contextPath}/img/<%=g.getImage()%>" class="venobox" data-gall="gallery-carousel"><img src="${pageContext.request.contextPath}/img/<%=g.getImage()%>" width="300px" height="230px"/></a>     		
        <%/* img string use for call the img in single img */ } }}%>
         </div>
         </div>

      </section>
	
	
	

      <section id="options">
    		<div class="container">
    	   <div class="row">


            <div class="col-md-6 further">

              <h3>Hall Detail</h3>
 
              <div>
                <% if(marqueeBean.getMarqueeFoodServices()!=null && marqueeBean.getArea()!=null && marqueeBean.getCity()!=null){ %>
                <h6>Name :</h6><p><%=marqueeBean.getName()%></p>
                <h6>Email :</h6><p><%=marqueeBean.getEmail()%></p>
                <h6>Contact :</h6><p><%=marqueeBean.getContact()%></p>
                <h6>Capacity :</h6><p><%=marqueeBean.getCapacity() %></p>
                <h6>Address :</h6><p><%=marqueeBean.getAddress()%></p>
                <h6>Area :</h6><p><%=marqueeBean.getArea().getName()%></p>
                <h6 >City :</h6><p><%=marqueeBean.getCity().getName()%></p> 
              <% }%>
              </div>

 
              
            </div>
            <div class="col-md-6 further">

              <h3>Portion Detail</h3>

              <div>
              
               <%byte i = 0; if(marqueeBean.getPortions()!=null){ 
            	   for(Portion p : marqueeBean.getPortions()){
            	   i++;
              %>       
                <h6>Portion <%=i%> :</h6><p><%=p.getName()%></p>      
                <h6>Capacity :</h6><p><%=p.getPortionCapacity()%></p> 
                <%} }%>
              
              </div>


              
            </div>
            
          </div>  
          </div>     
    
        <div class="container">

          <h2>Available Services</h2>

          <div class="row">

            <div class="col-md-6">

              <ul>  
              <% if(marqueeBean.getMarqueeFoodServices()!=null){ for(MarqueeFoodService service : marqueeBean.getMarqueeFoodServices()){ %>
                <li>
                  <div class="row">
                  <div class="col-md-6"><%=service.getFoodServices().getName()%></div> 
                  <div class="col-md-5 conf-serv"><img src='../backend/img/checked.png' /> </div>
                  </div>
                </li>
                <% }} %>              
                </ul>
              
            </div>
            <div class="col-md-6">

              
              
              
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
   
  </script>
  <!-- Contact Form JavaScript File -->

  <!-- Template Main Javascript File -->
  <script src="js/main.js"></script>
</body>
</html>