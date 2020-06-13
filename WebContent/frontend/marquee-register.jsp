<%@page import="com.easybooking.daoImp.FoodServicesDaoImp"%>
<%@page import="com.easybooking.dao.FoodServicesDao"%>
<%@page import="com.easybooking.model.FoodServices"%>
<%@page import="com.easybooking.daoImp.CityDaoImp"%>
<%@page import="com.easybooking.dao.CityDao"%>
<%@page import="com.easybooking.model.City"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<% 
//	if(session.getAttribute("userName")==null)response.sendRedirect("login.jsp");
%>
	<title>Hall Register</title>
	<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-state=1" />
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet" href="stylesheet.css" />


<!-- <link type="text/css" rel="stylesheet" href="css/bootstrap.css" /> -->
 <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
	var check=3;
	$(document).ready(function (){
		var options="<option value=''>Select Area</option>";    
		$('#areaCity').append(options);  
		$('#part1').css('display','none');
		$('#part2').css('display','none');
		$('#part3').css('display','block'); 
		$('#part4').css('display','none');
		$('#sbt-portion').css('display','none');
		$('#type').val('insert');
		$('#type-service').val(0);
	})
	

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


	function submitFormDataPortion(){
		var total_capacity = $('#total_capacity').val();
		var portion_total_capacity=0;
		for (var i = 1 ; i <= capacity_length ; i++){
				portion_total_capacity += parseInt($("#portion_capacity"+i).val());    
			} 
		if( total_capacity == portion_total_capacity )
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
			else {
					alert("your total capacity is not equal to portion total capacity");	
				} 
	return false;
		
	}
	var chkBoxIdUpdate=[];
	function submitFormDataService(){
		
		$.ajax({
			url : '../MarqueeFoodServices' ,	
			data : $("#formID-service").serialize(),
			type : 'post',
			success : function(data){
					if(data=='part3-part4'){
						$('#part3').css('display','none');
						$('#part4').css('display','block');
					} else{
							alert(msg); 
						}
				},
				error : function (msg){ 
						alert('error in add');
					}
				
				})
	return false;
		
	}


		

</script>
<script type="text/javascript">
var capacity_length =0 ;
function portion() {
	// body...
	$('#textfield').html('');
	var number = $('#lawn').val();
	var chk = 1;
	$('#numOfPortion').val(number);
	$('#type-portion').val('0');
	for(var i = 1 ; i<=number ;i++){
		chk=0;
		capacity_length++;
		var label = $('<lebel></label>').text('Portion / Lawn '+i);
		$("#textfield").append(label);

		var input = document.createElement("INPUT");
		input.setAttribute('type' , 'text');
		input.setAttribute('name','lawn'+i);
		input.setAttribute('placeholder','Portion / lawn : Name');
		input.setAttribute('required','required');
		$("#textfield").append(input);

		var label = $('<lebel></label>').text('Capacity');
		$("#textfield").append(label);

		var inputNumber = $('<input/>').attr({name : 'capacity'+i , type : 'number' , max : "2000" , placeholder: "Enter Capacity Lawn"+1 , min: "50" , required : "required" , id : "portion_capacity"+i});
		
		$("#textfield").append(inputNumber);
		document.getElementById('type').value=0;
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
							$('#address').val(obj.address);  
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

		function getDataOnBackButtonService(serviceID){
				$.ajax({
						url : '../MarqueeFoodServices' ,
						type : 'post' ,
						data : 'id='+serviceID+'&method=getData',
						success: function(data){
								$('#part3').css('display', 'block');
								$('#part4').css('display', 'none');
								var obj = JSON.parse(data);
								var i =0;
									for(b in obj){ i++;
										service(obj[b].service_id , obj[b].id );
									}
							},
						error : function(){
								alert('error in get Data');
							}
					})
			}
		

</script>
<%
	City citybean = new City();
	CityDao cityDao = new CityDaoImp();
%>
</head>

<body style="background-image:url(images/hallregister.jpg;"> 
		<jsp:include page="include/header.jsp"></jsp:include>

	<div class="row1">
		<section style="margin-top: 130px;">
			<div class="container">
				<div class="row">
					 
					<div class="col-md-4 marq" id = "part1">
						<form id="formID-marquee" onsubmit="return submitFormDataMarquee();">
							<fieldset>
						<legend><span class="number">1</span> Marquee Details</legend>
						<input type="text" name="name" placeholder="Marquee Name *"  id="name"  required="required"> 
						<input type="email" name="email" placeholder="Your Email *" id="email" required="required">
						<input type="text" name="address" placeholder="Marquee Address *" id="address" required="required">
						<input type="number" maxlength="11" maxlength="11" name="contact" placeholder="Contact *" id="contact" required="required" value=" 03" />
											
						<input type="hidden" name="type" id="type" /> 
						<input type="number" name = "capacity"  id="capacity" max="3000" placeholder="Total Capacity Marquee" required="required" />  
						   
                  	<select name="city" id="city" required="required" onchange="town();" >      
						<option value="">Select City</option>
							<% for(City c : cityDao.getCities()){ %>
							<option value=<%=c.getId()%> ><%=c.getName()%></option>
							<%} %>
						</select>
						
						<select name="area" id="areaCity" required="required">
							
						</select>
						 
						<input type="submit" value="Next" id="sbt-marquee"/>

						      </fieldset>
						</form>
					</div>
					
  
						
						<div class="col-md-4 marq" id = "part2" >
						
						<form id='formID-portion' onsubmit="return submitFormDataPortion();">
							<fieldset>   
							<span style="color: red"> (If you book portion/Lawn seperate so choise otherwise click next button)</span> 
						<label>How many portion do u have </label>
						
						<select onchange="portion();" id="lawn">
							<option>Select Portion/lawn</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
						</select>
						<input type="hidden" id='numOfPortion' name="totalPortion">
						<input type="hidden" id="type-portion" name="type" /> 
						<input type="hidden" id="session" > 
						<input type="hidden" id="total_capacity" /> 
					    <div id="textfield"></div>
								
						<input type="submit" value="Next" id='sbt-portion'  />
                  		<input type="button" value="Next" id='btn' onclick="hide('part2-part3')" />
						<input type="button" value="Back" onclick="getDataOnBackButtonMarquee();" />	
					      </fieldset>
						</form>
						
					</div>
					

					
					<div class="col-md-4 marq" id = "part3" >
						<form id="formID-service" onsubmit="return submitFormDataService()">
							<fieldset>
							
						<h6>Service Name</h6>
						
        				<input type="text">
						
						<h6>Select Service Type</h6>
						<select>
							<option>Select Service Type</option>
							<option>Internal Only</option>
							<option>External Only</option>
							<option>Both</option>
						</select>
						 
						<input type="button" value="Add"  />
						
						<table style="background-color : white; width:99%">
						<tr> 
							<td>Service name  Service Type <input src="../backend/img/deleteicon.png"></td>
						</tr>  
						<tr><td>ok</td></tr>
						<tr><td>ok</td></tr>
						<tr><td>ok</td></tr>
						</table>
						
						<legend><span class="number">3</span> Services </legend>
						 <span>Services</span>
						 <% FoodServicesDao foodServicesDao  = new FoodServicesDaoImp();
						 int i = 0;
						  for(FoodServices s : foodServicesDao.getService(1)){  i++;%>
						 
						 <label class="form-check-inline chk"><input type="checkbox" class="form-check-input" value="<%=s.getId()%>" name="service<%=i%>" id="service<%=i%>" /><%=s.getName()%></label>
						 
						<%} %>
						<input type="hidden" name="totalService" value="<%=i%>">
						<input type="hidden" id="type-service" name="type" />
						<input type="hidden" id="session_portion" /> 
						<input type="submit" value="Next" name="sbt" id="sbt-service" />
						<input type="button" value="Back" onclick="getDataOnBackButtonPortion();" />	
						</fieldset>
						</form>
					</div>
 

					<div class="col-md-4 marq" id = "part4" >
						<form id="formID-gallery" enctype="multipart/form-data" >
							<fieldset>
						<legend><span class="number">4</span> Gallery </legend>
						 
						<h6>Marquee Logo</h6>
						<div class="custom-file upl" id="customFile" lang="es">
        				<input type="file" class="custom-file-input upl" accept="image/*" id="exampleInputFile" name="logo" aria-describedby="fileHelp" >
        				<label class="custom-file-label" for="exampleInputFile">
         				  Select file...
        				</label>
						</div>

						 <h6>Marquee Images </h6> 						
						<div class="custom-file upl " id="customFile" lang="es">
        				<input type="file" class="custom-file-input" name="img[]" accept="image/*" id="exampleInputFile" aria-describedby="fileHelp" multiple>
        				<label class="custom-file-label" for="exampleInputFile">
         				  Select file...
        				</label>
						</div>

						<input type="submit"  value="register" />
					 <!-- <input type="button" value="Back" onclick="getDataOnBackButtonService(session service id);" />  -->		
						      </fieldset>
						</form>
					</div>
					
				</div>
				
			</div>
		</section>
	</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script>
	// Add the following code if you want the name of the file appear on select
$(".custom-file-input").on("change", function() {
  var fileName = $(this).val().split("\\").pop();
  $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
});
</script>
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
</body>
</html>