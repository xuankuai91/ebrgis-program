<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head profile="http://www.w3.org/2005/10/profile">
		<link rel="icon" type="image/ico" href="elements/brshield.ico">
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<title>Census 2000</title>
		<link rel="stylesheet" type="text/css" href="css/ebrgis.css">	
		<link rel="stylesheet" type="text/css" href="css/ebrgis_menu.css">

		<style type='text/css'>
			table.blocks {
				border:1px solid black;
				border-collapse: collapse;
				margin: auto;
				width: 652px;
			}

			table.blocks tr td {
				border: 1px solid black;
				padding: 0.12em 0.12em 0.16em 0.66em;
			}

			table.blocks tr td.hdr {
				background-color: #ddf;
				font-weight: bold;
				font-size: 112%;
				padding-left: 1em;
				text-align: center;
			}

			table.blocks tr td.lbl {
				background-color: #bababa;
				font-weight: bold;
			}
		</style>
		<!--#include file="includes/analytics.asp"-->
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
				2000 Census for East Baton Rouge Parish
			</div>

			<div class="container_content">
				<div>
					<%
						Dim varCT
						varCT=Request.QueryString("Tract")
					%>

					<form action="censusinfo00.asp" method="get" name="frmList" id="frmList">
						<p>Pick a Census Tract from the list:
							<select name="Tract" id="select" style="font-size: 12px;">
								<option value="0">Select Census Tract</option>
								<%
									dim DataConn
									dim fixvalue 'created this to fix a problem with data prakash had set up
									Set DataConn = Server.CreateObject("ADODB.Connection")
									DataConn.Open "Driver={SQL Server}; Server=DTSQL; Uid=WEBUSER; PWD=WEBUSER3070; DATABASE=web"
									'DataConn.Open "Driver={Microsoft Access Driver (*.mdb)}; DBQ=" & Server.MapPath("census2k") & "; UID=; PW=;"
									'DataConn.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath ("/census2k.mdb") & ";UID=; PW=;"
									'DataConn.Open
									dim RS
									Set RS = Server.CreateObject("ADODB.Recordset")
									'sql="Select distinct Census_Tract from webquery.tblPlanningCensus"
									sql="Exec [WebQuery].[sp_tblPlanningCensus_sel_disctinct]"
									'RS.Open sql,DataConn
									set rs = DataConn.Execute(sql)
									Do while not RS.EOF
										if cstr(rs("Census_tract")) = "40.1" then
											fixvalue = "40.10"
										else
											fixvalue = cstr(rs("Census_tract"))
										end if
										'response.write ("<option value='" & cstr(RS("Census_Tract")) & "'")
										response.write ("<option value='" & fixvalue & "'")
										if varCT=cstr(RS("Census_Tract")) then response.write (" Selected")
										response.write (">Census Tract " & cstr(RS("Census_Tract")) & "</option>" & vbCrLf)
										RS.MoveNext
									Loop
								%>
							</select>
						<input type="submit" name="Submit" value="Submit">
						</p>
					</form>

					<%
						if varct = "40.10" then
							fixvalue = "40.1"
						else
							fixvalue = varct
						end if

						if fixvalue <> 0 then
							response.write ("<center>[<a href='census00.asp'>View Parish map</a>]</center><br>")
							response.write ("<center><strong>Census Tract " & fixvalue & "</strong></center><br>")
						else
							response.write ("<strong>Please select a Census tract from the above drop down box.</strong>")
						end if
					%>

					<%if varCT <> 0 then %>
						<% ct = replace(varct,".","-") %>
						<div style='text-align:center'>
							<img src="Census00/Images/ct_<%= ct %>.jpg" width="500">
						</div>
					<%end if%>

					<br><br>

					<%
						'Following code pulls out records for each Block group in specified Census Tract
						Dim rsCensusTract
						Dim strsql
						'strsql="Select * from webquery.tblPlanningCensus where Census_Tract=" & varCT & " order by BLOCK"
						strsql = "Exec [WebQuery].[sp_tblPlanningCensus] " & varCT
						set rsCensusTract = Server.CreateObject("ADODB.Recordset")
						'rsCensusTract.open strsql,dataconn
						set rsCensusTract = dataconn.Execute(strsql)

						Do while not rsCensusTract.eof
							response.write tableSeparator
							tableSeparator = vbCrLf & "<br> <p> <hr align='center' width='60%' style='width:60%' size='1' noshade> <br> </p>" & vbCrLf

							Dim FIPS
							If Len(rsCensusTract("CENSUS_TRACT")) = 1 then
								FIPS = "22033000" & rsCensusTract("CENSUS_TRACT") & "00"
							ElseIf Len(rsCensusTract("CENSUS_TRACT")) = 2 then
								FIPS = "2203300" & rsCensusTract("CENSUS_TRACT") & "00"
							ElseIf Len(rsCensusTract("CENSUS_TRACT")) = 4 then
								FIPS = "22033000" & Replace(rsCensusTract("CENSUS_TRACT"), ".", "")
							Else
								FIPS = "2203300" & Replace(rsCensusTract("CENSUS_TRACT"), ".", "")
							End If
					%>

					<table width="100%" class='blocks'>
						<tr>
							<td colspan="4" class='hdr'>Tract <%= varct %> &nbsp; &nbsp; Block Group <%= rsCensusTract("Block") %> &nbsp; &nbsp; FIPS Code <%= FIPS %><%= rsCensusTract("Block") %></td>
						</tr>
						<tr>
							<td colspan="2" class='lbl'>Population</td>
							<td colspan="2" class='lbl'>Occupancy </td>
						</tr>
						<tr>
							<td width="38%">Total Population</td><td width="12%"><%= rsCensusTract("Population") %></td>
							<td width="34%">Owner occupied </td><td width="16%"><%= rsCensusTract("OWNER") %></td>
						</tr>
						<tr>
							<td>White</td><td><%= rsCensusTract("WHITE") %></td>
							<td>Renter occupied </td><td><%= rsCensusTract("RENTER") %></td>
						</tr>
						<tr>
							<td>Black</td><td><%= rsCensusTract("BLACK") %></td>
							<td colspan="2" class='lbl'>Education Attainment</td>
						</tr>
						<tr>
							<td>American Indian</td><td><%= rsCensusTract("AM_INDIAN") %></td>
							<td>Male- High School </td><td><%= rsCensusTract("MALE_HIGH_SCHOOL") %></td>
						</tr>
						<tr>
							<td>Asian</td><td><%= rsCensusTract("ASIAN") %></td>
							<td>Female- High School </td><td><%= rsCensusTract("FEMALE_HIGH_SCHOOL") %></td>
						</tr>
						<tr>
							<td>Other</td><td><%= rsCensusTract("OTHER") %></td>
							<td>Male- Bachelor's Degree </td><td><%= rsCensusTract("MALE_BACHELOR") %></td>
						</tr>
						<tr>
							<td class='e'></td><td class='e'></td>
							<td>Female- Bachelor's Degree</td><td><%= rsCensusTract("FEMALE_BACHELOR") %></td>
						</tr>
						<tr>
							<td colspan="4" class='lbl'>Other</td>
						</tr>
						<tr>
							<td>Vacancy Rates </td><td><%= rsCensusTract("VACANCY_RATES") %></td>
							<td>Median year built </td><td><%= rsCensusTract("MEDIAN_YEAR_BUILT") %></td>
						</tr>
						<tr>
							<td>Median House Value (Owner occupied) </td><td><%= rsCensusTract("MEDIAN_HOUSE_VALUE_OWNER_OCCU") %></td>
							<td>Median Income </td><td><%= rsCensusTract("MEDIAN_INCOME") %></td>
						</tr>
						<tr>
							<td>Number of Housing Units </td><td><%= rsCensusTract("HOUSING_UNITS") %></td>
							<td class='e'></td><td class='e'></td>
						</tr>
					</table>

					<%
							rsCensusTract.movenext
						Loop
					%>
					
					<%
						'Closing All recordsets and connections
						rsCensusTract.close
						Set rsCensusTract=nothing
						RS.Close
						set RS=Nothing
						DataConn.Close
						set DataConn=Nothing
					%>
				</div>
				<br>
				Users may submit their questions	related to the Census data by sending an email to <a href="mailto:gis@brgov.com">gis@brgov.com</a> or contacting the Department of Information Services at (225) 389-3070 or visit the <a class="smalllink" href="http://factfinder.census.gov" target="_blank">US Census Bureau</a> website.
				<br></br>
			</div> 

			<div class="container_footer">
				<!--#include file="includes/footer.asp"-->
			</div>
		</div>
		<br /> <br />
	</body>
</html>
