<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	<head profile="http://www.w3.org/2005/10/profile">
		<link rel="icon" type="image/ico" href="elements/brshield.ico">
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<title>Census 2010</title>
		<link rel="stylesheet" type="text/css" href="css/ebrgis.css">	
		<link rel="stylesheet" type="text/css" href="css/ebrgis_menu.css">

		<style type='text/css'>
			table.blocktable {
				border-collapse: collapse;
				width: 620;
				margin: auto;
				border: 1px solid black;
			}
			table.blocktable tr td {
				padding: 0.16em 1.2em 0.16em 0.6em;
				border: 1px solid black;
			}
			table.blocktable td.lbl {
				background-color: #bababa;
				padding-left: 0.6em;
				font-weight: bold;
			}
			table.blocktable td.hdr {
				font-size: 112%;
				padding: 0.25em 0;
				text-align: center;
				background-color: #ddf;
				font-weight: bold;
				text-justify: center;
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
				2010 Census for East Baton Rouge Parish
			</div>

			<div class="container_content">
				<div>
					<%
						Dim varCT
						varCT=Request.QueryString("Tract")

						dim rsCensusTract
						function lk( lbl )
							lk = rsCensusTract.Fields.Item( lbl )
						end function

					%>

					<form action="censusinfo10.asp" method="get" name="frmList" id="frmList">
					<p>Pick a Census Tract from the list:
						<select name="Tract" id="select" style="font-size: 12px;">
							<option value="0">Select Census Tract</option>

							<%
								dim cn, cmd, rs
								set cn = Server.CreateObject("ADODB.Connection")

								cn.ConnectionString = "Provider=MSDAORA.1;Data Source=EBRGIS.BRGOV.NET;User ID=WEBUSER;Password=WEBUSER3070"
								cn.Open

								Set cmd = Server.CreateObject ("ADODB.Command")
								Set cmd.ActiveConnection = cn
								cmd.CommandText = "CPPCGIS.WEB_CENSUS_TRACT_LISTING"
								cmd.CommandType = 4 'adCmdStoredProc

								Set rs = cmd.Execute

								Do while not RS.EOF
									if cstr(rs("TRACT")) = "40.1" then
										fixvalue = "40.10"
									else
										fixvalue = cstr(rs("TRACT"))
									end if
									response.write ("<option value='" & fixvalue & "'")
									if varCT=cstr(RS("TRACT")) then response.Write(" Selected")
									response.Write(">Census Tract " & cstr(RS("TRACT")) & "</option>" & vbCrLf)
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

						if fixvalue <> "" then
							response.write "<center>[<a href='census10.asp'>View Parish map</a>]</center><br>"
							response.write "<center><strong>Census Tract " & fixvalue & "</strong></center>"
						else
							response.write "<strong>Please select a Census tract from the above drop down box.</strong>"
						end if
					%>
					<%
						if varCT <> "" then
							ct = replace(varct,".","-")
					%>

					<br>
					<center><img src="Census10/Images/ct<%= ct %>.gif" alt="Census Tract <%= ct %>" /></center> <p> </p>

					<%
						'Following code pulls out records for each Block group in specified Census Tract

						cmd.CommandText = "CPPCGIS.WEB_CENSUS_TRACT_DETAIL"
						cmd.CommandType = 4 'adCmdStoredProc

						Dim param1
						Set param1 = cmd.CreateParameter ("intract", 200, 1,10, varCT)
						'Set objparameter=objcommand.CreateParameter (name,type,direction,size,value)
						'http://www.w3schools.com/ado/met_comm_createparameter.asp
						'200=varchar
						'1=Input Parameter

						cmd.Parameters.Append param1

						set rsCensusTract = cmd.Execute
						'rsCensusTract.open strsql,dataconn

						dim tableSeparator : tableSeparator = ""

						Do while not rsCensusTract.eof
								response.write tableSeparator
								tableSeparator = vbCrLf & "<br> <p> <hr align='center' width='60%' style='width:60%' size='1' noshade> <br> </p>" & vbCrLf
					%>

					<table class='blocktable'><tbody>
						<tr>
							<td colspan='4' class='hdr'>Tract <%= lk("TRACT") %> &nbsp; &nbsp; Block Group <%= lk("BLOCK_GROUP") %> &nbsp; &nbsp; FIPS Code <%= lk("FIPS_TRACT") %></td>
						</tr>
						<tr>
							<td colspan='2' class='lbl'>Population</td>
							<td colspan='2' class='lbl'>Education</td>
						</tr>
						<tr>
							<td>Total Population</td><td><%= lk("TOTAL_POPULATION") %></td>
							<td>High School Male</td><td><%= lk("HIGH_SCHOOL_MALE") %></td>
						</tr>
						<tr>
							<td>One Race</td><td><%= lk("POPULATION_ONE_RACE") %></td>
							<td>High School More Male</td><td><%= lk("HIGH_SCHOOL_MORE_MALE") %></td>
						</tr>
						<tr>
							<td>Multi Race</td><td><%= lk("POPULATION_MULTI_RACE") %></td>
							<td>College 1Yr Less Male</td><td><%= lk("COLLEGE_1YR_LESS_MALE") %></td>
						</tr>
						<tr>
							<td>White</td><td><%= lk("POPULATION_WHITE") %></td>
							<td>College 1Yr More Male</td><td><%= lk("COLLEGE_1YR_MORE_MALE") %></td>
						</tr>
						<tr>
							<td>Black</td><td><%= lk("POPULATION_BLACK") %></td>
							<td>Associates Degree Male</td><td><%= lk("ASSOCIATES_DEGREE_MALE") %></td>
						</tr>
						<tr>
							<td>American Indian</td><td><%= lk("POPULATION_AM_INDIAN") %></td>
							<td>Bachelors Degree Male</td><td><%= lk("BACHELORS_DEGREE_MALE") %></td>
						</tr>
						<tr>
							<td>Asian</td><td><%= lk("POPULATION_ASIAN") %></td>
							<td>Masters Degree Male</td><td><%= lk("MASTERS_DEGREE_MALE") %></td>
						</tr>
						<tr>
							<td>Pacific Islander</td><td><%= lk("POPULATION_PACF_ISLAND") %></td>
							<td>Professional Degree Male</td><td><%= lk("PROFESSIONAL_DEGREE_MALE") %></td>
						</tr>
						<tr>
							<td>Other</td><td><%= lk("POPULATION_OTHER") %></td>
							<td>Doctoral Degree Male</td><td><%= lk("DOCTORAL_DEGREE_MALE") %></td>
						</tr>
						<tr>
							<td>25 Older</td><td><%= lk("POPULATION_25_OLDER") %></td>
							<td>High School Female</td><td><%= lk("HIGH_SCHOOL_FEMALE") %></td>
						</tr>
						<tr>
							<td>Median Age</td><td><%= lk("MEDIAN_AGE") %></td>
							<td>High School More Female</td><td><%= lk("HIGH_SCHOOL_MORE_FEMALE") %></td>
						</tr>
						<tr>
							<td>Median Household Income 2010</td><td><%= lk("MEDIAN_HOUSEHOLD_INCOME_2010") %></td>
							<td>College 1Yr Less Female</td><td><%= lk("COLLEGE_1YR_LESS_FEMALE") %></td>
						</tr>
						<tr>
							<td class='e'></td><td class='e'></td>
							<td>College 1Yr More Female</td><td><%= lk("COLLEGE_1YR_MORE_FEMALE") %></td>
						</tr>
						<tr>
							<td colspan='2' class='lbl'>Occupation</td>
							<td>Associates Degree Female</td><td><%= lk("ASSOCIATES_DEGREE_FEMALE") %></td>
						</tr>
						<tr>
							<td>Housing Units</td><td><%= lk("HOUSING_UNITS") %></td>
							<td>Bachelors Degree Female</td><td><%= lk("BACHELORS_DEGREE_FEMALE") %></td>
						</tr>
						<tr>
							<td>Occupied Housing Units</td><td><%= lk("OCCUPIED_HOUSING_UNITS") %></td>
							<td>Masters Degree Female</td><td><%= lk("MASTERS_DEGREE_FEMALE") %></td>
						</tr>
						<tr>
							<td>Owner Occupied Housing</td><td><%= lk("OWNER_OCCUPIED_HOUSING") %></td>
							<td>Professional Degree Female</td><td><%= lk("PROFESSIONAL_DEGREE_FEMALE") %></td>
						</tr>
						<tr>
							<td>Renter Occupied Housing</td><td><%= lk("RENTER_OCCUPIED_HOUSING") %></td>
							<td>Doctoral Degree Female</td><td><%= lk("DOCTORAL_DEGREE_FEMALE") %></td>
						</tr>
						<tr>
							<td>Percent Owner Occupied</td><td><%= round(lk("PERCENT_OWNER_OCCUPIED"),2) %></td>
							<td>Pct 25 Yrs Past High School</td><td><%= round(lk("PCT_25YROVER_HIGH_SCHOOL_MORE"),2) %></td>
						</tr>
						<tr>
							<td>Percent Renter Occupied</td><td><%= round(lk("PERCENT_RENTER_OCCUPIED"),2) %></td>
							<td class='e'></td><td class='e'></td>
						</tr>
						<tr>
							<td>Vacancy Rates</td><td><%= round(lk("VACANCY_RATES"),2) %></td>
							<td class='e'></td><td class='e'></td>
						</tr>
						<tr>
							<td>Median Year Built</td><td><%= lk("MEDIAN_YEAR_BUILT")	%></td>
							<td class='e'></td><td class='e'></td>
						</tr>
						<tr>
							<td>Median House Value Owner Occupied</td><td><%= lk("MEDIAN_HOUSE_VALUE_OWNER_OCCU") %>
						</td><td class='e'></td><td class='e'></td>
						</tr>
					</tbody></table>

					<%
						rsCensusTract.movenext
						Loop
						rsCensusTract.close
						Set rsCensusTract=nothing

					%>
					<%
						end if
					%>
					<%
						'Closing All recordsets and connections
						rs.Close
						set rs=Nothing
						cn.Close
						set cn=Nothing
					%>
				</div>
				<br>
				Users may submit their questions  related to the Census data by sending an email to <a href="mailto:gis@brgov.com">gis@brgov.com</a> or contacting the Department of Information Services at (225) 389-3070 or visit the <a class="smalllink" href="http://factfinder.census.gov" target="_blank">US Census Bureau</a> website.
				<br></br>
			</div> 

			<div class="container_footer">
				<!--#include file="includes/footer.asp"-->
			</div>
		</div>
		<br /> <br />
	</body>
</html>
