<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Easy Booking</title>
	<meta charset="utf-8" />
 	<meta name="google-signin-client_id" content="1043954037591-boe3s3msls4s0komoenoboc4nnkk6ac9.apps.googleusercontent.com">
	<link href="images/Favicon.png" rel="icon">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,700,700i|Raleway:300,400,500,700,800" rel="stylesheet">
	<link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="lib/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  	<link href="lib/animate/animate.min.css" rel="stylesheet">
  	<link href="lib/venobox/venobox.css" rel="stylesheet">
  	<link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="stylesheet.css" />
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script type="text/javascript">
		 function login(){ 
			if($('#email').val() == "" && $('#password').val() == "" ){
					//alert("Pleace Input Username and Password");
				} 
			else {
			$.ajax({
				url : '../UserServletF' , 
				data : $("#formID").serialize(),     
				type : 'post' , 

				success : function(msg){   
						if(msg == "index.jsp"){ 
								window.location.href="../hall-admin/"+msg;
							}
						else{
								alert(msg);
								$('#form').each(function() { this.reset() });	
							}
					},
				error : function(msg){
						alert(msg+" error in add ");
						}		
					}) 
				}  
			return false;
			}
		
	function submitdata()
	{ 
		$.ajax({
			url : '../UserServletF' ,
			data : $("#formID_sign").serialize(),
			type : 'post',  
			success : function(msg){
					alert(msg);
					$('#name').val('');
					$('#email_signup').val('');
					$('#password1').val('');
					$('#password2').val(''); 
					$('#contact').val('');
				},
				error : function (){
					alert('error in add');
					} 
		})				 
		
		return false;
	}   

	function checkEmail(){  
			var email = $('#email_signup').val();  
			var chk = email.lastIndexOf(".com");  
			if(chk > 0){  
					$.ajax({
							url : '../UserServletF',
							data : "method=checkEmail&email="+email,
							type : 'post',
							success : function(msg){
									if(msg == "used"){
										$('#email_text').text("This Email is Already Used"); 
										$('#sign').attr("disabled" , true);
									}
									else {
										$('#email_text').hide();    
										$('#sign').attr("disabled" , false);	
										}
								},
							error : function(){
									alert("error in check email");
								}
						})  	
				}    
		}
	
	function matchPassword(){
			var password = $('#password1').val();
			var confirmPassword = $('#password2').val();
			var length1 = password.length;
			var length2 = confirmPassword.length;
			if(password !== "" && confirmPassword !== ""){  	
			if(length1 <= length2){
					if(password == confirmPassword){
							$('#password_match').text("Password Match"); 
							$("#password_match").css("color","#048104");   
							$('#sign').attr("disabled" , false); 
						}	
					else{
							$('#password_match').text("Password Does'nt Match");  
							$('#sign').attr("disabled" , true);
						}
				}
			}
		}
	var check = 4;	
</script>

</head> 
<%
	String email = "",password="";
	
%>  
<body>
 	<jsp:include page="include/header.jsp"></jsp:include> 
  	<main id="main">

    <section id="hall" class="wow  fadeInUp" style="margin-top: 100px; ">
    	<div class="container">
    		<div class="hall-h2">
    			<h2>Login / Sign Up</h2>
    			
    		</div>

    		<div class="row">

          <div class="col-lg-8 hall-subs">

            <div class="container">

              <div class="row">
                <div class="col-md-6 login-f">

    <form id="formID" onsubmit="return login();"> 
        <input type="hidden" name="Login" value="SubmitData">
                  <h3>Login</h3>
				
                  <input type="email" name="email" placeholder="Email" required id="email" value="<%=email%>" />
                  <input type="password" name="password" placeholder="Password" required id="password" value="<%=password%>" />

                  <input type="submit" id="btn" value="Login" />       

                  <div class="apis">

                    <h5>Or Login With</h5>
                    
 
                  
                    
                     </form>
                   <center>   <div class="g-signin2" data-onsuccess="onSignIn" id="myP"></div>
	      <img id="myImg"><br>
   		   <p id="name"></p>
   	   		<div id="status">
   			</div></center>
                  </div>
                 
                </div>

				

                  <div class="col-md-6 subs-f">
				<form id="formID_sign" onsubmit="return submitdata();">  
				<h3>Sign Up</h3>
				  <input type="hidden" name="signup" value="sign up">	
				  <input type="text" name="name" id="name" placeholder="Full Name" required="required" />
				  <span id="email_text" style="color : red;"></span>  
                  <input type="email" name="email"  id="email_signup" placeholder="Email" required="required" onkeyup="checkEmail();" /> 
                  <input type="password" name="password" placeholder="Password" id="password1" required="required" minlength="6" />	
                  <span style="top:377px; color : red;" id="password_match" ></span>  
                  <input type="password" name="" placeholder="Confirm Password" id="password2" required="required" minlength="6" onkeyup="matchPassword();" />
 				  <input type="number" name="contact" placeholder="Contact "  value="03" pattern="[0-9]{11}" id="contact" required="required" />	
                  
                  <input type="submit" id="sign" value="Sign Up">

                   <div class="apis"> 

                    <h5></h5>
                    

                  
    
                    
                  </div>
                  </form>
                </div>



              </div>
              
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

<!--   	
  <script src="lib/jquery/jquery.min.js"></script> -->       
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
  <script type="text/javascript">
      function onSignIn(googleUser) {
      // window.location.href='success.jsp';
      var profile = googleUser.getBasicProfile();
      //var imagurl=profile.getImageUrl();
      var name=profile.getName();
      var email=profile.getEmail();

      $.ajax({
			url : '../',
			data : '',
			type : 'post',

			success : function(msg){
					alert(msg);
				},
			error : function(){
					alert('error in google api');
				}
          })
      
//      document.getElementById("myImg").src = imagurl;                    
   }
   </script>
  <script type="text/javascript">
  
	function signUpGoogle(){
			gapi.auth2.getAuthInstance().disconnect();
			location.reload();
		} 
  </script>
</body>
