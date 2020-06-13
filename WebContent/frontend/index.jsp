<%@page import="java.util.ArrayList"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Marquee"%>
<%@page import="com.easybooking.daoImp.CityDaoImp"%>
<%@page import="com.easybooking.dao.CityDao"%>
<%@page import="com.easybooking.model.City"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Online Shadi Hall</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Playfair+Display:400,400i,500,500i,600,600i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Fredoka+One&display=swap" rel="stylesheet">


    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <link rel="stylesheet" href="css/animate.css">
    
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">

    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">

    <link rel="stylesheet" href="css/flaticon.css">
    <link rel="stylesheet" href="css/style.css">
    <link href="css/select2.css" rel="stylesheet" />
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    
<style type="text/css">
#map {
  margin-right: 10px;
  margin-left: 10px;
  margin: 0;   
  padding: 0;
}   
#customRange1{
	width: 20%; 
}
</style>
    
</head>
  <%
  		City city = new City();
  		CityDao cityDao = new CityDaoImp();
  		
  		Marquee marquee = new Marquee();
  		MarqueeDao marqueeDao = new MarqueeDaoImp();
  		ArrayList<Marquee> list = new ArrayList<Marquee>();
  		list = marqueeDao.getMarqueeData();
  %> 
    <script type="text/javascript">
    	var check = 1; // check declear for header navigation active class
	    var arr=[];
	    var id=[]; 
    	<%for(Marquee m : list) {%> 	
			arr.push("<%=m.getLocation()%>");
			id.push("<%=m.getId()%>"); 
		<%}%>
	</script>
	
	
  <body>
  
	<jsp:include page="include/header.jsp"></jsp:include>	
    
    <div class="hero-wrap js-fullheight" style="background-image: url('images/halls/5.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-start" data-scrollax-parent="true">
          <div class="col-md-7 ftco-animate">
          	
          	<h1 class="mb-4">Find Perfect Venue For Every Event</h1>
            <p><a href="#" class="btn btn-primary">Book Now Its Free</a> <a href="#" class="btn btn-white">Contact us</a></p>
          </div>
        </div>
      </div>
    </div>

    <section class="ftco-section ftco-book ftco-no-pt ftco-no-pb">
    	<div class="container">
	    	<div class="row justify-content-end">
	    		<div class="col-lg-4">
						<form action="#" class="appointment-form">
							<h3 class="mb-3">Search. Book. Relax.</h3>
				<div class="row">
					<div class="col-md-12">
					 <div class="form-group">
			    		<div class="form-field">
	          				<div class="select-wrap">
	                      		<select name="city" id="city" onchange="town();" class="form-control select2" >
      								<option value="">Select City</option>
      									<%for (City c : cityDao.getCities()){ %>
      										<option value="<%=c.getId()%>"><%=c.getName() %></option>  
      									<%} %>
        						</select> 
	                        </div>
			             </div>
			    	</div>
				</div>
              </div>
              <div class="row">
								<div class="col-md-12">
									<div class="form-group">
			    					<div class="form-field">
	          					<div class="select-wrap">
	          					
	                  	<select name="area" id="areaCity" class="form-control select2">
	                  		<option value=''>Select Area</option>       
	                  	</select> 
	                		 
	                    </div>
			              </div>
			    				</div>
								</div>
								
								</div>
                <div class="row">
                
              
                <div class="col-md-12">
                  <div class="form-group">
                    <div class="form-field">
                      <div class="select-wrap">
                        <div class="slidecontainer">
                        <p>Person: <span id="demo"></span></p>  
                        <input type="range" min="1" max="5000" value="1" class="slider" id="myRange">
                        
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                
                
                </div>

                 <div class="row">
                 
              
                <div class="col-md-12">
                  <div class="form-group">
                    <div class="form-field">
                      <div class="select-wrap">
                       
                        <p>Max Price: <span id="max-price"></span></p>  
                        <input type="range" min="1" max="5000" value="1" class="slider" id="myRange-max-price">


                      </div>
                    </div>
                  </div>
                </div>
                
                
                </div>
								<div class="col-md-12">
									<div class="form-group">
			              <input type="submit" value="Find Now" class="btn btn-primary py-3 px-4">
			            </div>
								</div>
							</div>
	    			</form>
	    		</div>
	    	</div>
	    </div>
    </section>


   
    <section class="ftco-section ftco-10em-padding ftco-services">
    	<div class="container">
    		<div class="row">
          <div class="col-md-4 d-flex services align-self-stretch px-4 ftco-animate">
            <div class="d-block services-wrap text-center">
              <div class="img" style="background-image: url(images/tell-us.jpg);"></div>
              <div class="media-body py-4 px-3">
                <h3 class="heading">Tell us what you need</h3>
                <p>Post your event details such as the number of guests, budget, and facilities. After that, the venues come to you.</p>
                
              </div>
            </div>      
          </div>
          <div class="col-md-4 d-flex services align-self-stretch px-4 ftco-animate">
            <div class="d-block services-wrap text-center">
              <div class="img" style="background-image: url(images/multiple.jpg);"></div>
              <div class="media-body py-4 px-3">
                <h3 class="heading">Receive multiple offers</h3>
                <p>We notify the venues and they submit offers to host your event. See offers from several venues that includes pricing and full venue details.</p>
                
              </div>
            </div>    
          </div>
          <div class="col-md-4 d-flex services align-self-stretch px-4 ftco-animate">
            <div class="d-block services-wrap text-center">
              <div class="img" style="background-image: url(images/choose.jpg);"></div>
              <div class="media-body py-4 px-3">
                <h3 class="heading">Choose your venue</h3>
                <p>Choose your favourite venue, and finalise the details. That's it! You've found a space for your event.</p>
               
              </div>
            </div>      
          </div>
        </div>
    	</div>
    </section>

     <section class="ftco-section bg-light">
      <div class="container-fluid px-md-0">
        <div class="row no-gutters justify-content-center pb-5 mb-3">
          <div class="col-md-7 heading-section text-center ftco-animate">
            <h2>Finest Venues For Every Occasion</h2>
            <h3 style="color: #cd5050">Nearest your location</h3>
          </div>
        </div>
        <div class="row no-gutters" >
        	<div class="col-lg-12">
          	<!--  	<input type="range" class="custom-range" id="customRange1" style="width : 20%px;!important" value="40"> -->
				<div id="map"></div>
          </div>
        </div>
        <div class="row no-gutters" id="nearByMarquees">
        
        </div>
      </div>
    </section>




    <section class="ftco-section testimony-section bg-light">
      <div class="container">
        <div class="row justify-content-center pb-5 mb-3">
          <div class="col-md-7 heading-section text-center ftco-animate">
            <h2>Happy Clients &amp; Feedbacks</h2>
          </div>
        </div>
        <div class="row ftco-animate">
          <div class="col-md-12">
            <div class="carousel-testimony owl-carousel">
							<div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/person_1.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="fa fa-quote-left"></i>
                    </span>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                    <p class="name">Racky Henderson</p>
                    <span class="position">Father</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/person_2.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="fa fa-quote-left"></i>
                    </span>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                    <p class="name">Henry Dee</p>
                    <span class="position">Businesswoman</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/person_3.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="fa fa-quote-left"></i>
                    </span>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                    <p class="name">Mark Huff</p>
                    <span class="position">Businesswoman</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/person_4.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="fa fa-quote-left"></i>
                    </span>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                    <p class="name">Rodel Golez</p>
                    <span class="position">Businesswoman</span>
                  </div>
                </div>
              </div>
              <div class="item">
                <div class="testimony-wrap d-flex">
                  <div class="user-img" style="background-image: url(images/person_1.jpg)">
                  </div>
                  <div class="text pl-4">
                  	<span class="quote d-flex align-items-center justify-content-center">
                      <i class="fa fa-quote-left"></i>
                    </span>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                    <p class="name">Ken Bosh</p>
                    <span class="position">Businesswoman</span>
                  </div>
                </div>
              </div>
			</div>
          </div>
        </div>
      </div>
    </section>

    <section class="ftco-section bg-light">
			<div class="container">
				<div class="row no-gutters">
					<div class="col-md-6 wrap-about">
						<div class="img img-2 mb-4" style="background-image: url(images/about.jpg);">
						</div>
						<h2>The most recommended event venues</h2>
						<p>A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth. Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</p>
					</div>
					<div class="col-md-6 wrap-about ftco-animate">
	          <div class="heading-section">
	          	<div class="pl-md-5">
		            <h2 class="mb-2">What we offer</h2>
	            </div>
	          </div>
	          <div class="pl-md-5">
							<p>A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth.</p>
							<div class="row">
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-diet"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading"> Offers from multiple venues</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div> 
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-workout"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading"> Discover new event spaces</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div>
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-diet-1"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading"> Find venues without the work</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div>      
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-first"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading">Find new spaces for your events</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div>
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-first"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading">Filter by price, location, capacity and more</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div> 
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-first"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading">Request a quote for free</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div> 
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-first"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading">Seamless payments</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div> 
		            <div class="services-2 col-lg-6 d-flex w-100">
		              <div class="icon d-flex justify-content-center align-items-center">
		            		<span class="flaticon-first"></span>
		              </div>
		              <div class="media-body pl-3">
		                <h3 class="heading">Signing up is quick & easy</h3>
		                <p>A small river named Duden flows by their place and supplies it with the necessary</p>
		              </div>
		            </div>
		          </div>  
						</div>
					</div>
				</div>
			</div>
		</section>
		
		<section class="ftco-intro" style="background-image: url(images/bg_1.jpg);" data-stellar-background-ratio="0.5">
			<div class="overlay"></div>
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-md-9 text-center">
						<h2>Ready to get started</h2>
						<p class="mb-4">It's safe to book online with us! Get your dream stay in clicks or drop us a line with your questions.</p>
						<p class="mb-0"><a href="#" class="btn btn-primary px-4 py-3">Book now Its Free</a> <a href="#" class="btn btn-white px-4 py-3">Contact us</a></p>
					</div>
				</div>
			</div>
		</section>

 
   
    <jsp:include page="include/footer.jsp"></jsp:include>
  

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>


  <script src="js/jquery.min.js"></script>
  <script src="js/jquery-migrate-3.0.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>   
  <script src="js/google	MapApi.js"></script>  
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
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDGw8gvca--4ARt2I2JHwO2SUfnrHh1O90&callback=initMap" async defer></script> 
  <script src="js/main.js"></script>
  <script type="text/javascript">
       $('.select2').select2(); 
    var slider_person = document.getElementById("myRange");
    var output = document.getElementById("demo");
    output.innerHTML = slider_person.value;

    slider_person.oninput = function() {
      output.innerHTML = this.value;
    }

    var slider_max_price = document.getElementById("myRange-max-price");
    var price_output = document.getElementById("max-price");
    price_output.innerHTML = slider_max_price.value;

    slider_max_price.oninput = function() {
      price_output.innerHTML = this.value;
    }

  </script>

<script type="text/javascript">
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
 
</script>    
<script type="text/javascript">

 /*	$(document).ready(function (){
			$.ajax({
					url : '../Marquee',
					data : 'method=getNearby',
					type : 'post',

					success : function(msg){
						$('#nearByMarquees').html(msg); 
					} ,
					error : function(){
							alert("error in near by");
						}
						
				})
		}) */
</script>
</body>
</html>