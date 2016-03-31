@RecordForm = React.createClass
	getInitialState: -> # all the inputs are blank at first
		title: ''
		date: ''
		amount: ''
	handleChange: (e) -> #  handleChange handler method will use the name attribute to detect which input triggered 
		# the event and update the related state value
    name = e.target.name
    @setState "#{ name }": e.target.value # We are just using string interpolation to dynamically define object keys, 
    # equivalent to @setState title: e.target.value when name equals title.
    # But why do we have to use @setState? Why can't we just set the desired value of @state as we usually do in 
    # regular JS Objects? Because @setState will perform 2 actions, it:
		# 1. Updates the component's state
		# 2. Schedules a UI verification/refresh based on the new state
	valid: ->
		@state.title && @state.date && @state.amount
	handleSubmit: (e) ->
		e.preventDefault() # prevent the form's HTTP submit
		$.post '', { record: @state }, (data) => # POST the new record information to the current URL
			# success callback
			@props.handleNewRecord data #sends data back to parent component to notify it about the existence of a new record
			@setState @getInitialState() # set it back to blank
		, 'JSON'
	render: ->
		React.DOM.form
			className: 'form-inline'
			onSubmit: @handleSubmit
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Date'
					name: 'date'
					value: @state.date # defining the value attribute to set the input's value
					onChange: @handleChange # onChange attribute to attach a handler method which will be called on every keystroke
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Title'
					name: 'title'
					value: @state.title
					onChange: @handleChange
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'number'
					className: 'form-control'
					placeholder: 'Amount'
					name: 'amount'
					value: @state.amount
					onChange: @handleChange
			React.DOM.button
				type: 'submit'
				className: 'btn btn-primary'
				disabled: !@valid() #we are going to implement a valid method to evaluate if the data provided by the user is correct
				'Create Record'