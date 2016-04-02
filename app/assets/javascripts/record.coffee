@Record = React.createClass
	handleDelete: (e) -> # built-in to the click
		e.preventDefault()
		$.ajax #jquery doesn't have a $.delete shortcut method
			method: 'DELETE'
			url: "/records/#{ @props.record.id }"
			dataType: 'JSON'
			success: () =>
				@props.handleDeleteRecord @props.record

	render: ->
		React.DOM.tr null,
			React.DOM.td null, @props.record.date
			React.DOM.td null, @props.record.title
			React.DOM.td null, amountFormat(@props.record.amount)
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleDelete
					'Delete'
					# To make this button useful:
					# 1. Detect an event inside the child Record component (onClick)
					# 2. Perform an action (send a DELETE request to the server in this case)
					# 3. Notify the parent Records component about this action (sending/receiving a handler method through props)
					# 4. Update the Record component's state