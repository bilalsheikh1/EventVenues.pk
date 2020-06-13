<%@page import="com.easybooking.daoImp.CityDaoImp"%>
<%@page import="com.easybooking.dao.CityDao"%>
<%@page import="com.easybooking.model.City"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <title>List With Us | Event Venues</title>
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
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/GoogleMap1.js"></script>
    
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
    	
    <script type="text/javascript"> 

    var check = 4; // check declear for header 
    $(document).ready(function (){
		$('#part1').css('display','block');
		$('#part2').css('display','none');
		$('#part3').css('display','none'); 
		$('#part4').css('display','none');
		$('#sbt-portion').css('display','none');
		$('#type').val('insert');
		$('#type-service').val(0);
	})

/*
 *  Submit Marquee Details
 */
 
 	function submitFormDataMarquee(){
		
		$.ajax({
			url : '../Marquee' ,
			data : $("#formID-marquee").serialize(),
			type : 'post',
			success : function(data){
					var response  = data.substring(0,11);
					var index = data.indexOf("capacity");
					var session = data.substring(11,index);
					index +=8;   
					var capacity = data.substring(index , data.length); 	
					$("#total_capacity").val(capacity);   
					$('#session').val(session);
					if(response=='part1-part2'){
						$('#part1').css('display','none');
						$('#part2').css('display','block');
					} else{
							alert("Marquee Not Insert Succefully");
						}
				},
				error : function (msg){
						alert('error in add');
					}
				
				})   
		return false;
	}
/*
 * Search Area By City
 */
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
					$('#areaCity').append(options); 0
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
/*
 * Create Portion TextFiled Dynamic
 */

 var capacity_length =0 ;
 function portion() { 	 
 	// body... 
 	capacity_length =0 ;
 	$('#textfield').html(''); 
 	var number = $('#lawn').val();
 	var chk = 1;
 	var j = number;
 	$('#numOfPortion').val(number);
 	$('#type-portion').val('0');
 	$("#portionDiv").empty();
 	for(var i = 1 ; i<=number ;i++){
 		chk=0; 
 		capacity_length++;
 	    $("#portionDiv").prepend("<div class='col-md-6'><div class='form-group' id='textfield"+i+"'></div></div>. ");
 		
 		label = $("<label>class='label' for='email' ></label>").text('Capacity');
 		$("#textfield"+i).append(label);
   
 		var inputNumber = $('<input/>').attr({name : 'capacity'+j , type : 'number' , max : "2000" , placeholder: "Enter Capacity Lawn"+j , min: "50" , required : "required" , id : "portion_capacity"+j , class : "form-control"});
  		   
 		$("#textfield"+i).append(inputNumber);

 		$("#portionDiv").prepend("<div class='col-md-6'><div class='form-group' id='textfield1"+i+"'></div></div>. ");
		  
 		var label = $("<label class='label' for='email' ></label>").text('Portion / Lawn '+j);

 		$("#textfield1"+i).append(label); 

 		var input = document.createElement("INPUT");
 		input.setAttribute('type' , 'text'); 
 		input.setAttribute('name','lawn'+j);
 		input.setAttribute('placeholder','Portion / lawn : Name');
 		input.setAttribute('required','required');   
 		input.setAttribute('class','form-control');
 		$("#textfield1"+i).append(input);  
 
 		document.getElementById('type').value=0;
 		j--;
 	}
 	if(chk==0){
 		$('#btn').css('display','none');
 		$('#sbt-portion').css('display','block');
 		}
 	else{
 		$('#sbt-portion').css('display','none');
 		$('#btn').css('display','block');
 		}
 	
 }
 /*
 *	Submit Portion
 */
 function submitFormDataPortion(){
		var total_capacity = $('#total_capacity').val();
		var portion_total_capacity=0;
		for (var i = 1 ; i <= capacity_length ; i++){
				portion_total_capacity += parseInt($("#portion_capacity"+i).val());      
			}
		    
		if( total_capacity == portion_total_capacity ){
		$.ajax({
			url : '../Portion' ,
			data : $("#formID-portion").serialize(),
			type : 'post', 
			success : function(data){
				var response  = data.substring(0,11);
				var session = data.substring(11,data.length);
				$('#session_portion').val(session); 
					if(response=='part2-part3'){
						$('#part2').css('display','none');
						$('#part3').css('display','block');
					} else{
							alert("Marquee Not Insert Succefully");
						}
				},
				error : function (msg){
						alert('error in add');
					}
				})
 			}
			else {
					alert("your total capacity is not equal to portion total capacity");	
				} 
	return false;
	}

	/*
	*	Services add 
	*/

	var chkBoxIdUpdate=[];
	function submitFormDataService(){
		
		$.ajax({
			url : '../FoodServiceServlet' ,	
			data : $("#formID-service").serialize(),
			type : 'post',
			success : function(data){ 
					$('#service').html(data);
					('#serviceName').val('');
				},
				error : function (msg){ 
						alert('error in add');
					}
				
				})
	return false;
		
	}

	/* 
	* Show Gallary Tab
	*/

		function showGallary(){
				$('#part3').css('display','none');
				$('#part4').css('display','block');
			}

	function portionDataBackButton(name , capacity , id ,i){
		if(i == 1){
				$('#textfield').html('');
			 }
		var label = $('<lebel></label>').text('Portion / Lawn : Name '+i);
		$("#textfield").append(label);
		var input = document.createElement("INPUT");		
		input.setAttribute('type' , 'text');
		input.setAttribute('value', name);
		input.setAttribute('name','lawn'+i);
		input.setAttribute('placeholder','Portion / lawn : Name'); 
		$("#textfield").append(input);

		var label = $('<lebel></label>').text('Capacity');
		$("#textfield").append(label);

		var inputNumber = $('<input/>').attr({name : 'capacity'+i , type : 'number' , max : "2000" , placeholder: "Enter Capacity Lawn"+1 , min: "50" , required : "required" , id : "portion"+i});
		  
		$("#textfield").append(inputNumber);
		$("#portion"+i).val(capacity); 
		$('#numOfPortion').val(i);
		$('#lawn').prop('disabled' , true);
		$('#sbt-portion').val('Update');
		$('#type-portion').val(id);
}

function service(id , i){
chkBoxIdUpdate.push(i);
$('#service'+id).prop('checked' , true);
	$('#type-service').val(chkBoxIdUpdate);
	$('#sbt-service').val('Update');
}

function hide(check){
	if(check = 'part2-part3'){
		$('#part2').css('display','none');
		$('#part3').css('display','block');
	}
}
	
    </script>
  </head>
  <%
	City citybean = new City();
	CityDao cityDao = new CityDaoImp();
%>
  <body>
  
  	<jsp:include page="include/header.jsp"></jsp:include>	
  
    <section class="hero-wrap hero-wrap-2" style="background-image: url('images/bg_2.jpg');" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate text-center">
            <p class="breadcrumbs mb-2"><span class="mr-2"><a href="index.html">Home <i class="fa fa-chevron-right"></i></a></span> <span>List With Us <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-0 bread">List With Us</h1>
          </div>
        </div>
      </div>
    </section>
   
    <section class="ftco-section bg-light">
      <div class="container">
        <div class="row no-gutters">  
          <div class="col-md-8">
            
                  <nav>
                    <div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
                      <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Management Portal</a>
                      <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Booking Calender</a>
                      <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">Venues Details</a>
                      <a class="nav-item nav-link" id="nav-about-tab" data-toggle="tab" href="#nav-about" role="tab" aria-controls="nav-about" aria-selected="false">Reports</a>
                    </div>
                  </nav>
                  <div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
                    <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                     <img src="images/choose.jpg" width="500px" >
                    </div>
                    <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                     <img src="images/choose.jpg" width="500px" >
                    </div>
                    <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">
                    <img src="images/choose.jpg" width="500px" >
                    </div>
                    <div class="tab-pane fade" id="nav-about" role="tabpanel" aria-labelledby="nav-about-tab">
                     <img src="images/choose.jpg" width="500px" >
                    </div>
                  </div>
                
                </div>
              
          <div class="col-md-4 p-4 p-md-5 bg-white">
            <h2 class="font-weight-bold mb-4">Why List With Us</h2>
            <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>
           
          </div>
          <div class="col-md-12">
            <div class="wrapper">
              <div class="row no-gutters">
                <div class="col-lg-8 col-md-7 d-flex align-items-stretch">
                  <div class="contact-wrap w-100 p-md-5 p-4">
                    <h3 class="mb-4">Get in touch</h3>
                    <div id="form-message-warning" class="mb-4"></div> 
                    <div id = "part1">
                    <div id="form-message-success" class="mb-4">
                      <legend><span class="number">1)</span> Marquee Details</legend>
                    </div>
                    <form id="formID-marquee" onsubmit="return submitFormDataMarquee();">
                    <input type="hidden" name="type" id="type" /> 
                      <div class="row">
                        <div class="col-md-6">
                          <div class="form-group">
                            <label class="label" for="name">Marquee Name *</label>
                            <input type="text" class="form-control" type="text" name="name" placeholder="Marquee Name *"  id="name"  required="required">
                          </div>
                        </div>
                        <div class="col-md-6"> 
                          <div class="form-group">
                            <label class="label" for="email">Email Address *</label>
                            <input type="email" class="form-control" name="email" id="email" placeholder="Email *">
                          </div>
               	         </div>
						<div class="col-md-6">  
                          <div class="form-group">
                            <label class="label" for="email">Contact *</label>
                            <input type="number" class="form-control" maxlength="11" maxlength="11" name="contact" placeholder="Contact *" id="contact" required="required" value=" 03" > 
                          </div> 
                        </div>
						<div class="col-md-6"> 
                          <div class="form-group">
                            <label class="label" for="email">Capacity *</label>
                            <input type="number" class="form-control" name = "capacity"  id="capacity" max="3000" placeholder="Total Capacity *" required="required" >
                          </div>
                        </div>  
						<input type="hidden" name="type" value="insert" id="type" />                         
                        <div class="col-md-6"> 
                          <div class="form-group">
                        	<select name="city" id="city" required="required" onchange="town();" >      
								<option value="" >Select City</option>
									<% for(City c : cityDao.getCities()){ %>
									<option value=<%=c.getId()%> ><%=c.getName()%></option>
								<%} %>
							</select>
						  </div>
						</div>
						 
						<div class="col-md-6"> 
                          <div class="form-group">
								<select name="area" id="areaCity" required="required">
									<option value=''>Select Area</option> 
								</select>
                        	</div>
                        </div>
                        <div class="col-md-12">
                          <div class="form-group">
                            <label class="label" for="#">Marquee Address *</label>
                            <textarea name="address" class="form-control" name="address" placeholder="Marquee Address *" id="address" required="required" cols="30" rows="4" ></textarea>
                          </div>
                        </div>
                        <div class="col-md-12">
                        	<div id="floating-panel">
  								<input onclick="deleteMarkers();" type=button value="Delete Markers">
							</div>   
                        	<div id="map"></div>
                        	<br>
                        </div> 
                        <input type="hidden" name="location" value="" id="location"/>
                        <input type="hidden" name="address2" value="" id="address2"/>
                        <div class="col-md-12"> 
                          <div class="form-group">
                            <input type="submit" value="Next" id="sbt-marquee" class="btn btn-primary">
                            <div class="submitting"></div>
                          </div>
                        </div>
                      </div>
                     </form>
                    </div>
                    
                    <!-- Portion Module Start -->
                    
                    <div id = "part2">
                    <div id="form-message-success" class="mb-4">
                      <legend><span class="number">2)</span> Portions Details</legend>
                    </div>
                    <form id='formID-portion' onsubmit="return submitFormDataPortion();">
                    <input type="hidden" id='numOfPortion' name="totalPortion">
						<input type="hidden" id="type-portion" name="type" /> 
						<input type="hidden" id="session" > 
						<input type="hidden" id="total_capacity" />   
                      <div class="row"> 
                        <div class="col-md-12">
                          <div class="form-group">
                            <label class="label" for="name">How many portion do u have </label>
                        	    <select onchange="portion();" id="lawn">
                    	    	    <option>Select Portion/lawn</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
								</select>
                          </div>
                        </div>    
                        
                        <div class="row" id="portionDiv"></div>
                        
						<div class="col-md-2"> 
                          <div class="form-group">
							<input type="button" value="Back" class="btn btn-primary" onclick="getDataOnBackButtonMarquee();" />
							<div class="submitting"></div>
                          </div>
                        </div>
                        
                        <div class="col-md-2">
                          <div class="form-group">
                            <input type="submit" value="Next" class="btn btn-primary">
                            <div class="submitting"></div>
                          </div>
                        </div>
                        
                        <div class="col-md-4">
                          <div class="form-group">
                        	 <input type="button" value="Next Without Portion" id='btn' class="btn btn-primary" onclick="hide('part2-part3')" />
                       		 <div class="submitting"></div>
                          </div>
                         </div>
						
                      
                      </div>
                     </form>
                    </div>
                    
                    <!-- Marquee Services -->
                    
                  <div id = "part3">
                    <div id="form-message-success" class="mb-4">
                      <legend><span class="number">3)</span> Services Details</legend>
                    </div>  
                      
                  <div class="row">
                   <form  id="formID-service" onsubmit="return submitFormDataService()">
                    <input type="hidden" name="type" id="type" />
                    <input type="hidden" name="Action" value="Add Service" id="Action" />
                        <div class="col-md-12"> 
                          <div class="form-group">
                            <label class="label" for="name">Add Service *</label> 
                            <input type="text" class="form-control"  name="name" placeholder="Service Name *"  id="serviceName"  required="required">
                          </div>
                        </div> 
                          <div class="col-md-12">
                          <div class="form-group"> 
                            <input type="submit" value="Save" id="sbt-marquee" class="btn btn-primary">
                            <div class="submitting"></div>
                          </div>
                        </div> 
                        </form>
                        <div class="col-md-12"> 
                          <div class="form-group">
                          <h2>Services</h2>
                            <table border="1">
								<thead>
									<tr>
										<th>SerialNo</th>
										<th>Service Name</th>
										<th>Delete</th>
									</tr>
								</thead> 
								<tbody id="service">
								</tbody>
							</table>
                          </div>
                        </div>
						
						<div class="col-md-2"> 
                          <div class="form-group">
                        	<input type="button" value="Back" class="btn btn-primary" onclick="getDataOnBackButtonPortion();" />
                        	<div class="submitting"></div>
                          </div>
                        </div>
                        
						<div class="col-md-2"> 
                          <div class="form-group"> 
                            <input type="button" value="Next" id="sbt-marquee" onclick="showGallary();" class="btn btn-primary">
                            <div class="submitting"></div>
                          </div>
                        </div>
                          
                        
                        
                      </div>
                     
                    </div>
                    
                    <!-- Marquee Imagaes -->
                     
                  <div id = "part4">
                    <div id="form-message-success" class="mb-4">
                      <legend><span class="number">4)</span> Marquee Gallary </legend>
                    </div>
                    <form id="formID-gallery" enctype="multipart/form-data">
                    <input type="hidden" name="type" id="type" /> 
                      <div class="row">
                        
                        <div class="col-md-12">
                          <div class="form-group">
                            <label class="label" for="name">Marquee Logo</label>
                            <input type="file" class="form-control" accept="image/*" id="exampleInputFile" name="logo" aria-describedby="fileHelp">
                          </div>
                        </div> 
                        
                        <div class="col-md-12"> 
                          <div class="form-group">
                            <label class="label" for="name">Marquee Images</label> 
                            <input type="file" class="form-control" name="img[]" accept="image/*" id="exampleInputFile" aria-describedby="fileHelp" multiple>
                          </div>
                        </div>
						<div class="col-md-2"> 
                          <div class="form-group"> 
                            <input type="button" value="Register Now" id="sbt-marquee" class="btn btn-primary" onclick="getDataOnBackButtonService();">
                            <div class="submitting"></div>
                          </div>
                        </div>
                      	<div class="col-md-2"> 
                          <div class="form-group"> 
                            <input type="submit" value="Register Now" id="sbt-marquee" class="btn btn-primary">
                            <div class="submitting"></div>
                          </div>
                        </div>
                      </div>
                     </form>
                    </div>
                    
                    
                    
                    
                  </div>
                </div>
                <div class="col-lg-4 col-md-5 d-flex align-items-stretch">
                  <div class="info-wrap bg-primary w-100 p-md-5 p-4">
                    <h3>Let's get in touch</h3>
                    <p class="mb-4">We're open for any suggestion or just to have a chat</p>
                    <div class="dbox w-100 d-flex align-items-start">
                      <div class="icon d-flex align-items-center justify-content-center">
                        <span class="fa fa-map-marker"></span>
                      </div>
                      <div class="text pl-3">
                        <p><span>Address:</span> 198 West 21th Street, Suite 721 New York NY 10016</p>
                      </div>
                    </div>
                    <div class="dbox w-100 d-flex align-items-center">
                      <div class="icon d-flex align-items-center justify-content-center">
                        <span class="fa fa-phone"></span>
                      </div>
                      <div class="text pl-3">
                        <p><span>Phone:</span> <a href="tel://1234567920">+ 1235 2355 98</a></p>
                      </div>
                    </div>
                    <div class="dbox w-100 d-flex align-items-center">
                      <div class="icon d-flex align-items-center justify-content-center">
                        <span class="fa fa-paper-plane"></span>
                      </div>
                      <div class="text pl-3">
                        <p><span>Email:</span> <a href="mailto:info@yoursite.com">info@yoursite.com</a></p>
                      </div>
                    </div>
                    <div class="dbox w-100 d-flex align-items-center">
                      <div class="icon d-flex align-items-center justify-content-center">
                        <span class="fa fa-globe"></span>
                      </div>
                      <div class="text pl-3">
                        <p><span>Website</span> <a href="#">yoursite.com</a></p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <jsp:include page="include/footer.jsp"></jsp:include>

  <!-- loader -->
  <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

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
  <script src="js/main.js"></script>
  <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDGw8gvca--4ARt2I2JHwO2SUfnrHh1O90&callback=initMap"></script>
  
<script type="text/javascript">

$('#formID-gallery').on('submit' , function(e){
	e.preventDefault();
    var data =  new FormData(this);
	$.ajax({
		type : 'post',
		url : '../GalleryServlet' ,
		data : data,
		cache : false,
        processData : false,
        contentType :  false,
        
		
		success : function(data){
				if(data=='Completed'){
					alert('your Marquee is registered sucessfully');
					window.location.href="index.jsp";
				} else{
						alert("Marquee Not Insert Succefully");
					}
			},
			error : function (msg){
					alert('error in add');
				}
			
			})
})

</script>
	<script type="text/javascript">

	function getDataOnBackButtonMarquee(){ 
		var id = $('#session').val();
			$.ajax({
					url:'../Marquee',
					type : 'post',
					data: 'id='+id+'&method=getDataOnBackButtonMarquee',
					success : function (data){
							var obj = JSON.parse(data);
							$('#type').val(obj.id);	
							$('#name').val(obj.name);
							$('#email').val(obj.email);
							$('#location').val(obj.location);
							$('#address').val(obj.address);
							$('#address2').val(obj.address2);    
							$('#contact').val(obj.contact);
							$('#capacity').val(obj.capacity);
							$('#city').val(obj.cityID);
							$('#areaCity').val(obj.areaID); 
							$('#sbt-marquee').val('Update');
							$('#part2').css('display' , 'none');  
							$('#part1').css('display' , 'block');
							
						} ,
					error : function (){
							alert('Error in BackButton');
						}	 

				})
			
		}

	function getDataOnBackButtonPortion(){

		var portionID = $('#session_portion').val();
		if(portionID == ""){
					$('#part2').css( 'display' , 'block');
					$('#part3').css( 'display' , 'none' );
				}
			else{
					$.ajax({
							url : '../Portion' , 
							type: 'post' ,
							data : 'id = '+portionID+'&method=getData',
							success : function (data){
									$('#part2').css('display','block');
									$('#part3').css('display' , 'none' );
									var obj = JSON.parse(data);
									var i=0;
									for(b in obj){
											i++;
											portionDataBackButton(obj[b].name , obj[b].portionCapacity, obj[b].id ,i);
										}
								},    
							error : function (){
									alert('error in back button');
								}

						})				
				}
		}

		function getDataOnBackButtonService(){
				$.ajax({
						url : '../FoodServiceServlet' ,
						type : 'post' ,
						data : 'id='+serviceID+'&method=getDataByMarqueeID',
						success: function(data){
								$('#part3').css('display', 'block');
								$('#part4').css('display', 'none');
								$('#service').html(data);
							},
						error : function(){
								alert('error in get Data');
							}
					})
			}

		/*
		*	Delete Service
		*/

		function deleteService(id){
			$.ajax({ 
				url : '../FoodServiceServlet' ,
				type : 'post' ,
				data : 'id='+id+'&method=delete',
				success: function(data){
					$('#service').html(data);
					},
				error:function (){
						alert("error in deleteService method");
					}
			});
		}
</script>
	
  </body>
</html>