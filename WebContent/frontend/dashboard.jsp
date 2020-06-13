<%@page import="com.easybooking.daoImp.BookingRequestDaoImp"%>
<%@page import="com.easybooking.dao.BookingRequestDao"%>
<%@page import="com.easybooking.model.BookingRequest"%>
<%@page import="com.easybooking.model.User"%>
<%@page import="com.easybooking.daoImp.UserDaoImp"%>
<%@page import="com.easybooking.dao.UserDao"%>
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
  <link type="text/css" rel="stylesheet" href="css/bootstrap.css" />
	<link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  	<link href="lib/animate/animate.min.css" rel="stylesheet">
  	<link href="lib/venobox/venobox.css" rel="stylesheet">
  	<link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="stylesheet.css" />
  
  <link rel="stylesheet" type="text/css" href="css/dataTables.bootstrap4.css">
  
  
  <style type="text/css" class="init">
  
  </style>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 <script type="text/javascript">
 var check=5;
	function updateContact(){
		var contact = $('#contact').val();
		var id = $('#id').val();
		$.ajax({  
				url : '../UserServletF',   
				data : 'method=updateContact&contact='+contact+'&id='+id,
				type : 'post', 

				success : function(msg){
						alert("Contact Updated");
						$('#setContact').text(msg);
						$('.transform').toggleClass('transform-active'); 
					},
					error : function(){
						alert("error in contact btn");
						}
			})
	} 
	function changePassword(){
			var current = $('#current').val();
			var newPassword = $('#new').val();
			var confimPassword = $('#confirm').val();
			var id = $('#id').val(); 
			if(newPassword == confimPassword){
					$.ajax({
							url : '../UserServletF', 
							data : 'method=updatePassword&currentPassword='+current+'&newPassword='+newPassword+'&id='+id,
							type : 'post',

							success : function(msg){
									alert(msg); 
									$('.transform2').toggleClass('transform2-active');
								},
							error : function(){
									alert("error in password change method");
								},
						})
				}
			else{
					alert("password does'nt match");
				}
		}
 </script>

</head>
<%
	UserDao  userDao = new UserDaoImp();
	User userBean = new User();

	if(session.getAttribute("id")!=null){
		userBean = userDao.getDataById(Integer.parseInt(""+session.getAttribute("id")));
	}
	else{
		response.sendRedirect("login.jsp");
	}
%>
<body>

<jsp:include page="include/header.jsp"></jsp:include>

  	<main id="main">

  			
      <section id="userdashboard" class="wow fadeInUp" style="margin-top: 110px;">

        <div class="section-header">
          <h2>Dashboard</h2>
          <p></p>
        </div>
          <div class="container">
          <div class="row">

            <div class="col-md-4 usebox1">

              <div class="usenam">
              <p>Bilal Sheikh</p>
              
            </div>
            
            <div class="usedet">
              <h6>Email :<span><%=userBean.getEmail()%></span></h6>
              <h6>Join Since :<span><%=userBean.getCreated_at()%></span></h6>
              
              <div class="editcontact">
              <h6>Contact :<span id="setContact"><%=userBean.getContact()%></span></h6>
             <input type="hidden" id="id" value="<%=userBean.getId()%>"/>
              
              <input type="button" class="editbtn" id="button" value="Edit"></input>
                           
              <div class="box transform">
                <input type="text" id="contact" placeholder="Enter New Number">
                            
              <button class="savebtn" onclick="updateContact();"> Update </button>
              </div>


             
              
            </div>

             <input type="button" class="editbtn2" id="button2" value="Change Password"></input>
              <div class="changepass box2 transform2">
                
               
                <input type="Password" id="current" placeholder="Current Password">
                <input type="Password" id="new" placeholder="New Password">
                <input type="Password" id="confirm" placeholder="Confirm Password"> 
                <button class="savebtn2" onclick="changePassword();">Save</button> 
              </div>
              
            </div>

          </div>

          <div class="col-md-8 usebox2">

            <div class="delimiter">
              <span class="delh1">Your Booking</span>

              
            </div>
            <!--Data Table-->
            <table id="example" style="color:#0e1b4d; " class="table table-striped table-bordered" style="width:100%">
        <thead>
          <tr>
            <th>Serial</th>
            <th>Hall Name</th>
            <th>Date</th>
            <th>Shift</th>
            <th>Cost</th>
            <th>Contact</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <%
          int serialNo=0;
          BookingRequestDao bookingRequestDao = new BookingRequestDaoImp();
          if(session.getAttribute("id")!=null){
          for(BookingRequest r: bookingRequestDao.getBookingByUser(Integer.parseInt(""+session.getAttribute("id")))){ 
          serialNo++;
          %>
          <tr>
            <td><%=serialNo%></td>
            <td><%=r.getMarquee().getName()%></td>
            <td><%=r.getBookedDate()%></td>
            <td><%=r.getShift()%></td>
            <td><%=r.getCost()%></td>
            <td><%=r.getContact()%></td>
            <%if(r.getActive() == 0){ %>
            <td>Approved</td> 
            <%} else if(r.getActive() == 1){ %>
            <td>Pending</td>  
            <%} else if (r.getActive() == 3){ %>
            <td>Rejected</td>
            <%} else if(r.getActive() == 4){ %>
            <td>Cancel</td>
          </tr> 
          <%}} }%>
          
        </tbody>
        <tfoot>
          <tr>
            <th>Serial</th>
            <th>Hall Name</th>
            <th>Date</th>
            <th>Shift</th>
            <th>Cost</th>
            <th>Contact</th>
            <th>Status</th>
          </tr>
        </tfoot>
      </table>
            
               

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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
  $("#button").click(function() {
  $('.transform').toggleClass('transform-active');
});
  $("#button2").click(function() {
  $('.transform2').toggleClass('transform2-active');
});
</script>


	<script src="lib/bootstrap/js/bootstrap.min.js"></script>
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

 
  <script type="text/javascript" language="javascript" src="js/jquery.dataTables.js"></script>
  <script type="text/javascript" language="javascript" src="js/dataTables.bootstrap4.js"></script>
  <script type="text/javascript" language="javascript" class="init">
  
$(document).ready(function() {
  $('#example').DataTable();
} );

  </script>


  
   
</body>
</html>