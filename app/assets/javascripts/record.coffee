@Record = React.createClass
	getInitialState: ->
		edit: false

	handleToggle: (e) ->
		e.preventDefault()
		@setState edit: !@state.edit

	handleDelete: (e) -> # built-in to the click
		e.preventDefault()
		$.ajax #jquery doesn't have a $.delete shortcut method
			method: 'DELETE'
			url: "/records/#{ @props.record.id }"
			dataType: 'JSON'
			success: () =>
				@props.handleDeleteRecord @props.record
	
	handleEdit: (e) ->
		e.preventDefault()
		data =
			# not validating user data, just reading it through here:
			title: React.findDOMNode(@refs.title).value
			date: React.findDOMNode(@refs.date).value
			amount: React.findDOMNode(@refs.amount).value
		# no jquery $.put shortcut method either
		$.ajax
			method: 'PUT'
			url: "/records/#{ @props.record.id }"
			dataType: 'JSON'
			data:
				record: data
			success: (data) =>
				@setState edit: false
				@props.handleEditRecord @props.record, data

	# moved out of render
	# two different states: read only (recordRow) or edit (recordForm)
	# can toggle back and forth depending on the @state.edit
	recordRow: ->
		React.DOM.tr null,
			React.DOM.td null, @props.record.date
			React.DOM.td null, @props.record.title
			React.DOM.td null, amountFormat(@props.record.amount)
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-default'
					onClick: @handleToggle
					'Edit'
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleDelete
					'Delete'
					# To make this button useful:
					# 1. Detect an event inside the child Record component (onClick)
					# 2. Perform an action (send a DELETE request to the server in this case)
					# 3. Notify the parent Records component about this action (sending/receiving a handler method through props)
					# 4. Update the Record component's state

	recordForm: ->
		React.DOM.tr null,
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'text'
					defaultValue: @props.record.date
					# We are using defaultValue instead of value to set the initial input values, this is because using just 
					# value without onChange will end up creating read-only inputs.
					ref: 'date'
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'text'
					defaultValue: @props.record.title
					ref: 'title'
			React.DOM.td null,
				React.DOM.input
					className: 'form-control'
					type: 'number'
					defaultValue: @props.record.amount
					ref: 'amount'
			React.DOM.td null,
				React.DOM.a
					className: 'btn btn-default'
					onClick: @handleEdit
					'Update'
				React.DOM.a
					className: 'btn btn-danger'
					onClick: @handleToggle
					'Cancel'

	render: ->
		if @state.edit
			@recordForm()
		else
			@recordRow()