@ErrorMessages = React.createClass
	recordErrors: (jsonData) ->
		rows = [];
		for key of jsonData
			jsonData[key].forEach (val, index) -> 
				rows.push(
					React.DOM.div 
						key: index
						"#{ key }: #{ val }"
				);
		return rows;

	render: ->
		React.DOM.div
			className: 'error-msgs'
			@recordErrors(@props.data)