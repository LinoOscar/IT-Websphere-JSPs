<%--
  Document : mbeanSN3.jsp
  Created on : 2014
  Author : Er Lino
  Utilidad: todos los beans, modificar valores y llamar ops
 --%>

<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.lang.management.*" %>
<%@ page import="javax.management.*" %>
<%@ page import="java.net.InetAddress" %>




<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>SN3 MBEANS</title>
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
function detailsService(sel,clones){
	location.href=location.protocol+"//"+location.host+location.pathname+"?filtrado="+sel.id+"&beanSelected="+sel.id+"&clones="+clones;  
}
function filtrar(selvalue,clones){
location.href=location.protocol+"//"+location.host+location.pathname+"?filtrado="+this.nombre.value+"&clones="+clones;
}
function attModif(but,clones){
var mitabla = but.parentElement.parentElement.parentElement.parentElement;

location.href=location.protocol+"//"+location.host+location.pathname+"?filtrado="+mitabla.rows[1].cells[1].innerText+
"&beanSelected="+mitabla.rows[1].cells[1].innerText+
"&server="+ mitabla.id+
"&att="+ but.id +
"&newValue="+ this.document.getElementById("INPUT"+but.id).value+
"&clones="+clones;
}
function executeOper(oper,clones){
var mitabla = oper.parentElement.parentElement.parentElement.parentElement.parentElement;

var micelda=oper.parentElement.parentElement.parentElement.cells[1];
var cadenaPars="";
var contador=0;
var miinput=micelda.getElementsByTagName("input")[contador];
while (miinput!=undefined)
{
    cadenaPars=cadenaPars+"&par"+contador+"="+miinput.value;
	contador++;
	miinput=micelda.getElementsByTagName("input")[contador];
}

location.href=location.protocol+"//"+location.host+location.pathname+"?filtrado="+mitabla.rows[1].cells[1].innerText+
"&beanSelected="+mitabla.rows[1].cells[1].innerText+
"&server="+ mitabla.id+
"&operationSel="+ oper.id+
cadenaPars+
"&clones="+clones;
}

function changeToClon(este,clones) {

	 var ca = document.cookie.split(';');
	 
	 for(var i=0;i < ca.length;i++) {
	 
		if (ca[i].indexOf("JSESSIONID") != -1)
		{
			//Nos quedamos el id de clon
			var clonId= ca[i].substr(ca[i].indexOf(":") + 1);
			
			var name= ca[i].substr(0,ca[i].indexOf("="));

			createCookie(name,"zzzzz:"+este.id,1);
		}
	 }
	 
	var currenturl = window.location.href;
	var url = currenturl;
	
	if (url.indexOf("clones") != -1)
	{
		url = currenturl.substr(0,currenturl.lastIndexOf("&"));
	}
	
	if (url.indexOf("?") == -1)
		url = url + "?filtrado=";	 
	 
	 window.location.href = url + "&clones=" + clones;
}

function refresh(clones){

	 var ca = document.cookie.split(';');
	 
	 for(var i=0;i < ca.length;i++) {
	 
		if (ca[i].indexOf("JSESSIONID") != -1)
		{
			//Nos quedamos el id de clon
			var clonId= ca[i].substr(ca[i].indexOf(":") + 1);
			
			var name= ca[i].substr(0,ca[i].indexOf("="));

			createCookie(name,"",-1);
		}
	 }
	 
	var currenturl = window.location.href;
	var url = currenturl;
	
	if (url.indexOf("clones") != -1)
	{
		url = currenturl.substr(0,currenturl.lastIndexOf("&"));
	}
	
	if (url.indexOf("?") == -1)
		url = url + "?filtrado=";
	
	window.location.href = url + "&clones=" + clones;

}


function createCookie(name,value,days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
}
</script>

</head>

<body>
<hr>
<h2 style="text-align:center"><u>BKS MBEANS Managements</u></h2>
<br>




<%
	//Comprobamos el parametro de clones recibidos
	//La lista de clones es nombre:idclon||nombre:idclon
	String clones= (String) request.getParameter("clones");
	
	if (clones == null)
	  clones = "";
	
	//Comprobamos si current clon esta en la lista

	InetAddress host = null;
    host = InetAddress.getLocalHost();
    String currentHost=host.getHostName();

	 
	 
	if (clones.indexOf(currentHost) == -1)
	{
	  //Annadimos
	  //Conseguimos el id del clon.
	  Cookie[] cookies = null;
      cookies = request.getCookies();
	  

	  
	  String clonId = "";
	  if (cookies != null)
	  {
	  for (int i = 0; i < cookies.length; i++)
	  {

		  if (cookies[i].getName().indexOf("JSESSIONID") != -1)
		  {
				clonId = cookies[i].getValue().substring(cookies[i].getValue().indexOf(":") + 1);
		  }
	  }
	  }
			if (!clonId.equals(""))
				clones = clones + "||" + currentHost + ":" + clonId;
			else
				%><script>location.reload(true)</script><%
	}
	
%>
<script>
	var clones="<%=clones%>";
</script>

<h4 style="text-align:center">
    <% 
	  //Separamos los clones
	  StringTokenizer st2 = new StringTokenizer(clones, "||");
	  int counti=0;
	  while (st2.hasMoreElements()) 
	  {
		String currentVal = (String)st2.nextElement();
		String nombreClon = currentVal.substring(0,currentVal.indexOf(":"));
		String idClon = currentVal.substring(currentVal.indexOf(":") + 1);
		String color = "black";
		if (nombreClon.equals(currentHost))
		{
		  %><button style="border-style:inset;text-align:center;color:white;background-color:red" id="<%=idClon%>" onclick="javascript:changeToClon(this,clones)"><%=nombreClon%></button><%
		}
		else
		{
		   %><button style="text-align:center;color:black;background-color:white" id="<%=idClon%>" onclick="javascript:changeToClon(this,clones)"><%=nombreClon%></button><%
		}

	   counti++;
	} //Llave del while tokenizer
	%>
	<button style="text-align:center;color:black" id="newClon" onclick="javascript:refresh(clones)" title="Press button for discover new clon">+</button>
</h4> 
<br>

<%

   String filtrado= (String) request.getParameter("filtrado");

   String beanSelected= (String) request.getParameter("beanSelected");
   
   //Valores en caso de modificacion
   String serverSel=(String) request.getParameter("server");
   String att=(String) request.getParameter("att");
   String newValue=(String) request.getParameter("newValue");
   String operationSel=(String) request.getParameter("operationSel");
   List<String> paramsIn = new ArrayList<String>();
   int contpars=0;	
   
   if (serverSel == null) serverSel="";
   if (att == null) att="";
   if (newValue == null) newValue="";
   if (operationSel == null) operationSel="";
   
   boolean modificarValor=false;
   if ((serverSel != "") && (att!="") && (newValue!=""))
     modificarValor=true;
  
	 
   boolean ejecutarOper=false;
   if (operationSel != "")
   {
     ejecutarOper=true;
	 
	 //Coger parametros
	 boolean haypars = true;
	
	 while (haypars==true)
	 {
	  String parsAux=(String) request.getParameter("par"+contpars);
	  if (parsAux==null)
	    haypars=false;
	  else
	  {
	    paramsIn.add(parsAux);
	    contpars++;
	  }
	 }
   }
     
   
   if (filtrado==null)
   {
     filtrado="";
   }
   filtrado = filtrado.toLowerCase();
   if (beanSelected==null)
   {
     beanSelected="";
   }
   
   %>
		<script>
			var filtradojs="<%=filtrado%>";
		</script>
   <%   
   
   if (filtrado == "")
   {
	%>
		<input type="text" name="nombre"><button id="filtrar" onclick="javascript:filtrar(filtradojs,clones)">Filter</button>
	<%
   }
	else
   {
	%>
		<input type="text" name="nombre" value="<%=filtrado%>"><button id="filtrar" onclick="javascript:filtrar(filtradojs,clones)">Filter</button>
	<%		
   }
   
	List<MBeanServer> servers = new LinkedList<MBeanServer>();
    servers.add(ManagementFactory.getPlatformMBeanServer());
    servers.addAll(MBeanServerFactory.findMBeanServer(null));
	
    for (final MBeanServer server : servers) 
	{
	    boolean serverConDatos = false;
		String ultimoServer=server.getClass().getName();

        final Set<ObjectName> mbeans = new HashSet<ObjectName>();
        mbeans.addAll(server.queryNames(null, null));
        for (final ObjectName mbean : mbeans) 
		{
		String ultimombeanname = mbean.toString();
		if ((filtrado != "") && (ultimombeanname.toLowerCase().indexOf(filtrado) == -1))
		  continue;
		  
		  
		if (serverConDatos == false)
		{
		%>
		<br>
		<br>
		<h3>Server <%=server.getClass().getName()%></h3>
		<br>
		<table id="<%=server.getClass().getName()%>" style="width:60%">
		<tr>
			<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold;text-align: center">Details</td>		
			<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold">MBEAN</td>
		</tr>		
		<%	
		serverConDatos = true;
		}
		
		%>
		<tr>
			<td style="border-bottom-style:solid; border-bottom-width:1px;text-align:center"><button id="<%=mbean%>" onclick="javascript:detailsService(this,clones)">Go!</button></td>		
			<td style="border-bottom-style:solid; border-bottom-width:1px"><%=mbean%></td>
		</tr>		
		<%

		if (beanSelected !="")
		{
		
		final MBeanAttributeInfo[] attributes = server.getMBeanInfo(mbean).getAttributes();
		boolean atributesFounded=false;
        for (final MBeanAttributeInfo attribute : attributes) 
		{
		
			//Modificamos si es necesario
			if (modificarValor)
			{
				if ((ultimoServer.equals(serverSel)) && (beanSelected.equals(ultimombeanname)) && (att.equals(attribute.getName())))
				{
				//Decidimos el tipo
				if (attribute.getType().equals("java.lang.String"))
				   server.setAttribute(mbean,new Attribute(attribute.getName(), newValue));
				else if (attribute.getType().equals("long"))
				   server.setAttribute(mbean,new Attribute(attribute.getName(), Long.parseLong(newValue)));
				else if (attribute.getType().equals("int"))
				   server.setAttribute(mbean,new Attribute(attribute.getName(), Integer.parseInt(newValue)));	
				else if (attribute.getType().equals("double"))
				   server.setAttribute(mbean,new Attribute(attribute.getName(),  Double.parseDouble(newValue)));		
				else if (attribute.getType().equals("boolean"))
				   server.setAttribute(mbean,new Attribute(attribute.getName(),  Boolean.parseBoolean(newValue)));	
				else if (attribute.getType().equals("float"))
				   server.setAttribute(mbean,new Attribute(attribute.getName(),  Float.parseFloat(newValue)));	
				else if (attribute.getType().equals("short"))
				   server.setAttribute(mbean,new Attribute(attribute.getName(),  Short.parseShort(newValue)));			   
				}
			
			}

			
		
		    if (atributesFounded == false)
			{
			%>
			<tr></tr>
			<tr>
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold;text-align: center">Attributes</td>		
			</tr>	
			<tr>
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold;text-align: center">Name</td>		
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold">Type / Value</td>
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold">New Value</td>
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold">Change!</td>				
			</tr>				
			<%
			  atributesFounded=true;
			}
			%>
			<tr>
				<td style="border-bottom-style:solid; border-bottom-width:1px"><%=attribute.getName()%></td>
			<%
            try 
			{
				final Object value = server.getAttribute(mbean,attribute.getName());
                if (value == null) 
				{
					%>
					<td style="border-bottom-style:solid; border-bottom-width:1px"><%=attribute.getType()%> / No attributes</td>		
					<%				
				} 
				else 
				{
					%>
					<td style="border-bottom-style:solid; border-bottom-width:1px"><%=attribute.getType()%> / <%=value.toString()%></td>	
					<%					
                }
            } 
			catch (Exception e) 
			{
			e.printStackTrace();
					%>
					<td style="border-bottom-style:solid; border-bottom-width:1px"><%=attribute.getType()%> / <%=e.getMessage()%></td>	
					<%				
            }
			%>
				<td style="border-bottom-style:solid; border-bottom-width:1px"><input type="text" id="INPUT<%=attribute.getName()%>"></td>	
				<td style="border-bottom-style:solid; border-bottom-width:1px"><button id="<%=attribute.getName()%>" onclick="javascript:attModif(this,clones)">Go!</button></td>	
				</tr>
			<%	
        }
		
		final MBeanOperationInfo[] operations = server.getMBeanInfo(mbean).getOperations();
		boolean operationsFounded=false;
		
        for (final MBeanOperationInfo operation : operations) 
		{
		    if (ejecutarOper)
			{	
				if ((ultimoServer.equals(serverSel)) && (beanSelected.equals(ultimombeanname)) && (operationSel.equals(operation.getName())))
				{
					Object aa=null;

					if (contpars==0)
						aa = server.invoke(mbean,operation.getName(), new Object[] {}, new String[] {});
					else
					{
						Object  opParams[] = new Object[contpars];
						String  opSig[] = new String[contpars];
						
						MBeanParameterInfo[] parametersOpAux = operation.getSignature();
						
						for (int jj=0;jj<contpars;jj++)
						{
							opParams[jj] = paramsIn.get(jj);
							opSig[jj] = parametersOpAux[jj].getType();
						}
						
						aa = server.invoke(mbean,operation.getName(), opParams, opSig);
					}
					
					System.out.println(operation.getReturnType());
					if (!operation.getReturnType().equals("void"))
					{
					%><p style="color:red">RETURN DATA [<%=aa.toString()%>]</p><%
					}
					else
					{
					%><p style="color:red">RETURN DATA VOID.REFRESH FOR TEST METHOD RESULT</p><%
					}
				}
			}
			
		    if (operationsFounded == false)
			{
			%>
			<tr></tr>
			<tr>
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold;text-align: center">Operations</td>		
			</tr>	
			<tr>
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold;text-align: center">Launch OP</td>		
				<td style="border-bottom-style:solid; border-bottom-width:5px;font-size:15pt; font-style:italic;font-weight:bold">Parameters</td>				
			</tr>				
			<%
			  operationsFounded=true;
			}
			%>
			<tr>
				<td style="border-bottom-style:solid; border-bottom-width:1px;text-align: center"><a href="#" title="Return Type--><%=operation.getReturnType()%>"><button id="<%=operation.getName()%>" onclick="javascript:executeOper(this,clones)"><%=operation.getName()%></button></a></td>
			<%
			
			//Cogemos los parametros
			MBeanParameterInfo[] parametersOp = operation.getSignature();
			int parnum=0;
			%><td tyle="border-bottom-style:solid; border-bottom-width:1px"><%
			for (final MBeanParameterInfo parOp : parametersOp) 
			{
				%>
				<a href="#" title="<%=parOp.getDescription()%>"><%=parOp.getName()%></a>
				<input type="text" name="BUT<%=parnum%>" value="(<%=parOp.getType()%>)">
				  
				<%
				parnum++;
			}
			%>
			</td>
			</tr>
			<%			
			
		}		
		
		}
        }
		%>
		</table>		
		<%
    }
   

%>
</body>
</html>
