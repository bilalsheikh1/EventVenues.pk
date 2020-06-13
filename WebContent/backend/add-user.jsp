<%@page import="com.easybooking.encrypt.EncryptionDecryption"%>
<%@page import="com.easybooking.model.User"%>
<%@page import="com.easybooking.daoImp.UserDaoImp"%>
<%@page import="com.easybooking.dao.UserDao"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head><% if(session.getAttribute("admin")==null){ response.sendRedirect("index.jsp");}%>
  <meta charse  t="utf-8">
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
          url : '../UserServlet' ,
          data : $("#formID").serialize(),
          type : 'post',
          success : function(e){
              alert(e);
              if(e == "User Updated"){
                  window.location.href="active-user.jsp";
                }
              else{
              $("#formID")[0].reset();
              } 
            },
            error : function (msg){
                alert('error in ajax fnction');
              }
            
            })
      return false;
        
     }      
        
      

</script>
<%
System.setProperty("tomcat.util.http.parser.HttpParser.requestTargetAllow", "{}");

User userBean = new User(); 
UserDao userDao = new UserDaoImp();
String btnName="Register User";
Integer i = 0; 
if(request.getParameter("id")!=null){ 
  
  Integer id = null;
  String encrypt=request.getParameter("id");  
  String decrypt = "";
//  Integer id = null;
  for(int j = 0 ; j < encrypt.indexOf("M") ; j++){
    decrypt += encrypt.charAt(j);
  }
  id = Integer.parseInt(decrypt);
  userBean = userDao.getDataById(id);
  btnName = "Update User";
  i=userBean.getId();
}

%>

<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
<jsp:include page="include/header.jsp"></jsp:include>
<jsp:include page="include/sidebar.jsp"></jsp:include>
 <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Dashboard
        <small>Control panel</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="dashboard.jsp"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

  <div class="col-md-12">
   <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Sign Up</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form id="formID" onsubmit="return submitFormData();" >
              <div class="box-body">
                   <div class="form-group">
                   <input type="hidden" value="<%=i%>" name="Action" id="">
                  <label for="exampleInputEmail1">Name</label>
                  <input type="text" class="form-control"  placeholder="Enter Name (Allow only letters)" value="<%=userBean.getName()%>" name="name" required="required" minlength="3" maxlength="40" pattern="[A-Za-z ]+" title="(Allow only letters & Min length 3)"/>
                </div>
                <div class="form-group">
                  <label for="exampleInputEmail1">Email address</label>
                  <input type="email" class="form-control"  placeholder="Enter email" value="<%=userBean.getEmail()%>" name="email" required="required"/>
                </div>
                <div class="form-group">
                  <label for="exampleInputPassword1">Password</label>
                  <input type="password" class="form-control"  placeholder="Password" value="<%=userBean.getPassword()%>" name="password" required="required" pattern=".{6,}"/>
                </div>
        
        <div class="form-group">
                  <label for="exampleInputPassword1">Contact</label>
                  <input type="number" class="form-control"  placeholder="Contact" value="<%=userBean.getContact()%>" name="contact" required="required" minlength="11"/>
                </div>
        

              </div>
              <!-- /.box-body -->

              <div class="box-footer">
                <input type="submit" class="btn btn-primary" value="<%=btnName %>" / >
              </div>
            </form>
          </div>
</div>  


  </div>
  <!-- /.content-wrapper -->
 
  <!-- Control Sidebar -->
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- jQuery 3 -->
<script src="../frontend/assets/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="../frontend/assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="../frontend/assets/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../frontend/assets/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../frontend/assets/dist/js/demo.js"></script>
</body>
</html>