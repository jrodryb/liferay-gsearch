<%@ include file="/init.jsp" %>

<div class="container-fluid gsearch-container">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 gsearch-centered gsearch-results" id="<portlet:namespace />SearchResults"></div>
</div>

<aui:script>

	function <portlet:namespace />getRow(item) {
	
		let html = '<div class="row">';
		html += '<div class="item">';
	
		if (item.imageSrc && item.imageSrc != '') {
	
				html += '<div class="smallimage col-md-2 col-lg-2 hidden-xs hidden-sm">';
				html += '<a href="' + item.link + '">';
				html += '<img alt="' + item.title + '" src="' + item.imageSrc + '" title="' + item.title + '" />';
				html += '</a>';
				html += '</div>';
				html += '<div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 content">';				
	
		} else if (item.userInitials) {
			
				html += '<div class="smallimage col-md-2 col-lg-2 hidden-xs hidden-sm">';
				html += '<span class="user-avatar-image">'; 
				html += '<div class="user-icon-color-9 user-icon user-icon-lg user-icon-default">';
				html += '<span>' + item.userInitials + '</span>';
				html += '</div>';
				html += '</span>';
				html += '</div>';
				html += '<div class="col-xs-12 col-sm-12 col-md-10 col-lg-10 content">';
	
		} else if (item.userPortraitUrl) {
			
				html += '<div class="smallimage col-md-3 col-lg-3 hidden-xs hidden-sm">';
				html += '<a href="' + item.link + '">';
				html += '<img alt="' + item.title + '" class="user-icon-color-9 user-icon-lg user-icon user-icon-default" src="' + item.userPortraitUrl  + '" title="' + item.title + '" />';
				html += '</a>';
				html += '</div>';
				html += '<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9 content">';				
		} else {
				html += '<div class="content">';
		}

		html += '<div class="heading">';

		if (item.type != '') {
			html += '<span class="type"><a href="' + item.link + '">[' + item.type + ']</a></span>';
		}
						
		html += '<h1>';
		html += '<a class="highlightable" href="' + item.link + '">' + item.title + '</a>';
		html += '</h1>';
				
		if (item.highlight) {
			html += '<span title="' + Liferay.Language.get('official-article') + '" class="glyphicon glyphicon-check"></span>';
		} 
		html += '</div>';
			
		html += '<div class="link">';
		html += '<a class="highlightable" href="' + item.link + '">' + item.link + '</a>';
		html += '</div>';
		
		html += '<div class="description ">';

		if (item.date != '') {
			html += '<strong>' + item.date + '</strong>';
		}

		if (item.description != '') {
			html += '<span class="highlightable">' + item.description + '</span>';
		}
		html += '</div>';
			
		if (item.tags) {
			html += '<div class="tags">';
			html += '<span>' + Liferay.Language.get('tags') + ':</span>';
			
			for (tag in item.tags) {
				html += '<span class="tag">' + tag + '</span>';
			}
			html += '</div>';							
		}
		html += '</div>';
		html += '</div>';
		html += '</div>';
		
		return html;
	}

	jQuery(document).ready(function() {
		
		jQuery.ajax({
			type: 'POST',
			url: '<%= getSearchResultsURL %>',
			success: function(data) {
        	  
				if (data.items && data.items.length > 0) {
					let count = data.items.length;
					
					let html = '';
					
					for (let i = 0; i < count; i++) {
						html += <portlet:namespace />getRow(data.items[i]);
					}
					jQuery('#<portlet:namespace />SearchResults').html(html);

					jQuery('#p_p_id<portlet:namespace />').show();
					
				} else if (<%=themeDisplay.isSignedIn() %>){
					
					jQuery('#p_p_id<portlet:namespace />').show();
				} else {
					
					jQuery('#p_p_id<portlet:namespace />').hide();
				}
			}
		});
	});
</aui:script>
