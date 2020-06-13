package com.easybooking.confirmation;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import com.teknikindustries.bulksms.SMS;


public class EmailSMSSending {
	public void email(String to , String user , String password , String SSL_FACTORY , String userName , 
			String marqueeName , String eventName ,String shift ,String bookedDate , double advance , double cost){
		try {  
			 
			//Compose the message  
			 
			
			 Properties props = new Properties();  
			   props.setProperty("mail.smtp.host", "smtp.gmail.com");
			   props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
			   props.setProperty("mail.smtp.socketFactory.fallback", "false");
			   props.setProperty("mail.smtp.port", "465");
			   props.setProperty("mail.smtp.socketFactory.port", "465");
			   props.put("mail.smtp.auth", "true");
			   props.put("mail.debug", "true");
			   props.put("mail.store.protocol", "pop3");
			   props.put("mail.transport.protocol", "smtp");

			 Session session1 = Session.getDefaultInstance(props,  
					    new javax.mail.Authenticator() {  
					      protected PasswordAuthentication getPasswordAuthentication() {  
					    return new PasswordAuthentication(user,password);  
					      }  
					    });
		     MimeMessage message = new MimeMessage(session1);      
		     message.setFrom(new InternetAddress(user));  
		     message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
		     message.setSubject("Congrats Your Booking Is Confirmed");  
		  
	        /* Pass Properties object(props) and Authenticator object   
	           for authentication to Session instance 
	        */

//	        Session session1 = Session.getInstance(properties,new javax.mail.Authenticator()
//	        {
//	            protected PasswordAuthentication getPasswordAuthentication()
//	            {
//	  	 	         return new PasswordAuthentication(user,password); 
//	            }
//	        });
		     
		     
		     String text = "Dear "+userName;
//		     String html = "<h1>" + text + "</h1>";
		     
		     
		     String html = "<h3>"+text+"</h3><p>Congrat's "+marqueeName+" Marquee Is Booked</p><!DOCTYPE html>"+
"<html>"+
"<head>"+
"<style>"+
"#customers { "+
" font-family: 'Trebuchet MS', Arial, Helvetica, sans-serif; "+
" border-collapse: collapse; "+
" width: 100%;"+
"}"+

"#customers td, #customers th {"+
" border: 1px solid #ddd; "+
" padding: 8px; "+
"}"+

"#customers tr:nth-child(even){background-color: #f2f2f2;}"+

"#customers tr:hover {background-color: #ddd;}"+

"#customers th {"+
" padding-top: 12px;"+
" padding-bottom: 12px;"+
" text-align: left; "+
" background-color: #4CAF50; "+
" color: white;"+
"}"+
" </style>"+
"</head>"+
"<body>"+

"<table id='customers'>"+
"<tr>"+
"<th colspan='2'>Event Detail's</th>"+
"</tr>"+
"<tr>"+
" <td>Marquee Name </td>"+ 
"<td>"+marqueeName+"</td>"+
"</tr>"+ 
"<tr>"+
" <td>Event Name </td>"+ 
"<td>"+eventName+"</td>"+
"</tr>"+
"<tr>"+
" <td>Shift</td>"+
"<td>"+shift+"</td>"+
"</tr>"+
"<tr>"+
"<td>Event Date</td>"+
"<td>"+bookedDate+"</td>"+
"</tr>"+
"<tr>"+
"<td>Advance</td>"+
"<td>"+advance+"</td>"+  
"</tr>"+
"<tr>"+
"<td>Total Cost</td>"+
"<td>"+cost+"</td>"+  
"</tr>"+ 
"</table>"+

"</body>"+
"</html>";				     


		     
		     Multipart multipart = new MimeMultipart( "alternative" );

		     MimeBodyPart textPart = new MimeBodyPart();
		     textPart.setText( text, "utf-8" );

		     MimeBodyPart htmlPart = new MimeBodyPart();
		     htmlPart.setContent( html, "text/html; charset=utf-8" );

		     multipart.addBodyPart( textPart );
		     multipart.addBodyPart( htmlPart );
		     message.setContent( multipart );

		     // Unexpected output.
		     System.out.println( "HTML = text/html : " + htmlPart.isMimeType( "text/html" ) );
		     System.out.println( "HTML Content Type: " + htmlPart.getContentType() );

		     // Required magic (violates principle of least astonishment).
		     message.saveChanges(); 
		      
		    //send the message  
		     Transport.send(message);  
		  
		     System.out.println("message sent successfully...  "+to);  
		   
		     
		     
		     
		     
		     
		     } catch (MessagingException e) {e.printStackTrace();}  

		/**
		Email Sending
	*/


	}
	
	public void smsSend(String userName , String password,String msg , String number , String url){
		try{
		SMS sms = new SMS(); 
		sms.SendSMS("easybooking", "bilal@123", "Hello Bilal " , "+923410322154",
				"https://bulksms.vsms.net/eapi/submission/send_sms/2/2.0");
	 
		}
		catch(Exception e){
			System.out.println(e.getStackTrace());
		}
	}
}
