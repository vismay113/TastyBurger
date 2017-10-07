/*
 * This is the mail business object. It is responsible for sending emails for confirmation code to the new registered users.
 */
package com.tastyBurger.BO;

import java.util.*;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author VBlue
 */
public class mailBO {
    
    public void sendMail(String email, int code) throws Exception {
		
		final String username = "noreplytastyburger@gmail.com";
		final String password = "T@$ty123Burger";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		
		Session session = Session.getInstance(props,
				  new javax.mail.Authenticator() {
                                        @Override
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(username, password);
					}
				  });

	    try {
	        MimeMessage msg = new MimeMessage(session);
	        msg.setFrom();
	        msg.setRecipients(Message.RecipientType.TO,email);
	        msg.setSubject("Account Confirmation");
	        msg.setSentDate(new Date());
	        msg.setText("Your Tasty Burger account confirmation code is : " +code);
	        Transport.send(msg);
                System.out.println("Email sent");
	    } catch (MessagingException mex) {
	        System.out.println("send failed, exception: " + mex);
	    }
	}
    
}
