<%--
  Document : ftp4IT.jsp
  Created on : 2014
  Author : Tito Lino
  Utilidad: ftp tester
 --%>
 
 <%@ page import="org.apache.commons.net.ftp.FTPClient" %>
 <%@ page import="org.apache.commons.net.ftp.FTPReply" %>
 <%@ page import="java.io.*,java.net.InetAddress" %>

 
 <html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
<title>FTP Tester</title>


	
<style type="text/css"> 
body {
	font: normal .8em/1.5em Arial, Helvetica, sans-serif;
	background: #ebebeb;
	width: 100%;
	margin: 0px auto;
	color: #666;
}
a {
	color: #333;
}
#nav {
	margin: 0;
	padding: 7px 6px 0;
	line-height: 100%;
	border-radius: 2em;
 
	-webkit-border-radius: 2em;
	-moz-border-radius: 2em;
	
	-webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, .4);
	-moz-box-shadow: 0 1px 3px rgba(0, 0, 0, .4);
 
	background: #8b8b8b; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#a9a9a9', endColorstr='#7a7a7a'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#a9a9a9), to(#7a7a7a)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #a9a9a9,  #7a7a7a); /* for firefox 3.6+ */
 
	border: solid 1px #6d6d6d;
}
#nav li {
	margin: 0 5px;
	padding: 0 0 8px;
	float: left;
	position: relative;
	list-style: none;
}
/* main level link */
#nav a {
	font-weight: bold;
	color: #e7e5e5;
	text-decoration: none;
	display: block;
	padding:  8px 20px;
	margin: 0;
	-webkit-border-radius: 1.6em;
	-moz-border-radius: 1.6em;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .3);
}
/* main level link */
#nav select {
	font-weight: bold;
	color: #e7e5e5;
	text-decoration: none;
	display: block;
	padding:  8px 20px;
	margin: 0;
	-webkit-border-radius: 1.6em;
	-moz-border-radius: 1.6em;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .3);
}
/* main level link hover */
#nav .current a, #nav li:hover > a {
	background: #d1d1d1; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ebebeb', endColorstr='#a1a1a1'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#ebebeb), to(#a1a1a1)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #ebebeb,  #a1a1a1); /* for firefox 3.6+ */
 
	color: #444;
	border-top: solid 1px #f8f8f8;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	-moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	text-shadow: 0 1px 0 rgba(255, 255, 255, .8);
}
#nav .currentblue a, #nav li:hover > a {
	background: #d1d1d1; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ebebeb', endColorstr='#a1a1a1'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#ebebeb), to(#a1a1a1)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #ebebeb,  #a1a1a1); /* for firefox 3.6+ */
 
	color: #44f;
	border-top: solid 1px #f8f8f8;
	-webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	-moz-box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	box-shadow: 0 1px 1px rgba(0, 0, 0, .2);
	text-shadow: 0 1px 0 rgba(255, 255, 255, .8);
}
/* sub levels link hover */
#nav ul li:hover a, #nav li:hover li a {
	background: none;
	border: none;
	color: #666;
	-webkit-box-shadow: none;
	-moz-box-shadow: none;
}
#nav ul a:hover {
	background: #0399d4 !important; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#04acec', endColorstr='#0186ba'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#04acec), to(#0186ba)) !important; /* for webkit browsers */
	background: -moz-linear-gradient(top,  #04acec,  #0186ba) !important; /* for firefox 3.6+ */
 
	color: #fff !important;
	-webkit-border-radius: 0;
	-moz-border-radius: 0;
	text-shadow: 0 1px 1px rgba(0, 0, 0, .1);
}
/* level 2 list */
#nav ul {
	background: #ddd; /* for non-css3 browsers */
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#cfcfcf'); /* for IE */
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#cfcfcf)); /* for webkit browsers */
	background: -moz-linear-gradient(top,  #fff,  #cfcfcf); /* for firefox 3.6+ */
 
	display: none;
	margin: 0;
	padding: 0;
	width: 185px;
	position: absolute;
	top: 35px;
	left: 0;
	border: solid 1px #b4b4b4;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 1px 3px rgba(0, 0, 0, .3);
	-moz-box-shadow: 0 1px 3px rgba(0, 0, 0, .3);
	box-shadow: 0 1px 3px rgba(0, 0, 0, .3);
}
/* dropdown */
#nav li:hover > ul {
	display: block;
}
#nav ul li {
	float: none;
	margin: 0;
	padding: 0;
}
#nav ul a {
	font-weight: normal;
	text-shadow: 0 1px 1px rgba(255, 255, 255, .9);
}
/* level 3+ list */
#nav ul ul {
	left: 181px;
	top: -3px;
}
/* rounded corners for first and last child */
#nav ul li:first-child > a {
	-webkit-border-top-left-radius: 9px;
	-moz-border-radius-topleft: 9px;
	-webkit-border-top-right-radius: 9px;
	-moz-border-radius-topright: 9px;
}
#nav ul li:last-child > a {
	-webkit-border-bottom-left-radius: 9px;
	-moz-border-radius-bottomleft: 9px;
	-webkit-border-bottom-right-radius: 9px;
	-moz-border-radius-bottomright: 9px;
}
/* clearfix */
#nav:after {
	content: ".";
	display: block;
	clear: both;
	visibility: hidden;
	line-height: 0;
	height: 0;
}
#nav {
	display: inline-block;
}
html[xmlns] #nav {
	display: block;
}
* html #nav {
	height: 1%;
}
</style>
<script>
function ejecutar(){

	 var form = document.createElement("form");
	 form.setAttribute("method", "POST");
	
	 var hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_IP");
	  hiddenField.setAttribute("value", this.FTP_IP.value);
	  form.appendChild(hiddenField);
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_PORT");
	  hiddenField.setAttribute("value", this.FTP_PORT.value);
	  form.appendChild(hiddenField);	  
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_USER");
	  hiddenField.setAttribute("value", this.FTP_USER.value);
	  form.appendChild(hiddenField);	 	 

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_PASS");
	  hiddenField.setAttribute("value", this.FTP_PASS.value);
	  form.appendChild(hiddenField);	

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_BIN");
	  if (this.BINARY_CHECKED.checked==true)
		hiddenField.setAttribute("value", "true");
	  else
	    hiddenField.setAttribute("value", "false");
	  form.appendChild(hiddenField);	  
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_PASSI");
	  if (this.PASSIVE_CHECKED.checked==true)
		hiddenField.setAttribute("value", "true");
	  else
	    hiddenField.setAttribute("value", "false");
	  form.appendChild(hiddenField);	

	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_CHANGE");
	  if (this.CHANGE_PATH.checked==true)
		hiddenField.setAttribute("value", "true");
	  else
	    hiddenField.setAttribute("value", "false");
	  form.appendChild(hiddenField);	

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_BS");
	  hiddenField.setAttribute("value", this.FTP_BS.value);
	  form.appendChild(hiddenField);		  

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_FNO");
	  hiddenField.setAttribute("value", this.FILE_NAME_OR.value);
	  form.appendChild(hiddenField);		  

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "FTP_FND");
	  hiddenField.setAttribute("value", this.FILE_NAME_DE.value);
	  form.appendChild(hiddenField);		  
	  
      document.body.appendChild(form);
      form.submit();	
}
</script>
</head>

<body>
<hr>

 
 
 <%
   InetAddress host = null;
    host = InetAddress.getLocalHost();
    String nombreHost=host.getHostName();
	
	%><h3>CLON <%=nombreHost%> </h3><%
	
 FTPClient ftp;
 
 try
 {
   String ftp_ip= (String) request.getParameter("FTP_IP");if (ftp_ip == null) ftp_ip = "";	 
   String ftp_port= (String) request.getParameter("FTP_PORT");if (ftp_port == null) ftp_port = "";	 
   String ftp_user= (String) request.getParameter("FTP_USER");if (ftp_user == null) ftp_user = "";	 
   String ftp_pass= (String) request.getParameter("FTP_PASS");if (ftp_pass == null) ftp_pass = "";	 
   String ftp_bin= (String) request.getParameter("FTP_BIN");if (ftp_bin == null) ftp_bin = "false";
   String ftp_passi=(String) request.getParameter("FTP_PASSI");if (ftp_passi == null) ftp_passi = "false";
   String ftp_changePath=(String) request.getParameter("FTP_CHANGE");if (ftp_changePath == null) ftp_changePath = "false";
   String ftp_bs=(String) request.getParameter("FTP_BS");if (ftp_bs == null) ftp_bs = "10000";   
   String ftp_fn0=(String) request.getParameter("FTP_FNO");if (ftp_fn0 == null) ftp_fn0 = "/ArquitecturaE-business/Temp/";   
   String ftp_fnd=(String) request.getParameter("FTP_FND");if (ftp_fnd == null) ftp_fnd = "";      
   
 
 
   boolean b_ftp_bin = true; if (ftp_bin.equals("false")) b_ftp_bin=false;
   boolean b_ftp_passi = true; if (ftp_passi.equals("false")) b_ftp_passi=false;
   boolean b_ftp_changePath = true; if (ftp_changePath.equals("false")) b_ftp_changePath=false;

 
 ftp = new FTPClient();
 %>
 <h5>FTP IP-->  <input type="text" name="FTP_IP" value="<%=ftp_ip%>"></input>  FTP PORT-->  <input type="text" name="FTP_PORT" value="<%=ftp_port%>"></input> USER  -->  <input type="text" name="FTP_USER" value="<%=ftp_user%>"></input>  PASS-->  <input type="text" name="FTP_PASS" value="<%=ftp_pass%>"></input></h5>
 <h5>BINARY <input type="checkbox" name="BINARY_CHECKED" <% if (b_ftp_bin == true) {%>  checked   <%}%>></input>   PASSIVE <input type="checkbox" name="PASSIVE_CHECKED" <% if (b_ftp_passi == true) {%>  checked   <%}%>></input>    CHANGE_PATH <input type="checkbox" name="CHANGE_PATH" <% if (b_ftp_changePath == true) {%>  checked   <%}%>></input></h5>
 <h5>BUFFER SIZE --------->  <input type="text" name="FTP_BS" value="<%=ftp_bs%>"></input></h5>
 <h5>FILE ORIGIN NAME ---->  <input type="text" size="100" name="FILE_NAME_OR" value="<%=ftp_fn0%>"></input></h5>
 <h5>FILE DESTINY NAME  -->  <input type="text" size="100" name="FILE_NAME_DE"  value="<%=ftp_fnd%>"></input></h5> 
 <h5><button id="ejecutar" onclick="javascript:ejecutar()">Go!</button></h5>
 <%
 
 if (!ftp_ip.equals(""))
 {
 %><h3>CONNECTING TO <%=ftp_ip%>:<%=ftp_port%> </h3><%
 ftp.connect(ftp_ip, Integer.parseInt(ftp_port));
 
 int reply = ftp.getReplyCode();
 
 %><h3>REPLY CODE <%=reply%> </h3><%
 
 if (!FTPReply.isPositiveCompletion(reply)) 
 {
	%><h3>NO POSITIVE COMPLETION</h3><%
	ftp.disconnect();
 }
 else
 {
	%><h3>POSITIVE COMPLETION, continue setting size <%=ftp_bs%></h3><%
	ftp.setBufferSize(Integer.parseInt(ftp_bs));
 }
 
  %><h3>TRYING TO LOGIN WITH USER <%=ftp_user%> AND PASSWORD <%=ftp_pass%> </h3><%
  
 if (ftp.login(ftp_user,ftp_pass))
 {
	%><h3>LOGIN!!</h3><%
 }
 else
 {
	%><h3>LOGIN FAILED</h3><%
	ftp.disconnect(); 
 }

 boolean binary = b_ftp_bin; //Si el fichero fuera binario
 
 int fileType = 0;
 if (binary) 
 {
  %><h3>SET BINARY FYLE TRUE</h3><%
 fileType = 2;
 }
 else
 {
   %><h3>SET BINARY FYLE FALSE</h3><%
 }

 ftp.setFileType(fileType);

 boolean passive = b_ftp_passi;
 
 if (passive)
 {
   %><h3>SET PASSIVE TRUE</h3><%
   ftp.enterLocalPassiveMode();
 }
 else
 {
   %><h3>SET PASSIVE FALSE</h3><%
 }
 
 //Cambiar de path
 boolean changePath = b_ftp_changePath;
 
 if (changePath)
 {
	if (ftp.changeWorkingDirectory("/"))
	{
	  %><h3>PATH CHANGE SUCCESSFUL</h3><%
	}
	else
	{
	  %><h3>PATH CHANGE FAILS</h3><%
	  String[] replies2 = ftp.getReplyStrings();
	  if (replies2 != null && replies2.length > 0) 
	  {
			%><h3>REPLIES<%
			for (String aReply : replies2) {
				%><h3>sERVER: <%=aReply%><%
			}
	  }   	  
	}
 }
 else
 {
	%><h3>NO CHANGE PATH</h3><%
 }
 
 //Creamos inputStream
 String fileName = ftp_fn0;
 String destFileName = ftp_fnd;

 
 %><h3>IN FILE [ <%=fileName%> ]</h3><%
 %><h3>DEST NAME FILE [ <%=destFileName%> ]</h3><%
 
 File file = new File(fileName);
 FileInputStream fis = new FileInputStream(file);
	
 %><h3>TRYING TRANSFER...</h3><%
 
 ftp.sendSiteCommand("BLKSIZE=4332");
 ftp.sendSiteCommand("LRECL=4000");
 ftp.sendSiteCommand("RECFM=FB");
 ftp.sendSiteCommand("quote site sbdataconn=(IBM-284,ISO8859-1)");
 
 if (ftp.storeFile(destFileName, fis))
 {
   %><h3>SUCCESSFUL!!!</h3><%
 }
 else
 {
   %><h3>NOOOOOOOOO JAJAJA TE JODES!!!</h3><%
   
   reply = ftp.getReplyCode();
   %><h3>REPLY CODE <%=reply%> </h3><%
   
 String[] replies = ftp.getReplyStrings();
 if (replies != null && replies.length > 0) 
 {
	%><h3>REPLIES<%
	for (String aReply : replies) {
		%><h3>SERVER: <%=aReply%><%
	}
 }   
   
 }


 
 }
 } 
 catch (Exception e)
 {
	%><h3>EXCEPTION!!!</h3><%
	StackTraceElement[] elements = e.getStackTrace();
    for(int i=0; i<elements.length; i++) {
        %><h3><%=elements[i]%></h3><%
     }
 }
 
 


 %>
</body>
</html>