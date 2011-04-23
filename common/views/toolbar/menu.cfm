<!---

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

--->
<cfset variables.framework.baseURL = "http://#cgi.http_host#/plugins/#getPluginConfig().getDirectory()#/" />
<cfoutput>
	<div class="svoadminutilitytoolbar">
		#view('admin:utility/toolbarsearch')#
		#view('admin:utility/campaignlink', args)#
		<ul class="MainMenu">
			<li class="MenuTop"></li>
			<cfif secureDisplay("admin:main")>
				<cf_ActionCaller action="admin:main" type="list">
				<li>
					<cf_ActionCaller action="admin:product">
					<div class="MenuSubOne">
						<ul>
							<cf_ActionCaller action="admin:product" type="list">
							<cf_ActionCaller action="admin:product.listproducttypes" type="list">
							<cf_ActionCaller action="admin:option" type="list">
							<cf_ActionCaller action="admin:brand" type="list">
						</ul>
					</div>
				</li>
			</cfif>
			<cfif secureDisplay("admin:account")>
				<li>
					<cf_ActionCaller action="admin:account">
					<div class="MenuSubOne">
						<ul>
							<cf_ActionCaller action="admin:account.list" type="list">
						</ul>
					</div>
				</li>
			</cfif>
			<cfif secureDisplay("admin:setting")>
				<li>
					<cf_ActionCaller action="admin:setting">
					<div class="MenuSubOne">
						<ul>
							<cf_ActionCaller action="admin:setting.detail" type="list">
							<cf_ActionCaller action="admin:setting.editpermissions" type="list">
						</ul>
					</div>
				</li>
			</cfif>
			<cfif secureDisplay("admin:help")>
				<li>
					<cf_ActionCaller action="admin:help">
					<div class="MenuSubOne">
						<ul>
							<cf_ActionCaller action="admin:help.about" type="list">
						</ul>
					</div>
				</li>
			</cfif>
			<li class="MenuBottom"></li>
		</ul>
		<ul class="MainToolbar">
			<li class="LogoSearch">
				<img src="/plugins/#getPluginConfig().getDirectory()#/images/toolbar/toolbar_logo.png" />
				<form name="ToolbarSearch" method="post" onKeyup="toolbarSearchKeyup(this);" onSubmit="return slatwallAjaxFormSubmit(this);">
					<input type="hidden" name="action" value="admin:utility.toolbarsearch" />
					<input type="text" name="ToolbarKeyword" class="AdminSearch" />
				</form>
			</li>
			<li><a href="http://#cgi.http_host#/">Website</a></li>
			<cfif getSubsystem(rc.slatAction) eq "frontend" and not $.slatwall.product().isNew()>
				<cf_ActionCaller action="admin:product.detail" queryString="productID=#$.slatwall.product().getProductID()#" type="list">
			</cfif>
		</ul>
	</div>
</cfoutput>
<cfset variables.framework.baseURL = "useRequestURI" />
