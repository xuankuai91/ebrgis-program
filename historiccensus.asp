<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head profile="http://www.w3.org/2005/10/profile">
	<link rel="icon" type="image/ico" href="elements/favicon.ico">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no">
	<link rel="stylesheet" type="text/css" href="css/ebrgis.css"> 
	<link rel="stylesheet" type="text/css" href="css/ebrgis_menu.css">
	<link rel="stylesheet" href="https://js.arcgis.com/4.8/esri/css/main.css">

	<title>Historic Census</title>

	<style>
		#viewDiv {
			padding: 0;
			margin: 0;
			height: 690px;
			width: 100%;
			border:solid thin #353e71;
			overflow: hidden;
		}
	</style>

	<script src="https://js.arcgis.com/4.8/"></script>
	<script src="js/map.js"></script>

</head>

<body>
	<div class="container">
		<div class="container_header">
			<!--#include file="includes/header.asp"-->
		</div>

		<div class="container_menu">
			<!--#include file="includes/menu.asp"-->	
		</div>

		<div class="container_pagetitle">
			Historic Census
		</div>

		<div class="container_content">
			To view Census 2000 block group population and demographic data, please click a Census tract number on the map. <a href="../census10.asp">Click here</a> to view Census 2010 information.
			<br>
			<br>
			<div style="border-color: #353e71">
				<div id="viewDiv"></div>
			</div>
			<br>
			Users may submit their questions	related to the Census data by sending an email to <a href="mailto:gis@brla.gov">gis@brla.gov</a> or contacting the Department of Information Services at (225) 389-3070 or visit the <a class="smalllink" href="http://factfinder.census.gov" target="_blank">US Census Bureau</a> website.
			<br></br>
		</div>

		<div class="container_footer">
			<!--#include file="includes/footer.asp"-->
		</div>
	</div>
</body>

</html>
