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
		# records = @state.records.slice() # records is an array of objects
		# records.push record # record is a single object
		# changing the above to use the state helper below:
		records = React.addons.update(@state.records, { $push: [record] })
		@setState records: records

	deleteRecord: (record) ->
		# records = @state.records.slice()
		# index = records.indexOf record
		# records.splice index, 1
		# use the state helper:
		index = @state.records.indexOf record # not sure why we had to add @state here
		console.log(@state);
		records = React.addons.update(@state.records, { $splice: [[index, 1]] })
		@replaceState records: records
		# the main difference between setState and replaceState is that the first one will only update one key of the state object, the second one will completely override the current state of the component with whatever new object we send

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
						React.DOM.th null, 'Actions'
				React.DOM.tbody null,
					for record in @state.records # @state comes from getInitialState I think?
						React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord # create new instance of Record as defined in record.coffee