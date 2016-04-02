# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@Records = React.createClass
	getInitialState: ->
		records: @props.data # @props.data is coming from the line in the view: { data: @records }
	
	getDefaultProps: ->
		records: []
	
	credits: ->
		credits = @state.records.filter (val) -> val.amount >= 0
		credits.reduce ((prev, curr) ->
			prev + parseFloat(curr.amount)
		), 0 
	
	debits: ->
		debits = @state.records.filter (val) -> val.amount < 0
		debits.reduce ((prev, curr) ->
			prev + parseFloat(curr.amount)
		), 0
	
	balance: ->
		@debits() + @credits()
	
	addRecord: (record) ->
		records = @state.records.slice() # records is an array of objects
		records.push record # record is a single object
		@setState records: records
	
	render: ->
		React.DOM.div
			className: 'records'
			React.DOM.h2
				className: 'title'
				'Records'
			React.DOM.div
				className: 'row'
				React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
				React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
				React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'
			React.createElement RecordForm, handleNewRecord: @addRecord
			React.DOM.hr null
			React.DOM.table
				className: 'table table-bordered'
				React.DOM.thead null,
					React.DOM.tr null,
						React.DOM.th null, 'Date',
						React.DOM.th null, 'Title',
						React.DOM.th null, 'Amount'
				React.DOM.tbody null,
					for record in @state.records # @state comes from getInitialState I think?
						React.createElement Record, key: record.id, record: record # create new instance of Record as defined in record.coffee