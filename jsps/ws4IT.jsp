<%--
  Document : ftpSN3.jsp
  Created on : 2014
  Author : Er Lino
  Utilidad: todos los beans, modificar valores y llamar ops
 --%>
 
<%@page contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="HTTPClient.HTTPConnection" %>
<%@ page import="HTTPClient.HTTPResponse" %>
<%@ page import="HTTPClient.NVPair" %>
<%@ page import="HTTPClient.Log" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.isb.rigel.common.util.NameValuePair" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@ page import="com.ibm.websphere.ssl.JSSEHelper" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.*" %>
<%@ page import="java.security.*" %>
<%@ page import="javax.net.ssl.*" %>




 
 <html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	
<title>SN3 WS</title>


	
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
	  hiddenField.setAttribute("name", "XML");
	  hiddenField.setAttribute("value", this.XML.value);
	  form.appendChild(hiddenField);
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "ENDPOINT");
	  hiddenField.setAttribute("value", this.ENDPOINT.value);
	  form.appendChild(hiddenField);	  
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SOAPACTION");
	  hiddenField.setAttribute("value", this.SOAPACTION.value);
	  form.appendChild(hiddenField);	 

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SENDSOAPACTION");
	  if (this.SENDSOAPACTION.checked==true)
		hiddenField.setAttribute("value", "true");
	  else
	    hiddenField.setAttribute("value", "false");
	  form.appendChild(hiddenField);	  

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_ALIAS");
	  hiddenField.setAttribute("value", this.SSL_ALIAS.value);
	  form.appendChild(hiddenField);	
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_TRUSTSTORE");
	  hiddenField.setAttribute("value", this.SSL_TRUSTSTORE.value);
	  form.appendChild(hiddenField);	

	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_TRUSTSTORE_LOCAL");
	  if (this.SSL_TRUSTSTORE_LOCAL.checked==true)
		hiddenField.setAttribute("value", "true");
	  else
	    hiddenField.setAttribute("value", "false");
	  form.appendChild(hiddenField);		  

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_TRUSTSTORETYPE");
	  hiddenField.setAttribute("value", this.SSL_TRUSTSTORETYPE.value);
	  form.appendChild(hiddenField);		

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_TRUSTSTOREPASSWORD");
	  hiddenField.setAttribute("value", this.SSL_TRUSTSTOREPASSWORD.value);
	  form.appendChild(hiddenField);	  
	  
	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_TRUSTSTORENAME");
	  hiddenField.setAttribute("value", this.SSL_TRUSTSTORENAME.value);
	  form.appendChild(hiddenField);			  

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_TRUSTSTOREFILEBASED");
	  if (this.SSL_TRUSTSTOREFILEBASED.checked==true)
		hiddenField.setAttribute("value", "true");
	  else
	    hiddenField.setAttribute("value", "false");
	  form.appendChild(hiddenField);

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "PROXY");
	  hiddenField.setAttribute("value", this.PROXY.value);
	  form.appendChild(hiddenField);		

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "PUERTO");
	  hiddenField.setAttribute("value", this.PUERTO.value);
	  form.appendChild(hiddenField);	

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "AUTHTYPE");
	  hiddenField.setAttribute("value", this.AUTHTYPE.value);
	  form.appendChild(hiddenField);	 

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "REALMNAME");
	  hiddenField.setAttribute("value", this.REALMNAME.value);
	  form.appendChild(hiddenField);		


	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "USER_PROXY");
	  hiddenField.setAttribute("value", this.USER_PROXY.value);
	  form.appendChild(hiddenField);	


	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "PASS_PROXY");
	  hiddenField.setAttribute("value", this.PASS_PROXY.value);
	  form.appendChild(hiddenField);	


	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "USER_AGENT");
	  hiddenField.setAttribute("value", this.USER_AGENT.value);
	  form.appendChild(hiddenField);	

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "CHARSET");
	  hiddenField.setAttribute("value", this.CHARSET.value);
	  form.appendChild(hiddenField);	

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "ISHTMLFORMENCODING");
	  if (this.ISHTMLFORMENCODING.checked==true)
		hiddenField.setAttribute("value", "true");
	  else
	    hiddenField.setAttribute("value", "false");
	  form.appendChild(hiddenField);	

	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "CLIENTE");
	  hiddenField.setAttribute("value", this.CLIENTE.value);
	  form.appendChild(hiddenField);		


	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "HTTPCLIENTLOG");
	  hiddenField.setAttribute("value", this.HTTPCLIENTLOG.value);
	  form.appendChild(hiddenField);		


	  hiddenField = document.createElement("input");
	  hiddenField.setAttribute("type", "hidden");
	  hiddenField.setAttribute("name", "SSL_PROTOCOL");
	  hiddenField.setAttribute("value", this.SSL_PROTOCOL.value);
	  form.appendChild(hiddenField);

      document.body.appendChild(form);
      form.submit();	
}
</script>
</head>

<body>

 <%
 
	TrustManager[] trustAllCerts = new TrustManager[]{
		new X509TrustManager() {
		public java.security.cert.X509Certificate[] getAcceptedIssuers() {
		return null;
	}
		public void checkClientTrusted( java.security.cert.X509Certificate[] certs, String authType) {}
		public void checkServerTrusted( java.security.cert.X509Certificate[] certs, String authType) {}
	}
	}; 
 
 
   InetAddress host = null;
    host = InetAddress.getLocalHost();
    String nombreHost=host.getHostName();
	
	%><h3>WS CALLER FOR BKS - CLON <%=nombreHost%> </h3><%
	%><h4 style="color:red">Please remember activate <b><u>javax.net.debug to ALL</b></u>. Another interesting log levels <a href="http://www.ibm.com/developerworks/websphere/library/techarticles/0803_adams/0803_adams.html" target="_blank" style="color:red">here</a></h4><%
 
 try
 {
   String xml= (String) request.getParameter("XML");if (xml == null) xml = "";	 
   String endpoint = (String) request.getParameter("ENDPOINT");if (endpoint == null) endpoint = "";	 
   String soapaction = (String) request.getParameter("SOAPACTION");if (soapaction == null) soapaction = "";	 
   String sendsoapaction =(String) request.getParameter("SENDSOAPACTION");if (sendsoapaction == null) sendsoapaction = "false";   
   String ssl_alias= (String) request.getParameter("SSL_ALIAS");if (ssl_alias == null) ssl_alias = "";	 
   String ssl_truststore = (String) request.getParameter("SSL_TRUSTSTORE");if (ssl_truststore == null) ssl_truststore = "";	    
   String ssl_truststorelocal =(String) request.getParameter("SSL_TRUSTSTORE_LOCAL");if (ssl_truststorelocal == null) ssl_truststorelocal = "false";   
   String ssl_truststoretype = (String) request.getParameter("SSL_TRUSTSTORETYPE");if (ssl_truststoretype == null) ssl_truststoretype = "";	       
   String ssl_truststorepassword = (String) request.getParameter("SSL_TRUSTSTOREPASSWORD");if (ssl_truststorepassword == null) ssl_truststorepassword = "";   
   String ssl_truststorename = (String) request.getParameter("SSL_TRUSTSTORENAME");if (ssl_truststorename == null) ssl_truststorename = "";      
   String ssl_truststorefilebased =(String) request.getParameter("SSL_TRUSTSTOREFILEBASED");if (ssl_truststorefilebased == null) ssl_truststorefilebased = "false";      
   String proxy = (String) request.getParameter("PROXY");if (proxy == null) proxy = "";      
   String puerto = (String) request.getParameter("PUERTO");if (puerto == null) puerto = "";
   String authtype = (String) request.getParameter("AUTHTYPE");if (authtype == null) authtype = "";
   String realmname = (String) request.getParameter("REALMNAME");if (realmname == null) realmname = "";
   String user_proxy = (String) request.getParameter("USER_PROXY");if (user_proxy == null) user_proxy = "";
   String pass_proxy = (String) request.getParameter("PASS_PROXY");if (pass_proxy == null) pass_proxy = "";
   String user_agent = (String) request.getParameter("USER_AGENT");if (user_agent == null) user_agent = "XMLClient";
   String charset = (String) request.getParameter("CHARSET");if (charset == null) charset = "UTF-8";
   String ishtmlformencoding =(String) request.getParameter("ISHTMLFORMENCODING");if (ishtmlformencoding == null) ishtmlformencoding = "false";    
   String cliente = (String) request.getParameter("CLIENTE");if (cliente == null) cliente = "httpClient";   
   String httpclientlog = (String) request.getParameter("HTTPCLIENTLOG");if (httpclientlog == null) httpclientlog = "/ArquitecturaE-business/Temp/httpclient.log";   
   String ssl_protocol = (String) request.getParameter("SSL_PROTOCOL");if (ssl_protocol == null) ssl_protocol = "SSL_TLS";       

   boolean b_send_soapaction = true; if (sendsoapaction.equals("false")) b_send_soapaction=false;   
   boolean b_truststorelocal = true; if (ssl_truststorelocal.equals("false")) b_truststorelocal=false;      
   boolean b_truststorefilebased = true; if (ssl_truststorefilebased.equals("false")) b_truststorefilebased=false;         
   boolean b_ishtmlformencoding = true; if (ishtmlformencoding.equals("false")) b_ishtmlformencoding=false;     


 %>
 <h5>IN XML-->  <textarea id="XML" rows="10" cols="70"><%=xml%></textarea></h5>
 <h5>ENDPOINT-->  <input type="text" size="80" name="ENDPOINT" value="<%=endpoint%>"></input>  SOAP ACTION-->  <input type="text" size="80" name="SOAPACTION" value="<%=soapaction%>"></input>-->Send? <input type="checkbox" name="SENDSOAPACTION" <% if (b_send_soapaction == true) {%>  checked   <%}%>></input></h5>
 <h5><b><u>SSL CONFIGURATION (FOR SSL CONNECTIONS, NOT HTTPCLIENT!! (only uses server SSL config, you can see it in /opt/WebSphere7/AppServer/profiles/Node01/properties/ssl.client.props)</b></u></h5>
 <h5>ALIAS-->   <input type="text" name="SSL_ALIAS" value="<%=ssl_alias%>"></input>  TRUSTSTORE PATH -->   <input type="text" size="100" name="SSL_TRUSTSTORE" value="<%=ssl_truststore%>"></input>-->Local? <input type="checkbox" name="SSL_TRUSTSTORE_LOCAL" <% if (b_truststorelocal == true) {%>  checked   <%}%>></input></h5>
 <h5>TRUSTSTORE TYPE-->   <input type="text" name="SSL_TRUSTSTORETYPE" value="<%=ssl_truststoretype%>"></input> PROTOCOL-->   <input type="text" size="10" name="SSL_PROTOCOL" value="<%=ssl_protocol%>"></input>  TRUSTSTORE PASSWORD -->   <input type="text" name="SSL_TRUSTSTOREPASSWORD" value="<%=ssl_truststorepassword%>"></input>  TRUSTSTORE NAME -->   <input type="text" name="SSL_TRUSTSTORENAME" value="<%=ssl_truststorename%>"></input>-->fileBased? <input type="checkbox" name="SSL_TRUSTSTOREFILEBASED" <% if (b_truststorefilebased == true) {%>  checked   <%}%>></input></h5> 
 <h5><b><u>PROXY CONFIGURATION</b></u></h5>
 <h5>PROXY-->  <input type="text" name="PROXY" value="<%=proxy%>"></input>  PORT-->  <input type="text" name="PUERTO" value="<%=puerto%>"></input>USER-->  <input type="text" name="USER_PROXY" value="<%=user_proxy%>"></input>  PORT-->  <input type="text" name="PASS_PROXY" value="<%=pass_proxy%>"></input></h5>
 <h5>AUTH TYPE-->  <input type="text" name="AUTHTYPE" value="<%=authtype%>"></input>  REALM NAME-->  <input type="text" name="REALMNAME" value="<%=realmname%>"></input></h5> 
 <h5>USER AGENT-->  <input type="text" name="USER_AGENT" value="<%=user_agent%>"></input>  CHARSET-->  <input type="text" name="CHARSET" value="<%=charset%>"></input>-->Is html? <input type="checkbox" name="ISHTMLFORMENCODING" <% if (b_ishtmlformencoding == true) {%>  checked   <%}%>></input></h5> 
 <h5>LOG PATH (IF HTTPCLIENT SELECTED**) -->  <input type="text" size="100" name="HTTPCLIENTLOG" value="<%=httpclientlog%>"></input></h5> 
 <h5> ** ALL DEBUG INFO APPEARS IN SYSTEMOUT,SYSTEMERR AND TRACE.LOG (IF JAVAX DEBUG ENABLED). HTTPCLIENT HAVE (ALSO) AN OWN FILE</h5> 
 <h5><b><u>CLIENT</b></u></h5>

 <h5><select name="CLIENTE"><option value="httpClient" <% if (cliente.equals("httpClient")) {%>  selected="selected"   <%}%>>httpClient</option><option value="urlConn" <% if (cliente.equals("urlConn")) {%>  selected="selected"   <%}%>>urlConn</option></select></h5>
 <h5><button id="ejecutar" onclick="javascript:ejecutar()">Go!</button></h5>

  <%
      if (!endpoint.equals(""))
	  {
	  %>
     <h4>CALLING!!!!</h4>
	  <%
	  
	  System.out.println("Me traigo el logger");
	  java.util.logging.Logger logger = java.util.logging.Logger.getLogger("sun.net.www.protocol.http.HttpURLConnection");
	  System.out.println("Me traigo el logger que es [" + logger.getLevel() + "]");
	  logger.setLevel(java.util.logging.Level.ALL);
	   System.out.println("Me traigo el logger que es [" + logger + "]");
	   System.out.println("Me traigo el logger que es [" + logger.getLevel() + "]");
	   
	   java.util.logging.Handler ch = new  java.util.logging.ConsoleHandler();
	     System.out.println("Me traigo el ch que es [" + ch.getLevel() + "]");
	   ch.setLevel(java.util.logging.Level.ALL);
	   System.out.println("Me traigo el ch que es [" + ch.getLevel() + "]");
	   logger.addHandler(ch);
	   
	   java.util.logging.Handler fh = new java.util.logging.FileHandler("/ArquitecturaE-business/Temp/aa.log");
	   fh.setLevel(java.util.logging.Level.ALL);
	   logger.addHandler(fh);
	  
	  URL url = new URL(endpoint);
      NameValuePair[] formParams = (NameValuePair[])null;
      Map optionalHeaders = new HashMap();
      int defaultTimeOut = 50000;
      optionalHeaders.put("SOAPAction", soapaction);
	  

	  String miprotocol = endpoint.substring(0,endpoint.indexOf(":"));
	  
	  
	  if (cliente.equals("httpClient"))
	  {
  
	  HTTPClient.Log.setLogging(255,true);
	  HTTPClient.Log.setLogWriter(new FileWriter(httpclientlog), true);

	  
	
	
      HTTPResponse httpResponse = writeRequest(xml, url, endpoint, formParams, optionalHeaders, defaultTimeOut,proxy,puerto,authtype,
											   realmname,user_proxy,pass_proxy,b_send_soapaction,user_agent,b_ishtmlformencoding,charset);
	  
      Object[] result = new Object[4];
      Object[] result2 = new Object[4];

      result[1] = httpResponse.getReasonLine();

      int statusCode = httpResponse.getStatusCode();

      result[0] = new Integer(statusCode);

	  %>

     <h4>RECEIVE_HTTP_CODE [ <%=result[0]%> ][  <%=result[1]%>]</h4>

     <h4>Reason Line [ <%=httpResponse.getReasonLine()%>]</h4>

      <h4>Status Code [<%=httpResponse.getStatusCode()%>]</h4>

      <h4>Response [<%=StringEscapeUtils.escapeXml(new String(httpResponse.getData()))%>]</h4>
	  <%	  
	  }
	  else if ((cliente.equals("urlConn")) && (miprotocol.equals("https")))
	  {
	  
	  System.out.println("XML_TO_SEND ws2 jsp URLCONN [" + xml + "]");
	  System.setProperty("javax.net.debug","ALL");

	  Properties sslProperties = new Properties();
	  
      //sslProperties.setProperty("ssl.SocketFactory.provider", "com.ibm.jsse2.SSLSocketFactoryImpl");
      //sslProperties.setProperty("ssl.ServerSocketFactory.provider", "com.ibm.jsse2.SSLServerSocketFactoryImpl");
      //sslProperties.setProperty("javax.net.SocketFactory", "com.ibm.jsse2.SSLServerSocketFactoryImpl");
      //sslProperties.setProperty("ssl.SocketFactory.provider", "com.ibm.jsse2.SSLSocketFactoryImpl");
      //sslProperties.setProperty("ssl.ServerSocketFactory.provider", "com.ibm.jsse2.SSLServerSocketFactoryImpl");
      //sslProperties.setProperty("javax.net.SocketFactory", "com.ibm.jsse2.SSLServerSocketFactoryImpl");
      //sslProperties.setProperty("com.ibm.ssl.daysBeforeExpireWarning", "60");
      //sslProperties.setProperty("com.ibm.ssl.contextProvider", "IBMJSSE2");
      //sslProperties.setProperty("com.ibm.ssl.keyManager", "IbmX509");
      //sslProperties.setProperty("com.ibm.ssl.clientAuthentication", "false");
      //sslProperties.setProperty("com.ibm.ssl.trustStoreProvider", "IBMJCE");
      //sslProperties.setProperty("com.ibm.ssl.keyStoreClientAlias", "le-83e8a921-8ec9-4d47-99af-25c797fb498e");
      //sslProperties.setProperty("com.ibm.ssl.trustManager", "PKIX");
      //sslProperties.setProperty("com.ibm.ssl.tokenEnabled", "false");
      //sslProperties.setProperty("com.ibm.ssl.securityLevel", "HIGH");
      //sslProperties.setProperty("com.ibm.ssl.validationEnabled", "false");
      //sslProperties.setProperty("com.ibm.ssl.keyStoreProvider", "IBMJCE");

      //sslProperties.setProperty("com.ibm.ssl.keyStorePassword", "AEAT");
	  //sslProperties.setProperty("com.ibm.ssl.keyStoreName", "");
      //sslProperties.setProperty("com.ibm.ssl.keyStoreFileBased", "true");	
      //sslProperties.setProperty("com.ibm.ssl.alias", "needed_alias");	
      //sslProperties.setProperty("com.ibm.ssl.keyStore", "D:\\aaa\\certi Ana\\FNMT - SC EFC FEBRERO 2017 - AFdeBS.pfx");	
      //sslProperties.setProperty("om.ibm.ssl.keyStoreType", "PKCS12");		

      if (!ssl_alias.equals("")) sslProperties.setProperty("com.ibm.ssl.alias", ssl_alias);
	  if (!ssl_truststore.equals("")) sslProperties.setProperty("com.ibm.ssl.trustStore", ssl_truststore);
	  if (!ssl_truststoretype.equals("")) sslProperties.setProperty("com.ibm.ssl.trustStoreType", ssl_truststoretype);
	  if (!ssl_truststorepassword.equals("")) sslProperties.setProperty("com.ibm.ssl.trustStorePassword", ssl_truststorepassword);
	  if (!ssl_truststorename.equals("")) sslProperties.setProperty("com.ibm.ssl.trustStoreName", ssl_truststorename);
	  if (!ssl_truststorefilebased.equals("")) sslProperties.setProperty("com.ibm.ssl.trustStoreFileBased", ssl_truststorefilebased);
	  if (!ssl_protocol.equals("")) sslProperties.setProperty("com.ibm.ssl.protocol", ssl_protocol);	  

	  JSSEHelper jsseHelper = JSSEHelper.getInstance();
      jsseHelper.setSSLPropertiesOnThread(sslProperties);	  
	  
	  String ssl_protocol_part = ssl_protocol;
	  //if (ssl_protocol_part.startsWith("TLS")) ssl_protocol_part = "TLS";
	  
      SSLContext sc = SSLContext.getInstance(ssl_protocol_part);  	 
      KeyManagerFactory kmf = KeyManagerFactory.getInstance(KeyManagerFactory.getDefaultAlgorithm());
	  
	  if (!ssl_truststoretype.equals(""))
	  { 	  
	  KeyStore ks = KeyStore.getInstance(ssl_truststoretype);
      FileInputStream fis = new FileInputStream(ssl_truststore);

	  if (ssl_truststorepassword.equals(""))
	    ks.load(fis, null);
	  else
        ks.load(fis, ssl_truststorepassword.toCharArray());
		
	  TrustManagerFactory tmfactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm());	  
	  
	  if (ssl_truststorepassword.equals(""))
	  {
	    kmf.init(ks, null);
	  }
	  else
	  {
        kmf.init(ks, ssl_truststorepassword.toCharArray());  
	  }
	  
	  tmfactory.init(ks); 
	  
	  sc.init(kmf.getKeyManagers(), tmfactory.getTrustManagers(), new SecureRandom());	  
	  }
	  else
	  {
        sc.init(null, trustAllCerts, new SecureRandom());	  
	  }
	  
      javax.net.ssl.SSLSocketFactory sslSocketFactory = null;
      sslSocketFactory = sc.getSocketFactory();

	  Proxy miProxy = null;
	  if (!proxy.equals(""))
        miProxy = new Proxy(java.net.Proxy.Type.HTTP, new InetSocketAddress(proxy, Integer.parseInt(puerto)));
        URL httpURL = new URL(null, endpoint);
        //URLConnection con = null;
		HttpsURLConnection con = null;
			
	  if (!proxy.equals(""))
        con = (HttpsURLConnection)httpURL.openConnection(miProxy);
	  else
		con = (HttpsURLConnection)httpURL.openConnection();
		
		
      //((HttpsURLConnection)con).setSSLSocketFactory(sslSocketFactory);
	  con.setSSLSocketFactory(sslSocketFactory);
	  

	  if ((!user_proxy.equals("")) && (!pass_proxy.equals("")))
	  {
	  Authenticator.setDefault(new CustomAuthenticator(user_proxy,pass_proxy));
	  if (!realmname.equals(""))
	   con.setRequestProperty("Proxy-Authenticate", "Basic realm=" + realmname);
	  String userPassword = user_proxy + ":" + pass_proxy;
      //String encodedLogin = encode64(userPassword);
	  String encodedLogin = Base64.encodeBase64String(userPassword.getBytes());
	  System.out.println("TOKEN PARA PROXY [" + encodedLogin + "]");
	  con.setRequestProperty("Proxy-Authorization", (new StringBuilder("Basic ")).append(encodedLogin).toString());
	  
	  //con.setRequestProperty("Proxy-Authorization", "Basic U0FOXFQwMTE2NjQ6ZjBjTllaZUswUWdpMlVwY002a28=");
	  //System.out.println("Añado la header Basic U0FOXFQwMTE2NjQ6ZjBjTllaZUswUWdpMlVwY002a28= a pelo!!!!");
	  

	  }
	  
      try
      {
		    con.setDoInput(true);
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-type", "text/xml");        
			
			if (!soapaction.equals(""))
				con.setRequestProperty("SOAPAction", soapaction);
	  
			OutputStream out2 = con.getOutputStream();
			OutputStreamWriter wout = new OutputStreamWriter(out2, "UTF-8");
			wout.write(xml);
			wout.flush();
			out2.close();
	  
            con.connect();

			
			
			
			%><h4>Response Headers--> </h4><%
			Map<String, List<String>> map = con.getHeaderFields();

			for (Map.Entry<String, List<String>> entry : map.entrySet()) {
					%><h4>Key : <%=entry.getKey()%> Value : <%=entry.getValue()%></h4><%
			}			
			
			%><h4>RECEIVE_HTTP_CODE [ <%=con.getResponseCode()%> ]</h4><%

			%><h4>Response Message[<%=con.getResponseMessage()%>]</h4><%
					
			%><h4>Response --> </h4><%
			
			
			
			InputStream in = null;

			if (con.getResponseCode() == 200) 
			  in = con.getInputStream();
			else
			  in = con.getErrorStream();

			int c;
			String salida = "";
			while ((c=in.read()) != -1)
			{
            salida = salida + (char) c;
			}
			

			 
			 %><h4><textarea id="XML2" rows="10" cols="200"><%=salida%></textarea></h4><%		
			
        }
        catch(Exception e2)
		{
			e2.printStackTrace();
			%><h3>EXCEPTION!!! (review systemout/systemerr)</h3><%
			StackTraceElement[] elements2 = e2.getStackTrace();
			for(int i=0; i<elements2.length; i++) {
				%><h3><%=elements2[i]%></h3><%
			}  
		}

	  
	  }
	  else if ((cliente.equals("urlConn")) && (miprotocol.equals("http")))
	  {
			  System.out.println("XML_TO_SEND ws2 jsp URLCONN/HTTP [" + xml + "]");
			  
			Proxy miProxy = null;
			if (!proxy.equals(""))
				miProxy = new Proxy(java.net.Proxy.Type.HTTP, new InetSocketAddress(proxy, Integer.parseInt(puerto)));
			URL httpURL = new URL(null, endpoint);
			HttpURLConnection con = null;

			
			if (!proxy.equals(""))
				con = (HttpURLConnection)httpURL.openConnection(miProxy);
			else
				con = (HttpURLConnection)httpURL.openConnection();			  
			  
			if ((!user_proxy.equals("")) && (!pass_proxy.equals("")))
			{
				Authenticator.setDefault(new CustomAuthenticator(user_proxy,pass_proxy));
				if (!realmname.equals(""))
					con.setRequestProperty("Proxy-Authenticate", "Basic realm=" + realmname);			
				String userPassword = user_proxy + ":" + pass_proxy;
				//String encodedLogin = encode64(userPassword);
				String encodedLogin = Base64.encodeBase64String(userPassword.getBytes());
				System.out.println("TOKEN PARA PROXY [" + encodedLogin + "]");
				con.setRequestProperty("Proxy-Authorization", (new StringBuilder("Basic ")).append(encodedLogin).toString());
				
					//  con.setRequestProperty("Proxy-Authorization", "Basic U0FOXFQwMTE2NjQ6ZjBjTllaZUswUWdpMlVwY002a28=");
						//System.out.println("Añado la header Basic U0FOXFQwMTE2NjQ6ZjBjTllaZUswUWdpMlVwY002a28= a pelo!!!!");

			}			  
			
			try
			{
			System.out.println("XML_TO_SEND ws2 jsp URLCONN/HTTP [" + xml + "]");
			
		    con.setDoInput(true);
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("Content-type", "text/xml;charset=UTF-8");        
			
			if (!soapaction.equals(""))
				con.setRequestProperty("SOAPAction", soapaction);
	  
			OutputStream out2 = con.getOutputStream();
			OutputStreamWriter wout = new OutputStreamWriter(out2, "UTF-8");
			wout.write(xml);
			wout.flush();
			out2.close();
	  
            con.connect();
			
			%><h4>Response Headers--> </h4><%
			Map<String, List<String>> map = con.getHeaderFields();

			for (Map.Entry<String, List<String>> entry : map.entrySet()) {
					%><h4>Key : <%=entry.getKey()%> Value : <%=entry.getValue()%></h4><%
			}				

			
			%><h4>RECEIVE_HTTP_CODE [ <%=con.getResponseCode()%> ]</h4><%

			%><h4>Response Message[<%=con.getResponseMessage()%>]</h4><%
			
			%><h4>Response --> </h4><%
			
			InputStream in = null;

			if (con.getResponseCode() == 200) 
			  in = con.getInputStream();
			else
			  in = con.getErrorStream();

			int c;
			String salida = "";
			while ((c=in.read()) != -1)
			{
            salida = salida + (char) c;
			}
			

			 
			 %><h4><textarea id="XML3" rows="10" cols="200"><%=salida%></textarea></h4><%				
			
			

        }
        catch(Exception e2)
		{
			e2.printStackTrace();
			%><h3>EXCEPTION!!! (review systemout/systemerr)</h3><%
			StackTraceElement[] elements2 = e2.getStackTrace();
			for(int i=0; i<elements2.length; i++) {
				%><h3><%=elements2[i]%></h3><%
			}  
		}			
			
			
	  }
	  
	  
	  }
  
  
  
  }
  catch (Exception e)
  {
    e.printStackTrace();
	%><h3>EXCEPTION!!! (review systemout/systemerr)</h3><%
	StackTraceElement[] elements = e.getStackTrace();
    for(int i=0; i<elements.length; i++) {
        %><h3><%=elements[i]%></h3><%
     }  
  }
  
 %>  
 
   <%!
  public HTTPResponse writeRequest(String dataToSend, URL url, String serviceName, NameValuePair[] formParams, Map optionalHeaders, int defaultTimeOut,
  String proxyHost, String puerto, String authenticationType, String realmName,String usuAut,String passAut,boolean sendSoapAction,String userAgent,
  boolean isHtmlFormEncoding,String charset)
    throws Exception
  {
    //String proxyHost = null;  poner a null para no proxy
	//String proxyHost = null;
    int proxyPort = 8080;
    //String authenticationType = null;   poner a null para no proxy
    //String realmName = "BWRealm";
    //String usuAut = null;   //poner a null para no proxy
    //String passAut = "Asterix1509";
    //boolean sendSoapAction = false;
    //String userAgent = "XMLClient";
    //boolean isHtmlFormEncoding = false;
    //String charset = "UTF-8";
	
	
	if (proxyHost.equals("")) proxyHost=null;
	if (!puerto.equals("")) proxyPort=Integer.parseInt(puerto);
	if (authenticationType.equals("")) authenticationType=null;
	if (usuAut.equals("")) usuAut=null;
	

    ArrayList headParms = new ArrayList();


    HTTPConnection httpConn = new HTTPConnection(url);

    httpConn.setAllowUserInteraction(false);

    if (authenticationType != null) {
      if (authenticationType.equals("BASIC"))
        httpConn.addBasicAuthorization(realmName, usuAut, passAut);
      else if (authenticationType.equals("DIGEST")) {
        httpConn.addDigestAuthorization(realmName, usuAut, passAut);
      }

    }

    int timeout = defaultTimeOut;

    if (timeout <= 0) {
      httpConn.setTimeout(0);
    }
    else {
      httpConn.setTimeout(timeout);
    }

	if (proxyHost != null) {
    httpConn.setCurrentProxy(proxyHost, proxyPort);

	
	if (usuAut != null)
	{
		String userPassword = usuAut + ":" + passAut;
		headParms.add(new NVPair("Authorization", "Basic " + Base64.encodeBase64(userPassword.getBytes())));
	}
	}

    if (sendSoapAction) {
      headParms.add(new NVPair("SOAPAction", serviceName));
    }

    headParms.add(new NVPair("User-Agent", userAgent));



    addContentTypeHeader(headParms, isHtmlFormEncoding, charset);

    if (optionalHeaders != null) {
      Set keySet = optionalHeaders.keySet();
      for (Iterator i = keySet.iterator(); i.hasNext(); ) {
        String key = (String)i.next();
        headParms.add(new NVPair(key, (String)optionalHeaders.get(key)));
      }
    }
    String urlStr;
    if (url.getQuery() == null) {
      urlStr = url.getPath();
    }
    else {
      urlStr = url.getPath() + "?" + url.getQuery();
    }

    NVPair[] headerParamArray = (NVPair[])headParms.toArray(new NVPair[headParms.size()]);

    if (isHtmlFormEncoding) {
      NVPair[] formPostParams = createFormParams(dataToSend, formParams, serviceName);
      return httpConn.Post(urlStr, formPostParams, headerParamArray);
    }

    System.out.println("XML_TO_SEND ws2 jsp HTTPCONN [" + dataToSend + "]");

    if (charset != null) {
      return httpConn.Post(urlStr, dataToSend.getBytes(charset), headerParamArray);
    }
    return httpConn.Post(urlStr, dataToSend, headerParamArray);
  }
  %>
  <%!
  public void addContentTypeHeader(ArrayList headParms, boolean htmlForEnconding, String charset)
  {
    String contentTypeParam = "";
    String contentType = "text/xml";

    if (charset != null) {
      contentTypeParam = contentTypeParam + "; charset=" + charset;
    }

    if (htmlForEnconding)
      headParms.add(new NVPair("Content-Type", "application/x-www-form-urlencoded" + contentTypeParam));
    else
      headParms.add(new NVPair("Content-Type", contentType + contentTypeParam));
  }
  %>
  <%!
  public NVPair[] createFormParams(String dataToSend, NameValuePair[] formParams, String serviceName)
  {
    NameValuePair[] fixedParams = new NameValuePair[0];

    String htmlFormMainParamName = null;
    boolean isHtmlFormXPathParams = false;

    int count = 0;

    if (formParams == null)
    {
      count = fixedParams.length;
    }
    else
    {
      count = fixedParams.length + formParams.length;
    }

    if (htmlFormMainParamName != null) {
      count++;
    }

    NameValuePair[] xPathParams = (NameValuePair[])null;

    NVPair[] params = new NVPair[count];

    count = 0;

    if (htmlFormMainParamName != null)
    {
      params[(count++)] = new NVPair(htmlFormMainParamName, dataToSend);
      System.out.println("FORM_PARAM_SEND [" + params[(count - 1)] + "]");
    }

    for (int n = 0; n < fixedParams.length; n++) {
      params[(count++)] = new NVPair(fixedParams[n].getName(), fixedParams[n].getStrValue());
      System.out.println("FORM_PARAM_SEND [" + params[(count - 1)] + "]");
    }

    if (formParams != null) {
      for (int n = 0; n < formParams.length; n++) {
        params[(count++)] = new NVPair(formParams[n].getName(), formParams[n].getStrValue());
        System.out.println("FORM_PARAM_SEND [" + params[(count - 1)] + "]");
      }

    }

    if ((xPathParams != null) && (xPathParams.length > 0)) {
      for (int n = 0; n < xPathParams.length; n++) {
        params[(count++)] = new NVPair(xPathParams[n].getName(), xPathParams[n].getStrValue());
        System.out.println("FORM_PARAM_SEND [" + params[(count - 1)] + "]");
      }
    }

    if (count == 0) {
      System.out.println("NONE_PARAM_SEND");
    }

    return params;
  }
%>


  <%!
  public String encode64(String s)
  {
    String r = "";
    String p = "";
    int c = s.length() % 3;
    if (c > 0) {
      for (; c < 3; c++)
      {
        p = p + "=";
        s = s + "";
      }
    }
    for (c = 0; c < s.length(); c += 3)
    {
      if ((c > 0) && (c / 3 * 4 % 76 == 0))
        r = r + "\r\n";
      int n = (s.charAt(c) << '\020') + (s.charAt(c + 1) << '\b') + s.charAt(c + 2);
      int n1 = n >> 18 & 0x3F;
      int n2 = n >> 12 & 0x3F;
      int n3 = n >> 6 & 0x3F;
      int n4 = n & 0x3F;
      r = r + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(n1) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(n2) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(n3) + "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(n4);
    }

    return r.substring(0, r.length() - p.length()) + p;
  }
  %>
  
    <%!
  public static class CustomAuthenticator extends Authenticator {
        String baName;
        String baPassword;
        private CustomAuthenticator(String baName1, String baPassword1) {
            baName = baName1;
            baPassword = baPassword1;
        }  
	         
	        // Called when password authorization is needed
	        protected PasswordAuthentication getPasswordAuthentication() {
	             
	            // Get information about the request
	            String prompt = getRequestingPrompt();
	            String hostname = getRequestingHost();
	            InetAddress ipaddr = getRequestingSite();
	            int port = getRequestingPort();
	 
				System.out.println("AUTHENTICATOR with user [" + baName + "] and pass[" + baPassword + "]!!");

	 
	            // Return the information (a data holder that is used by Authenticator)
	            return new PasswordAuthentication(baName, baPassword.toCharArray());
	             
	        }
	         
	    }
  %>

</body>
</html>