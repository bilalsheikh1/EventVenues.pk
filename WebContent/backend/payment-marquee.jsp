<%@page import="java.util.ArrayList"%>
<%@page import="com.easybooking.daoImp.PaymentDaoImp"%>
<%@page import="com.easybooking.dao.PaymentDao"%>
<%@page import="com.easybooking.model.Payment"%>
<%@page import="com.easybooking.daoImp.MarqueeDaoImp"%>
<%@page import="com.easybooking.dao.MarqueeDao"%>
<%@page import="com.easybooking.model.Marquee"%>
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
<% if(session.getAttribute("admin")==null){ response.sendRedirect("index.jsp");}%> 
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
<link rel="stylesheet" href="../frontend/assets/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">

  <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->

  <!-- Google Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript">
   
    function submitFormData(){
        $.ajax({
          url : '../PaymentServlet' ,
          data : $("#formID").serialize(),
          type : 'post',
          success : function(msg){  
            if(msg == 'Data Updated'){
                location.reload();  
              }
            else {
                 $('#month').val();
                 $('#year').val();
                 $('#marquee_id').val();
                 $('#date').val(); 
              } 
            },
            error : function (msg){
                alert('error in add');
              }
            
            })
      return false;
        
     }      

     function deleterecord(id)
      {
        var r = confirm ("Are You Sure to Delete User");
         if(r == true){
          //var id = e.target.value;
            $.ajax({
              url : '../FoodServicesServlet' ,
              data : "method=delete&id="+id,
              type : 'post',
              success : function(data){
                 $("#getrecord").html(data);  
                },
                error : function (msg){
                  alert('error in delete');
                }
          })        
         }
      }
      var updateId ;
     function getData(id)
      {
        $.ajax({
            url : '../PaymentServlet' ,
            data : "Action=getData&id="+id,
            type : 'post',
            success : function(msg){
                var obj = JSON.parse(msg);                
                  for(b in obj ){  
                  if(obj[b].monthly > 0){
                      $('#textfiled').empty();
                      $('#textfiled').append('<label for="exampleInputEmail1">Per Month</label><input type="number" id="month" class="form-control" placeholder="Enter Monthly Charges " name="month" required="required" />');
                      $('#r1').attr("checked" , true);
                      $('#month').val(obj[b].monthly);    
                    }
                  else{
                      $('#textfiled').empty();
                      $('#textfiled').append('<label for="exampleInputEmail1">Per Year</label><input type="number" id="year" class="form-control" placeholder="Enter Yearly Charges "  name="year" required="required" /> ');
                      $('#r2').attr("checked" , true);
                      $('#year').val(obj[b].yearly); 
                    } 
                  console.log(obj[b].whichMonthDate);
                      $('#date').val(obj[b].whichMonthDate);
                      $('#id').val(obj[b].id); 
                      $('#marquee_id').val(obj[b].marqueeID);
                      $('#submit').val("Update"); 
                      $('#Action').val("update"); 
                }         
              },
            error : function (msg){
                alert('error in getData');
              }
          })        
      }

  function payment(schedule){
      if(schedule == "month" ){
        $('#textfiled').empty();
        $('#textfiled').append('<label for="exampleInputEmail1">Per Month</label><input type="number" id="month" class="form-control" placeholder="Enter Monthly Charges " name="month" required="required" />');
        }
      else {
        $('#textfiled').empty();
        $('#textfiled').append('<label for="exampleInputEmail1">Per Year</label><input type="number" id="year" class="form-control" placeholder="Enter Yearly Charges "  name="year" required="required" /> '); 
        }
    }     
      

</script>
<%
  PaymentDao paymentDao = new PaymentDaoImp();

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
        Payment
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

             <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Payment</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="formID" onsubmit="return submitFormData();" >
              <div class="box-body">
                    
               <input type="hidden" name="Action" value="insert" id="Action" />
               <input type="hidden" name="id" id="id" /> 
               
                    <div class="form-group">
                
                <label>   
                <span>Per Month</span>
                  <input type="radio" id="r1" name="r1" class="minimal" onclick="payment('month');"  />
                </label>
                
                <label>
                <span>Per Year</span> 
                  <input type="radio" id="r2" name="r1" class="minimal" onclick="payment('year');" />
                </label>
                
              </div>
                    
                  <div class="form-group" id="textfiled" >
                </div>
                  
                  <div class="form-group"  > 
                  <label for="exampleInputEmail1">Select Monthly Date Payment</label>
                    <input type="date" class="form-control" id="date" name="date" required="required"/>
                </div>
                  
      <div class="form-group">
                <label>Select Marquee</label> 
                
       <div class="form-group"> 
                <select class="form-control select2" style="width: 100%;" name="marqueeID" id="marquee_id" required="required">
                  <option value="">Select a Marquee</option>
                  <%  MarqueeDao marqueeDao = new MarqueeDaoImp();
                  for(Marquee m : marqueeDao.getMarqueeData()){ %> 
                      <option value="<%=m.getId()%>"><%=m.getName()%></option>
                  <%} %> 
                </select>
                
              </div>
              
              <div class="box-footer"> 
                <input type="submit" id = "submit" name="submit" class="btn btn-primary"  value="ADD" />
              </div>     
            </form>
          </div>
          
  

  <div class="box">
            <div class="box-header">
              <h3 class="box-title">Marquee Record</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table id="example1" class="table table-bordered table-striped">
                <thead>
                <tr>
                <th>S.No</th>
                  <th>Marquee Name</th>
                  <th>Join Date</th>
                  <th>Add Record Date</th>
                  <th>Per Month</th>
                  <th>Per Year</th>
                  <th>Action</th>
                </tr>
                </thead>
                <tbody id="getrecord">
                <% int serialNo = 0 ;
                ArrayList<Integer> list1=new ArrayList<>();
                for(Payment p : paymentDao.getPaymentRecord()){ 
                  serialNo++;
                  if(serialNo == 1){
                    list1.add(p.getMarquees().getId());
                    
                %>
                <tr>
                    <td><%=serialNo%></td>   
                    <td><%=p.getMarquees().getName()%></td>
                    <td><%=p.getMarquees().getCreated_at()%></td>
                    <td><%=p.getPaymentdate()%></td>
                    <td><%=p.getPerMonth()%></td>
                    <td><%=p.getPerYear()%></td> 
                    <td><a href="#"><input type="image" src="img/updateicon.png" onclick="getData(<%=p.getId()%>)" /></a>
                      <a href="#"><input type="image" id="image" src="img/deleteicon.png" onclick="deleterecord(<%=p.getId() %>)" value="<%=p.getId()%>" /></a>
                    </td>
                </tr>  
                <%}else { 
                  boolean check1 = list1.contains(p.getMarquees().getId());
                    if(check1==false){
                      list1.add(p.getMarquees().getId());
                   %>
                     <tr>
                         <td><%=serialNo%></td>   
                        <td><%=p.getMarquees().getName()%></td>
                        <td><%=p.getMarquees().getCreated_at()%></td>
                        <td><%=p.getPaymentdate()%></td>
                        <td><%=p.getPerMonth()%></td>
                        <td><%=p.getPerYear()%></td> 
                        <td><a href="#"><input type="image" src="img/updateicon.png" onclick="getData(<%=p.getId()%>)" /></a>
                          <a href="#"><input type="image" id="image" src="img/deleteicon.png" onclick="deleterecord(<%=p.getId() %>)" value="<%=p.getId()%>" /></a>
                        </td>
                     </tr> 
                     <% } }}%>
                
                </tbody>
                <tfoot>
                <tr>
                <th>S.No</th>
                  <th>Marquee Name</th>
                  <th>Join Date</th>
                  <th>Add Record Date</th>
                  <th>Per Month</th>
                  <th>Per Year</th>
                  <th>Action</th>
                </tr>
                </tfoot>
              </table>
            </div>
            <!-- /.box-body -->
          </div>
  

  



   <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<!-- Bootstrap 3.3.7 -->

<script src="../frontend/assets/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="../frontend/assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="../frontend/assets/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="../frontend/assets/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="../frontend/assets/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick --> 
<script src="../frontend/assets/bower_components/fastclick/lib/fastclick.js"></script><!-- AdminLTE App -->
<script src="../frontend/assets/dist/js/adminlte.min.js"></script>
<!-- AdminLTE dashboard demo (This is only for demo purposes) -->

<!-- AdminLTE for demo purposes -->
<script src="../frontend/assets/dist/js/demo.js"></script>

<script>
  $(function () {
    $('input[type="radio"].minimal').iCheck({
        checkboxClass: 'icheckbox_minimal-blue',
        radioClass   : 'iradio_minimal-blue'
      })
  $('.select2').select2() 
    $('#example1').DataTable()
    $('#example2').DataTable({
      'paging'      : true,
      'lengthChange': false,
      'searching'   : false,
      'ordering'    : true,
      'info'        : true,
      'autoWidth'   : false
    })
  })
</script>
</body>
</html>