{*
/*+********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.0
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ********************************************************************************/
*}
<form>
<table border=0 cellspacing=1 cellpadding=0 width=100%>
<tr><td>
	<!-- List View's Buttons and Filters starts -->
	<table border=0 cellspacing=0 cellpadding=2 width=100% class="small">
	<tr>
	<!-- Buttons -->
			<td style="padding-right:20px" nowrap>
				<input type="hidden" id="search_url" value="{if isset($SEARCH_URL)}{$SEARCH_URL}{/if}">
				<input type="hidden" name="idlist" id="idlist">
				<input name="numOfRows" id="numOfRows" type="hidden" value="{$NUMOFROWS}">
				<input name="maxrecords" type="hidden" value="{$MAX_RECORDS}" id='maxrecords'>
				<input type="hidden" id="excludedRecords" name="excludedRecords" value="{if isset($excludedRecords)}{$excludedRecords}{/if}">
				<input type="hidden" name="allselectedboxes" id="allselectedboxes" value="{$ALLSELECTEDIDS}">
				<input name="current_page_boxes" id="current_page_boxes" type="hidden" value="{$CURRENT_PAGE_BOXES}">
				<input type="hidden" name="selected_module" id="selected_module" value="{$SELECTED_MODULE}">
				<input type="hidden" name="selected_module_translated" id="selected_module_translated" value="{$SELECTED_MODULE|@getTranslatedString:$SELECTED_MODULE}">
				<input class="crmbutton small edit" type="button" onclick ="massRestore();" value="{$MOD.LBL_MASS_RESTORE}">
				{if $IS_ADMIN eq 'true'}
				<input class="crmbutton small delete" type="button" onclick ="callEmptyRecyclebin();" value="{$MOD.LBL_EMPTY_RBMODULE}">
				<input class="crmbutton small delete" type="button" onclick ="document.getElementById('rb_empty_conf_id').style.display = 'block';" value="{$MOD.LBL_EMPTY_RECYCLEBIN}">
				{/if}
			</td>
				<!-- Record Counts -->
			<td style="padding-right:20px" class="small" nowrap>{$RECORD_COUNTS}</td>
			<!-- Page Navigation -->
			<td nowrap width="30%" align="center">
				<table border=0 cellspacing=0 cellpadding=0 class="small">
					<tr>{$NAVIGATION}</tr>
				</table>
			</td>
			<td width=100% align="right" class="cblds-t-align_right">
				<b>{$MOD.LBL_SELECT_MODULE} : </b>
				<select id="select_module" onChange="changeModule(this);" class="small">
				{foreach key=mod_name item=module from=$MODULE_NAME}
				{assign var="modulelabel" value=$module|@getTranslatedString:$module}
				{if $module eq $SELECTED_MODULE}
					<option value="{$module}" selected>{$modulelabel}</option>
				{else}
						<option value="{$module}">{$modulelabel}</option>
				{/if}
				{/foreach}
				</select>
			</td>
		</tr>
	</table>
	<!-- List View's Buttons and Filters ends -->

	<table border=0 cellspacing=1 cellpadding=3 width=100% class="lvt small">
	<!-- Table Headers -->
	<tr>
		<td class="lvtCol" width=2%><input type="checkbox" onclick='toggleSelect_ListView(this.checked,"selected_id")' id="selectCurrentPageRec" name="selectall" ></td>
		{foreach key=mod_data item=moddata from=$MODULE_DATA name="listviewforeach"}
		<td class="lvtCol" >{$moddata}</td>
		{/foreach}
		<td class="lvtCol" >{$APP.LBL_ACTION}</td>
	</tr>
	<tr>
		<td id="linkForSelectAll" class="linkForSelectAll" style="display:none;" colspan=10>
			<span id="selectAllRec" class="selectall" style="display:inline;" onClick="toggleSelectAll_Records('{$MODULE}',true,'selected_id')">{$APP.LBL_SELECT_ALL} <span id="count"> {$NUMOFROWS} </span> {$APP.LBL_RECORDS_IN} {$MODULE|@getTranslatedString:$MODULE}</span>
			<span id="deSelectAllRec" class="selectall" style="display:none;" onClick="toggleSelectAll_Records('{$MODULE}',false,'selected_id')">{$APP.LBL_DESELECT_ALL} {$MODULE|@getTranslatedString:$MODULE}</span>
		</td>
	</tr>
	{foreach key=entity_id item=lvdata from=$lvEntries}
	<tr bgcolor=white onMouseOver="this.className='lvtColDataHover'" onMouseOut="this.className='lvtColData'" id="row_{$entity_id}">
		<td width=2%>{if $entity_id>0}<input type="checkbox" name="selected_id" onclick='check_object(this)' value="{$entity_id}" id="{$entity_id}">{else}<span class="listview_row_sigma">&Sigma;</span>{/if}</td>
		{foreach item=data from=$lvdata}
		<td >{$data}</td>
		{/foreach}
		<td class="small">{if $entity_id>0}<a href="javascript:;" onclick='restore({$entity_id},"{$SELECTED_MODULE}");'>{$MOD.LNK_RESTORE}</a>&nbsp;|&nbsp;<a href='javascript:;' onclick='callEmptyRecyclebin("{$entity_id}");'>{$APP.LNK_DELETE}</a>{/if}</td>
	</tr>
	{foreachelse}
	<tr>
		<td style="background-color:#efefef;height:340px" align="center" colspan="{$smarty.foreach.listviewforeach.iteration+2}">
			<table width=100% height="400px" align="center">
			<tr>
				<td align="center">
					<div style="border: 3px solid rgb(153, 153, 153); background-color: rgb(255, 255, 255);width:90%; margin: 0 auto;">
					<table cellspacing=0 cellpadding=5 width=98% border=0 align=center class="cblds-t-align_center">
						<tr>
							<td rowspan="2" width="30%" align='right' class="cblds-t-align_right"><img src="{'empty.jpg'|@vtiger_imageurl:$THEME}" height="60"></td>
							<td style="border-bottom: 1 px solid rgb(204, 204, 204);" nowrap="nowrap" width="75%"><span class="genHeaderSmall">{$MOD.LBL_EMPTY_MODULE} {$SELECTED_MODULE|@getTranslatedString:$SELECTED_MODULE}</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
		</table>
	</td>
	</tr>
	{/foreach}
	</table>
	</td>
	</tr>
<tr><td>
	<table border=0 cellspacing=0 cellpadding=2 width=100% class="small">
		<tr>
			<!-- Buttons -->
			<td style="padding-right:20px" nowrap>
				<input type="hidden" name="idlist" id="idlist">
				<input type="hidden" name="selected_module" id="selected_module" value="{$SELECTED_MODULE}">
				<input class="crmbutton small edit" type="button" onclick ="massRestore();" value="{$MOD.LBL_MASS_RESTORE}">
				{if $IS_ADMIN eq 'true'}
					<input class="crmbutton small delete" type="button" onclick ="callEmptyRecyclebin();" value="{$MOD.LBL_EMPTY_RBMODULE}">
					<input class="crmbutton small delete" type="button" onclick ="document.getElementById('rb_empty_conf_id').style.display = 'block';" value="{$MOD.LBL_EMPTY_RECYCLEBIN}">
				{/if}
			</td>
			<!-- Record Counts -->
			<td style="padding-right:20px" class="small" nowrap>{$RECORD_COUNTS}</td>
			<!-- Page Navigation -->
			<td nowrap width="30%" align="center">
				<table border=0 cellspacing=0 cellpadding=0 class="small">
					<tr>{$NAVIGATION}</tr>
				</table>
			</td>
			<td width=100% align="right">&nbsp;</td>
		</tr>
	</table>
</td></tr>
</table>
</div>

{if isset($smarty.request.mode) and $smarty.request.mode eq 'ajax'}
	<div id="search_ajax" style="display:none;">
	{include "modules/RecycleBin/RecycleBinSearch.tpl"}
	</div>
{/if}
</form>
