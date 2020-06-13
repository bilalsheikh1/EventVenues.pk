  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="img/avatar5.png" class="img-circle" alt="User Image"> 
        </div>
        <div class="pull-left info">
          <p><%=session.getAttribute("admin") %></p>
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>
      <!-- search form -->
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
        <li class="header">MAIN NAVIGATION</li>
        <li class="active">
          <a href="dashboard.jsp">
            <i class="fa fa-dashboard" ></i> <span>Dashboard</span>
            
          </a>
        </li>
        
        
          <li class="treeview">
          <a href="#">
            <i class="fa fa-user"></i> <span>Users</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            <!--<li><a href="add-user.jsp"><i class="fa fa-circle-o"></i> Add User</a></li>-->
            <li><a href="active-user.jsp"><i class="fa fa-circle-o"></i> Active Users</a></li>
            <li><a href="deactive-user.jsp"><i class="fa fa-circle-o"></i> Deactive Users</a></li>
          </ul>
        </li>
        
         
          <li class="treeview">
          <a href="#">
            <i class="fa fa-building-o"></i> <span>Marquees</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span> 
          </a>
           <ul class="treeview-menu">
            <li><a href="marquee-request.jsp"><i class="fa fa-circle-o"></i>  Marquees Requests</a></li>
            <li><a href="active-marquee.jsp"><i class="fa fa-circle-o"></i> Active Marquees</a></li>
            <li><a href="deactive-marquee.jsp"><i class="fa fa-circle-o"></i> Deactive Marquees</a></li>
            <li><a href="marquee-booking-detail.jsp"><i class="fa fa-circle-o"></i>Marquees Booking Detail</a></li>
          </ul>
        </li>
      
      
          <li class="treeview">
          <a href="#">
            <i class="fa fa-credit-card"></i> <span>Marquees Payment</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span> 
          </a>
           <ul class="treeview-menu"> 
           <li><a href="trial-version-end.jsp"><i class="fa fa-circle-o"></i> Trial Version End</a></li>
            <li><a href="payment-marquee.jsp"><i class="fa fa-circle-o"></i>Add Payment Marquee</a></li> 
            
            <li><a href="pending-payment.jsp"><i class="fa fa-circle-o"></i> Pending Payment</a></li>
            <li><a href="payment-record.jsp"><i class="fa fa-circle-o"></i>Payment Record</a></li>  
          </ul>  
        </li>     
          
     <% if(session.getAttribute("active")!=null){
    	byte active = Byte.parseByte(""+session.getAttribute("active"));	
    	 if(active == 2){ 
    	 %>    
    
        
        <li class="treeview">
          <a href="#">
            <i class="fa fa-wrench"></i> <span>System Settings</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a>
          <ul class="treeview-menu">
            
                
            
    <!--       <li class="treeview">
              <a href="#"><i class="fa fa-building-o"></i> Services
                <span class="pull-right-container">
                  <i class="fa fa-angle-left pull-right"></i>
                </span>
              </a>
              <ul class="treeview-menu">
            <li><a href="active-food-services.jsp"><i class="fa fa-circle-o"></i> Active Services</a></li>
            <li><a href="deactive-food-services.jsp"><i class="fa fa-circle-o"></i> Deactive Services</a></li>
            </ul>
        </li>
        
        -->   
        
        <li class="treeview">
          <a href="#">
            <i class="fa fa-building-o"></i> <span>Cities</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span> 
          </a>
          <ul class="treeview-menu">
            <li><a href="cities.jsp"><i class="fa fa-circle-o"></i> Cities</a></li>
          </ul>
        </li>
         
         <li class="treeview">
          <a href="#">
            <i class="fa fa-building-o"></i> <span>Area</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span> 
          </a>  
          <ul class="treeview-menu">
            <li><a href="area.jsp"><i class="fa fa-circle-o"></i>Areas</a></li>
          </ul>
        </li>
             
        <li class="treeview">
          <a href="#">
            <i class="fa fa-user"></i> <span>Admin Users</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a> 
          <ul class="treeview-menu"> 
            <li><a href="admin-add-user.jsp"><i class="fa fa-circle-o"></i> Admin Add User</a></li>
          </ul>
          
        </li>   
        
        <li class="treeview">
          <a href="#">
            <i class="fa fa-building"></i> <span>Footer Text</span>
            <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
          </a> 
          <ul class="treeview-menu"> 
            <li><a href="footer-text.jsp"><i class="fa fa-circle-o"></i> Footer</a></li>
          </ul>
          
        </li>
        
                </ul>
                </li>
                  
        <%}} %>
        
        
        
        
        
        <li class="header">LABELS</li>
        <li><a href="#"><i class="fa fa-circle-o text-red"></i> <span>Important</span></a></li>
        <li><a href="#"><i class="fa fa-circle-o text-yellow"></i> <span>Warning</span></a></li>
        <li><a href="#"><i class="fa fa-circle-o text-aqua"></i> <span>Information</span></a></li>
      </ul>
      
        
    </section>
    <!-- /.sidebar -->
  </aside>