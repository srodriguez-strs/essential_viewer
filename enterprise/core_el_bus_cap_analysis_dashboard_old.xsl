<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" xpath-default-namespace="http://protege.stanford.edu/xml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xalan="http://xml.apache.org/xslt" xmlns:pro="http://protege.stanford.edu/xml" xmlns:eas="http://www.enterprise-architecture.org/essential" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ess="http://www.enterprise-architecture.org/essential/errorview">
	<xsl:import href="../common/core_js_functions.xsl"></xsl:import>
	<xsl:include href="../common/core_roadmap_functions.xsl"></xsl:include>
	<xsl:include href="../common/core_doctype.xsl"></xsl:include>
	<xsl:include href="../common/core_common_head_content.xsl"></xsl:include>
	<xsl:include href="../common/core_header.xsl"></xsl:include>
	<xsl:include href="../common/core_footer.xsl"></xsl:include>
	<xsl:include href="../common/core_external_doc_ref.xsl"></xsl:include>

	<xsl:output method="html" omit-xml-declaration="yes" indent="yes"></xsl:output>

	<xsl:param name="param1"></xsl:param>

	<!-- START GENERIC PARAMETERS -->
	<xsl:param name="viewScopeTermIds"></xsl:param>

	<!-- END GENERIC PARAMETERS -->

	<!-- START GENERIC LINK VARIABLES -->
	<xsl:variable name="viewScopeTerms" select="eas:get_scoping_terms_from_string($viewScopeTermIds)"></xsl:variable>
	<xsl:variable name="linkClasses" select="('Business_Capability', 'Application_Provider', 'Application_Service', 'Business_Process', 'Business_Activity', 'Business_Task')"></xsl:variable>
	<!-- END GENERIC LINK VARIABLES -->
	<xsl:variable name="reportPath" select="/node()/simple_instance[type = 'Report'][own_slot_value[slot_reference='name']/value='Core: Application Rationalisation Analysis']"/>
	

	<!--
		* Copyright © 2008-2017 Enterprise Architecture Solutions Limited.
	 	* This file is part of Essential Architecture Manager, 
	 	* the Essential Architecture Meta Model and The Essential Project.
		*
		* Essential Architecture Manager is free software: you can redistribute it and/or modify
		* it under the terms of the GNU General Public License as published by
		* the Free Software Foundation, either version 3 of the License, or
		* (at your option) any later version.
		*
		* Essential Architecture Manager is distributed in the hope that it will be useful,
		* but WITHOUT ANY WARRANTY; without even the implied warranty of
		* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		* GNU General Public License for more details.
		*
		* You should have received a copy of the GNU General Public License
		* along with Essential Architecture Manager.  If not, see <http://www.gnu.org/licenses/>.
		* 
	<xsl:variable name="allRoadmapInstances" select="$apps"/>
    <xsl:variable name="isRoadmapEnabled" select="eas:isRoadmapEnabled($allRoadmapInstances)"/>
	<xsl:variable name="rmLinkTypes" select="$allRoadmapInstances/type"/>	
	 
	-->
	<xsl:variable name="busCapData" select="$utilitiesAllDataSetAPIs[own_slot_value[slot_reference = 'name']/value = 'Core API: BusCap to App Mart']"></xsl:variable>
	<xsl:template match="knowledge_base">
		<xsl:call-template name="docType"></xsl:call-template>
		<xsl:variable name="apiBCM">
			<xsl:call-template name="GetViewerAPIPath">
				<xsl:with-param name="apiReport" select="$busCapData"></xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<html>
			<head>
				<xsl:call-template name="commonHeadContent"></xsl:call-template>
				<xsl:for-each select="$linkClasses">
					<xsl:call-template name="RenderInstanceLinkJavascript">
						<xsl:with-param name="instanceClassName" select="current()"></xsl:with-param>
						<xsl:with-param name="targetMenu" select="()"></xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
				<title>Business Capability Model</title>
				<style>
					.l0-cap{
						border: 1pt solid #ccc;
						border-left: 3px solid hsla(200, 80%, 50%, 1);
						border-bottom: 1px solid #999;
						padding: 10px;
						margin-bottom: 15px;
						font-weight: 700;
						position: relative;
					}
					.l1-caps-wrapper{
						display: flex;
						flex-wrap: wrap;
						margin-top: 10px;
					}
					
					.l2-caps-wrapper,.l3-caps-wrapper,.l4-caps-wrapper,.l5-caps-wrapper,.l6-caps-wrapper{
						margin-top: 10px;
					}
					
					.l1-cap,.l2-cap,.l3-cap,.l4-cap{
						border-bottom: 1px solid #999;
						padding: 5px;
						margin: 0 10px 10px 0;
						font-weight: 400;
						position: relative;
						min-height: 60px;
						line-height: 1.1em;
					}
					
					.l1-cap{
						min-width: 200px;
						width: 200px;
						max-width: 200px;
					}
					
					.l2-cap{
						border: 1pt solid #ccc;
						border-left: 3px solid hsla(200, 80%, 50%, 1);					
						background-color: #fff;
						min-width: 180px;
						width: 180px;
						max-width: 180px;
					}
					
					.l3-cap{
						border: 1pt solid #ccc;
						border-left: 3px solid rgb(125, 174, 198);					
						background-color: rgb(218, 214, 214);
						min-width: 160px;
						width: 160px;
						max-width: 160px;
						min-height: 60px;

					}
					
					.l4-cap{
						border: 1pt solid #ccc;
						border-left: 3px solid rgb(180, 200, 210);					
						background-color: rgb(164, 164, 164);
						min-width: 140px;
						width: 140px;
						max-width: 140px;
						min-height: 60px;

					}

					.l5on-cap{
						min-width: 90%;
						width: 90%; 
						min-height: 50px;
						border:1pt solid #d3d3d3;
						background-color:#fff;
						margin:2px;

					}
					
					.cap-label,.sub-cap-label{
						margin-right: 5px;
						margin-bottom: 10px;
					}
					
					.sidenav{
						height: calc(100vh - 41px);
						width: 350px;
						position: fixed;
						z-index: 1;
						top: 41px;
						right: 0;
						background-color: #f6f6f6;
						overflow-x: hidden;
						transition: margin-right 0.5s;
						padding: 10px 10px 10px 10px;
						box-shadow: rgba(0, 0, 0, 0.5) -1px 2px 4px 0px;
						margin-right: -352px;
					}
					
					.sidenav .closebtn{
						position: absolute;
						top: 5px;
						right: 5px;
						font-size: 14px;
						margin-left: 50px;
					}
					
					@media screen and (max-height : 450px){
						.sidenav{
							padding-top: 15px;
						}
					
						.sidenav a{
							font-size: 14px;
						}
					}
					
					.app-list-scroller {
						height: calc(100vh - 150px);
						overflow-x: hidden;
						overflow-y: auto;
					}
					
					.appBox{
						border-radius: 4px;
						margin-bottom: 10px;
						float: left;
						width: 100%;
						border: 1px solid #333;
					}
					
					.appBox a {
						color: #fff!important;
					}
					
					.appBox a:hover {
						color: #ddd!important;
					}
					
					.appBoxSummary {
						background-color: #333;
						padding: 5px;
						float: left;
						width: 100%;
					}
					
					.appBoxTitle {
						width: 200px;
						white-space: nowrap;
						overflow: hidden;
						text-overflow: ellipsis;
					}
					
					.appInfoButton {
						position: absolute;
						bottom: 5px;
						right: 5px;
					}
					
					.app-circle{
						display: inline-block;
						min-width: 10px;
						padding: 2px 5px;
						font-size: 10px;
						font-weight: 700;
						line-height: 1;
						text-align: center;
						white-space: nowrap;
						vertical-align: middle;
						background-color: #fff;
						color: #333;
						border-radius: 10px;
						border: 1px solid #ccc;
					}
					
					.app-circle:hover {
						background-color: #333;
						color: #fff;
						cursor: pointer;
					}

					.lifecycle{
						position: relative;
						/* height: 20px; */
						border-radius: 8px;
						min-width: 60px;
						font-size: 11px;
						line-height: 11px;
						padding: 2px 4px;
						border: 2px solid #fff;
						text-align: center;
						background-color: grey;
						color: #fff;
					}

					.lifecycleMain{
						position:relative;
						right:0px;
						bottom:20px;
						height:20px;
						border-radius:5pt;
						width:80px;
						font-size:10pt;
						border:1pt solid #d3d3d3; 
						text-align:center;
						background-color:grey;
						color:#fff;
					}

					.blob{
						height:10px;
						border-radius:8px;
						width:30px;
						border:1px solid #666; 
						background-color: #ccc;
						}

					.blobNum{
						color: rgb(140, 132, 112);
						font-weight:bold;
						font-size:9pt;
						text-align:center;
					}
					
					.blobBox,.blobBoxTitle{
						display: inline-block;
					}
					
					.blobBox {
						position: relative;
						top: -12px;
					}
					#appPanel {
						background-color: rgba(0,0,0,0.85);
						padding: 10px;
						border-top: 1px solid #ccc;
						position: fixed;
						bottom: 0;
						left: 0;
						z-index: 100;
						width: 100%;
						height: 350px;
						color: #fff;
					}
					#appData{

                    }
                    .dark a {
                    	color: #fff;
                    }
					
					.smallCardWrapper {
						display: flex;
						flex-wrap: wrap;
					}

					.smallCard{
						width:160px; 
						height:60px;
						min-height:60px;
						max-height:60px;
						margin: 0 10px 10px 0;
						padding:5px;
						border-radius:4px;
						line-height: 1em;
					}

					.noneMapped{
						background-color: #f6f6f6;
						border: 1pt solid #ccc;
						border-bottom: 1px solid #aaa;
						color: #aaa;
					} 

					.caps {
						background-color: #fff;;
						border: 1pt solid #ccc;
						border-bottom: 1px solid #aaa;
						border-left:3px solid #a93e4e;
						}
						
					.procs {
						background-color: #fff;;
						border: 1pt solid #ccc;
						border-bottom: 1px solid #aaa;
						border-left:3px solid #8c50d2;

						}
					.svcs {
						background-color: #fff;;
						border: 1pt solid #ccc;
						border-bottom: 1px solid #aaa;
						border-left:3px solid #d7a51b;
					}
					.iconCube{
						background-color: #fff;
						border: 1pt solid #ccc;
						color: #333;
						width: 50px;
						min-width: 50px;
						margin-right: 5px;
						line-height: 12px;
						padding: 3px 4px;
						border-radius: 4px;
						display: inline-block;
					}

					.iconCubeHeader{
						margin-right: 10px;
						font-size: 12px;
						display: inline-block;
					}
					
					.mini-details {
						display: none;
						position: relative;
						float: left;
						width: 100%;
						padding: 5px 5px 0 5px;
						background-color: #454545;
					}
					
					.tab-content {
                    	padding-top: 10px;
                    }
                    .ess-tag-default {
                    	background-color: #adb5bd;
                    	color: #333;
                    }
                    
                    .ess-tag-default > a{
                    	color: #333!important;
                    }
                    
                    .ess-tag {
                    	padding: 3px 12px;
                    	border: 1px solid #222;
                    	border-radius: 16px;
                    	margin-right: 10px;
                    	margin-bottom: 5px;
                    	display: inline-block;
                    	font-weight: 700;
                    }
                	.inline-block {display: inline-block;}
                	.ess-small-tabs > li > a {
                		padding: 5px 15px;
                	}
                	.badge.dark {
                		background-color: #555!important;
                	}
                	.vertical-scroller {
                		overflow-x:hidden;
                		overflow-y: auto;
                		padding-right: 5px;
                	}
					.Key {
						position:relative;
						top:-30px;
					}
					.shigh{color: #d59deb}
					.smed {color:#e0beed}
					.slow{color: #eee1f4 }
                	.vertical-scroller.dark::-webkit-scrollbar { width: 8px; height: 3px;}
					.vertical-scroller.dark::-webkit-scrollbar-button {  background-color: #666; }
					.vertical-scroller.dark::-webkit-scrollbar-track {  background-color: #646464;}
					.vertical-scroller.dark::-webkit-scrollbar-track-piece { background-color: #222;}
					.vertical-scroller.dark::-webkit-scrollbar-thumb { height: 50px; background-color: #666; border-radius: 3px;}
					.vertical-scroller.dark::-webkit-scrollbar-corner { background-color: #646464;}}
					.vertical-scroller.dark::-webkit-resizer { background-color: #666;}
					
					table.sticky-headers > thead > tr > th {
						position: sticky;
						top: -10px;
					}
					input.form-control.dark {
						color: #333;
					}
				</style>
				<!--	 <xsl:call-template name="RenderRoadmapJSLibraries">
					<xsl:with-param name="roadmapEnabled" select="$isRoadmapEnabled"/>
				</xsl:call-template>
				-->
			</head>
			<body>
				<!-- ADD THE PAGE HEADING -->
				<xsl:call-template name="Heading"></xsl:call-template>
				<!--	<xsl:if test="$isRoadmapEnabled">
					<xsl:call-template name="RenderRoadmapWidgetButton"/>
				</xsl:if>
				<div id="ess-roadmap-content-container">
					<xsl:call-template name="RenderCommonRoadmapJavscript">
						<xsl:with-param name="roadmapInstances" select="$allRoadmapInstances"/>
						<xsl:with-param name="isRoadmapEnabled" select="$isRoadmapEnabled"/>
					</xsl:call-template>
				
					<div class="clearfix"></div>
				</div>
			-->
				<!--ADD THE CONTENT-->
				<div class="container-fluid">
					<div class="row">
						<div class="col-xs-12">
							<div class="page-header">
								<h1>
									<span class="text-primary"><xsl:value-of select="eas:i18n('View')"></xsl:value-of>: </span>
									<span class="text-darkgrey"><xsl:value-of select="eas:i18n('Business Capability Model')"></xsl:value-of> - </span>
									<span class="text-primary">
										<span id="rootCap"></span>
									</span>
								</h1>
							</div>
						</div>
						<div class="col-xs-12">
							<div id="blobLevel" ></div>
							<div class="pull-right Key"><b>Application Usage Key</b>: <i class="fa fa-square shigh"></i> - High<xsl:text> </xsl:text> <i class="fa fa-square smed"></i> - Medium <xsl:text> </xsl:text> <i class="fa fa-square slow"></i> - Low</div>
						</div>
						<div class="col-xs-12" id="capModelHolder">
						</div>
						<div id="appSidenav" class="sidenav">
							<button class="btn btn-default appRatButton bottom-15 saveApps"><i class="fa fa-external-link right-5 text-primary "/>View in Rationalisation</button>
							<a href="javascript:void(0)" class="closebtn text-default" onclick="closeNav()">
								<i class="fa fa-times"></i>
							</a>
							<div class="clearfix"/>
							<!--<div class="iconCubeHeader"><i class="fa fa-th-large right-5"></i>Capabilities</div>
							<div class="iconCubeHeader"><i class="fa fa-users right-5"></i>Users</div>
							<div class="iconCubeHeader"><i class="fa essicon-boxesdiagonal right-5"></i>Processes</div>
							<div class="iconCubeHeader"><i class="fa essicon-radialdots right-5"></i>Services</div>-->
							<div class="app-list-scroller top-5">

								<div id="appsList"></div>
							</div>
						</div>
						<!--Setup Closing Tags-->
					</div>
				</div>


				<!-- Modal for content
				<div id="appModal" class="modal fade" role="dialog">
					<div class="modal-dialog">

						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal">
									<i class="fa fa-times"></i>
								</button>
								<h4 class="modal-title">APP INFORMATION</h4>
							</div>
							<div class="modal-body">
								<div id="appInfo">APP INFORMATION</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				-->

				<div class="appPanel" id="appPanel">
						<div id="appData"></div>
				</div>

				<!-- ADD THE PAGE FOOTER -->
				<xsl:call-template name="Footer"></xsl:call-template>

				<!-- caps template -->
				<script id="model-l0-template" type="text/x-handlebars-template">
		         	<div class="capModel">
						{{#each this}}
							<div class="l0-cap"><xsl:attribute name="level">{{this.level}}</xsl:attribute>
								<span class="cap-label">{{name}}</span>
								<span class="app-circle "> <xsl:attribute name="easidscore">{{id}}</xsl:attribute>{{this.apps.length}}</span>
							
									{{> l1CapTemplate}}
								 
							</div>
						{{/each}}
					</div>
				</script>

				<!-- SubCaps template called iteratively -->
				<script id="model-l1cap-template" type="text/x-handlebars-template">
					<div class="l1-caps-wrapper caplevel"><xsl:attribute name="level">{{#getLevel this.level}}{{/getLevel}}</xsl:attribute>
						{{#each this.childrenCaps}}
						<div class="l1-cap bg-lightblue-20">
							<span class="sub-cap-label">{{name}}</span>
							<span class="app-circle "><xsl:attribute name="easidscore">{{id}}</xsl:attribute>{{this.apps.length}}</span>
								{{> l2CapTemplate}} 	 
						</div>
						{{/each}}
					</div>
				</script>
				
				<!-- SubCaps template called iteratively -->
				<script id="model-l2cap-template" type="text/x-handlebars-template">
					<div class="l2-caps-wrapper caplevel"><xsl:attribute name="level">{{#getLevel this.level}}{{/getLevel}}</xsl:attribute>
						{{#each this.childrenCaps}}
						<div class="l2-cap">
							<span class="sub-cap-label">{{name}}</span>
							<span class="app-circle "><xsl:attribute name="easidscore">{{id}}</xsl:attribute>{{this.apps.length}}</span>
					
								{{> l3CapTemplate}} 	 
						</div>
						{{/each}}
					</div>
				</script>
				
				<!-- SubCaps template called iteratively -->
				<script id="model-l3cap-template" type="text/x-handlebars-template">
					<div class="l3-caps-wrapper caplevel"><xsl:attribute name="level">{{#getLevel this.level}}{{/getLevel}}</xsl:attribute>
						{{#each this.childrenCaps}}
						<div class="l3-cap bg-lightblue-80">
							<span class="sub-cap-label">{{name}}</span>
							<span class="app-circle "><xsl:attribute name="easidscore">{{id}}</xsl:attribute>{{this.apps.length}}</span>						 
								{{> l4CapTemplate}} 		 
						</div>
						{{/each}}
					</div>	
				</script>

				<script id="model-l4cap-template" type="text/x-handlebars-template">
					<div class="l4-caps-wrapper caplevel"><xsl:attribute name="level">{{#getLevel this.level}}{{/getLevel}}</xsl:attribute>
					{{#each this.childrenCaps}}
					<div class="l4-cap bg-lightblue-80">
						<span class="sub-cap-label">{{name}}</span>
						<span class="app-circle "><xsl:attribute name="easidscore">{{id}}</xsl:attribute>{{this.apps.length}}</span>		
							{{> l5CapTemplate}}		 
					</div>
					{{/each}}
					</div>
			</script>
				
				<!-- SubCaps template called iteratively -->
				<script id="model-l5cap-template" type="text/x-handlebars-template">
					<div class="l4-caps-wrapper caplevel"><xsl:attribute name="level">{{#getLevel this.level}}{{/getLevel}}</xsl:attribute>
						{{#each this.childrenCaps}}
						<div class="l5on-cap bg-lightblue-20">
							<span class="sub-cap-label">{{name}}</span>
							<span class="app-circle "><xsl:attribute name="easidscore">{{id}}</xsl:attribute>{{this.apps.length}}</span>	 
							<div class="l5-caps-wrapper caplevel"><xsl:attribute name="level">{{#getLevel this.level}}{{/getLevel}}</xsl:attribute>
									{{> l5CapTemplate}}
								</div>	
						</div>
						{{/each}}
					</div>	
				</script>
				<script id="blob-template" type="text/x-handlebars-template">
					<div class="blobBoxTitle right-10"> 
						<strong>Select Level:</strong>
					</div> 
					{{#each this}}
					<div class="blobBox">
						<div class="blobNum">{{this.level}}</div>
					  	<div class="blob"><xsl:attribute name="id">{{this.level}}</xsl:attribute></div>
					</div>
					{{/each}}
					<div class="blobBox">
						<br/>
						<div class="blobNum"> 
						<!--  hover over to say that blobs are clickable to chnage level
							<i class="fa fa-info-circle levelinfo " style="font-size:10pt"> 
							</i>
						-->	 
						</div>
				
					</div>
				</script>	

				<!-- Apps list for sidebar -->
				<script id="appList-template" type="text/x-handlebars-template">
					{{#each this}}	
						{{#each this.apps}}
							<div class="appBox">
								<xsl:attribute name="easid">{{id}}</xsl:attribute>
								<div class="appBoxSummary">
									<div class="appBoxTitle pull-left strong">
										<xsl:attribute name="title">{{this.name}}</xsl:attribute>
										<i class="fa fa-caret-right fa-fw right-5 text-white" onclick="toggleMiniPanel(this)"/>{{{this.link}}}
									</div>
									<div class="lifecycle pull-right">
										<xsl:attribute name="style">background-color:{{lifecycleColor}};color:{{#if lifecycleText}}{{lifecycleText}}{{else}}#000000{{/if}}</xsl:attribute>
										{{this.lifecycle}}
									</div>
								</div>
								<div class="clearfix"/>
								<div class="mini-details">
									<div class="small pull-left text-white">
										<div class="left-5 bottom-5"><i class="fa fa-th-large right-5"></i>{{capabilities.length}} Supported Business Capabilities</div>
										<div class="left-5 bottom-5"><i class="fa fa-users right-5"></i>{{orgUserIds.length}} Supported Organisations</div>
										<div class="left-5 bottom-5"><i class="fa essicon-boxesdiagonal right-5"></i>{{processes.length}} Supported Processes</div>
										<div class="left-5 bottom-5"><i class="fa essicon-radialdots right-5"></i>{{services.length}} Services Provided</div>
									</div>

										<button class="btn btn-default btn-xs appInfoButton pull-right"><xsl:attribute name="easid">{{id}}</xsl:attribute>Show Details</button>
									
								</div>
								<div class="clearfix"/>
							</div>
						{{/each}}
					{{/each}}
				</script>

				<script id="app-template" type="text/x-handlebars-template">
					<div class="row">
	            		<div class="col-sm-8">
	            			<h4 class="text-normal strong inline-block right-30">{{name}}</h4>
	            			<!--<div class="ess-tag ess-tag-default"><i class="fa fa-money right-5"/>Cost: {{costValue}}</div>
	                		<div class="inline-block">{{#calcComplexity totalIntegrations capsCount processesSupporting servicesUsed.length}}{{/calcComplexity}}</div>-->
	            		</div>
	            		<div class="col-sm-4">
	            			<div class="text-right">
	            				<!--<span class="dropdown">
	            					<button class="btn btn-default btn-sm dropdown-toggle panelHistoryButton" data-toggle="dropdown"><i class="fa fa-clock-o right-5"/>Panel History<i class="fa fa-caret-down left-5"/></button>
		            				<ul class="dropdown-menu dropdown-menu-right">
										<li><a href="#">Page 1</a></li>
										<li><a href="#">Page 2</a></li>
										<li><a href="#">Page 3</a></li>
									</ul>
	            				</span>-->
	            				<i class="fa fa-times closePanelButton left-30"></i>
	            			</div>
	            			<div class="clearfix"/>
	            		</div>
	            	</div>
					
					<div class="row">
	                	<div class="col-sm-12">
							<ul class="nav nav-tabs ess-small-tabs">
								<li class="active"><a data-toggle="tab" href="#summary">Summary</a></li>
								<li><a data-toggle="tab" href="#capabilities">Capabilities<span class="badge dark">{{capabilitiesSupporting}}</span></a></li>
								<li><a data-toggle="tab" href="#processes">Processes<span class="badge dark">{{processesSupporting}}</span></a></li>
								<li><a data-toggle="tab" href="#integrations">Integrations<span class="badge dark">{{totalIntegrations}}</span></a></li>
			                 	<li><a data-toggle="tab" href="#services">Services</a></li>
								<li></li>
							</ul>

					
							<div class="tab-content">
								<div id="summary" class="tab-pane fade in active">
									<div>
				                    	<strong>Description</strong>
				                    	<br/>
				                        {{description}}    
				                    </div>
		                			<div class="ess-tags-wrapper top-10">
		                				<div class="ess-tag ess-tag-default"><xsl:attribute name="style">background-color:#2EB8BF;color:#ffffff</xsl:attribute>
											<i class="fa fa-code right-5"/>{{codebase}}</div>
		                				<div class="ess-tag ess-tag-default">
												<xsl:attribute name="style">background-color:#24A1B7;color:#ffffff</xsl:attribute>
											<i class="fa fa-desktop right-5"/>{{appDelivery}}</div>
		                				<div class="ess-tag ess-tag-default">
												<xsl:attribute name="style">background-color:#A884E9;color:#ffffff</xsl:attribute>
												<i class="fa fa-users right-5"/>{{processesSupporting}} Processes Supported</div>
		                				<div class="ess-tag ess-tag-default">
												<xsl:attribute name="style">background-color:#6849D0;color:#ffffff</xsl:attribute>
												<i class="fa fa-exchange right-5"/>{{totalIntegrations}} Integrations ({{inboundIntegrations}} in / {{outboundIntegrations}} out)</div>
		                			</div>
								</div>
								<div id="capabilities" class="tab-pane fade">
									<p class="strong">This Application supports the following Business Capabilities:</p>
									<div>
									{{#if capabilities}}
									{{#each capabilities}}
										<div class="ess-tag ess-tag-default"><xsl:attribute name="style">background-color:#f5ffa1;color:#ffffff</xsl:attribute>{{{link}}}</div>
									{{/each}}
									{{else}}
										<p class="text-muted">None Mapped</p>
									{{/if}}
									</div>
								</div> 
								<div id="processes" class="tab-pane fade">
									<p class="strong">This Application supports the following Business Processes:</p>
									<div>
									{{#if processes}}
									{{#each processes}}
										<div class="ess-tag ess-tag-default"><xsl:attribute name="style">background-color:#dccdf6;color:#ffffff</xsl:attribute>{{{link}}}</div>
									{{/each}} 
									{{else}}
										<p class="text-muted">None Mapped</p>
									{{/if}}
									</div>
								</div>
								<div id="services" class="tab-pane fade">
									<p class="strong">This Application supports the following Services:</p>
									<div>
									{{#if services}}
									{{#each services}}
										<div class="ess-tag ess-tag-default"><xsl:attribute name="style">background-color:#73B9EE;color:#ffffff</xsl:attribute>{{{link}}}</div>
									{{/each}} 
									{{else}}
										<p class="text-muted">None Mapped</p>
									{{/if}}
									</div>
								</div>
								<div id="integrations" class="tab-pane fade">
			                    <p class="strong">This Application has the following Integrations:</p>
			                	<div class="row">
			                		<div class="col-md-6">
			                			<div class="impact bottom-10">Inbound</div>
			                				{{#each inboundIntegrationList}}
			                                <div class="ess-tag bg-lightblue-100">{{name}}</div>
			                            	{{/each}}
			                		</div>
			                		<div class="col-md-6">
			                			<div class="impact bottom-10">Outbound</div>
			                				{{#each outboundIntegrationList}}
			                                <div class="ess-tag bg-pink-100">{{name}}</div>
			                            	{{/each}}
			                		</div>
			                	</div>
			                </div>
			                 
							</div>
						</div>
					</div>
				</script>

			</body>
			<script>			
				<xsl:call-template name="RenderViewerAPIJSFunction">
					<xsl:with-param name="viewerAPIPath" select="$apiBCM"></xsl:with-param> 
				</xsl:call-template>  
			</script>
		</html>
	</xsl:template>


	<xsl:template name="RenderViewerAPIJSFunction">
		<xsl:param name="viewerAPIPath"></xsl:param>
		//a global variable that holds the data returned by an Viewer API Report
		var viewAPIData = '<xsl:value-of select="$viewerAPIPath"/>';
		
		//set a variable to a Promise function that calls the API Report using the given path and returns the resulting data
		
		var promise_loadViewerAPIData = function (apiDataSetURL)
		{
			return new Promise(function (resolve, reject)
			{
				if (apiDataSetURL != null)
				{
					var xmlhttp = new XMLHttpRequest();
					xmlhttp.onreadystatechange = function ()
					{
						if (this.readyState == 4 &amp;&amp; this.status == 200)
						{
							
							var viewerData = JSON.parse(this.responseText);
							resolve(viewerData);
						}
					};
					xmlhttp.onerror = function ()
					{
						reject(false);
					};
					
					xmlhttp.open("GET", apiDataSetURL, true);
					xmlhttp.send();
				} else
				{
					reject(false);
				}
			});
		};
		
		var level=0;
		var rationalisationList=[];
		let levelArr=[];
		let workingAppsList=[];
		var partialTemplate, l0capFragment;
		$('document').ready(function ()
		{
			l0capFragment = $("#model-l0-template").html();
			l0CapTemplate = Handlebars.compile(l0capFragment);
			
			templateFragment = $("#model-l1cap-template").html();
			l1CapTemplate = Handlebars.compile(templateFragment);
			Handlebars.registerPartial('l1CapTemplate', l1CapTemplate);
			
			templateFragment = $("#model-l2cap-template").html();
			l2CapTemplate = Handlebars.compile(templateFragment);
			Handlebars.registerPartial('l2CapTemplate', l2CapTemplate);
			
			templateFragment = $("#model-l3cap-template").html();
			l3CapTemplate = Handlebars.compile(templateFragment);
			Handlebars.registerPartial('l3CapTemplate', l3CapTemplate);
			
			templateFragment = $("#model-l4cap-template").html();
			l4CapTemplate = Handlebars.compile(templateFragment);
			Handlebars.registerPartial('l4CapTemplate', l4CapTemplate);

			templateFragment = $("#model-l5cap-template").html();
			l5CapTemplate = Handlebars.compile(templateFragment);
			Handlebars.registerPartial('l5CapTemplate', l5CapTemplate);

			appFragment = $("#app-template").html();
			appTemplate = Handlebars.compile(appFragment);		

			blobsFragment = $("#blob-template").html();
			blobTemplate = Handlebars.compile(blobsFragment);
			
			appListFragment = $("#appList-template").html();
			appListTemplate = Handlebars.compile(appListFragment);

			Handlebars.registerHelper('getLevel', function(arg1) {
				return parseInt(arg1) + 1; 
			});
			Handlebars.registerHelper('getColour', function(arg1) {
				let colour='#fff';

				if(parseInt(arg1) &lt;2){colour='#eee1f4'}
				else if(parseInt(arg1) &lt;6){colour='#e0beed'}
				else if(parseInt(arg1) &gt;5){colour='#d59deb'}

				return colour; 
			});
			 

			$('.appPanel').hide();

			Promise.all([
			promise_loadViewerAPIData(viewAPIData)]).then(function (responses)
			{
				let workingArray = responses[0];
				console.log(workingArray.busCapHierarchy)

			 	getArrayDepth(workingArray.busCapHierarchy)
			 
				level=Math.max(...levelArr);
				levelArr=[];
				for(i=0;i&lt;level+1;i++){  
					levelArr.push({"level":i+1});	 
				}
				$('#blobLevel').html(blobTemplate(levelArr))

				$('.blob').on('click',function(){
					let thisLevel=$(this).attr('id')
					$('.caplevel').show();
					$('.caplevel[level='+thisLevel+']').hide();
					$('.blob').css('background-color','#ffffff')
					for(i=0;i&lt;thisLevel;i++){
						$('.blob[id='+(i+1)+']').css('background-color','#ccc')
					}
				})

				$('#rootCap').text(workingArray.rootCap);

				$('#capModelHolder').html(l0CapTemplate(workingArray.busCapHierarchy));
				
				workingArray.busCaptoAppDetails.forEach(function (d)
				{
					let appCount=d.apps.length;
					$('*[easidscore="' + d.id + '"]').html(appCount);
					let colour='#fff'
					if(appCount &lt;2){colour='#e8d3f0'}
					else if(appCount &lt;6){colour='#e0beed'}
					else{colour='#d59deb'}
					$('*[easidscore="' + d.id + '"]').css('background-color',colour)

				});
				 
				$('.app-circle').on("click", function ()
				{
					let selected = $(this).attr('easidscore')
					console.log(selected)
					let thisappList = workingArray.busCaptoAppDetails.filter(function (d)
					{
						return d.id == selected;
					});

					workingAppsList=thisappList;
					$('#appsList').html(appListTemplate(thisappList))
					openNav();
					console.log(thisappList);
					
					thisappList[0].apps.forEach((d)=>{
						 rationalisationList.push(d.id)
					})	;
console.log('rationalisationList')
console.log(rationalisationList)					
					$(".appInfoButton").on("click", function ()
					{
						let selected = $(this).attr('easid')
						console.log(selected)
						
						let appToShow =workingAppsList[0].apps.filter((d)=>{
							return d.id==selected;	
						})
						console.log(appToShow)
						$('#appData').html(appTemplate(appToShow[0]));
						$('.appPanel').show( "blind",  { direction: 'down', mode: 'show' },500 );

						//$('#appModal').modal('show');
						$('.closePanelButton').on('click',function(){
							console.log('clicked')
							$('.appPanel').hide();
						})
					});

					var thisf=$('*').filter(function() {
						return $(this).data('level') !== undefined;
					});

					$(".saveApps").on('click', function(){
						console.log('clicke save')
						var apps={};
						apps['Composite_Application_Provider']=rationalisationList;
						console.log(apps)
						sessionStorage.setItem("context", JSON.stringify(apps));
						location.href='report?XML=reportXML.xml&amp;XSL=<xsl:value-of select="$reportPath/own_slot_value[slot_reference='report_xsl_filename']/value"/>&amp;PMA=bcm'
					});
					 
				})
			}). catch (function (error)
			{
				//display an error somewhere on the page
			});
			
		});

		function getArrayDepth(arr){  
			arr.forEach((d)=>{
			levelArr.push(parseInt(d.level))
			getArrayDepth(d.childrenCaps);
			 })
		  }	  

		function openNav()
		{
			document.getElementById("appSidenav").style.marginRight = "0";
		}
		
		function closeNav()
		{
			document.getElementById("appSidenav").style.marginRight = "-352px";
		}
	
		/*Auto resize panel during scroll*/
		$(window).scroll(function() {
			if ($(this).scrollTop() &gt; 40) {
				$('#appSidenav').css('position','fixed');
				$('#appSidenav').css('height','calc(100%)');
				$('#appSidenav').css('top','0');
			}
			if ($(this).scrollTop() &lt; 40) {
				$('#appSidenav').css('position','fixed');
				$('#appSidenav').css('height','calc(100% - 40px)');
				$('#appSidenav').css('top','41px');
			}
		});
		$('.closePanel').slideDown();
		
		function toggleMiniPanel(element){
			$(element).parent().parent().nextAll('.mini-details').slideToggle();
			$(element).toggleClass('fa-caret-right');
			$(element).toggleClass('fa-caret-down');
		};

	</xsl:template>

	<xsl:template name="GetViewerAPIPath">
		<xsl:param name="apiReport"></xsl:param>

		<xsl:variable name="dataSetPath">
			<xsl:call-template name="RenderAPILinkText">
				<xsl:with-param name="theXSL" select="$apiReport/own_slot_value[slot_reference = 'report_xsl_filename']/value"></xsl:with-param>
			</xsl:call-template>
		</xsl:variable>

		<xsl:value-of select="$dataSetPath"></xsl:value-of>

	</xsl:template>
</xsl:stylesheet>
