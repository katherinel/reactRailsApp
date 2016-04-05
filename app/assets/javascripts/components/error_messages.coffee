@ErrorMessages = React.createClass
	recordErrors: (jsonData) ->
		rows = [];
		for key of jsonData
			jsonData[key].forEach (val) -> 
				rows.push(
					React.DOM.div 
						key: key
						"#{ key }: #{ val }"
				);
		return rows;

	render: ->
		React.DOM.div
			className: 'error-msgs'
			@recordErrors(@props.data)