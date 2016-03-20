# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@Records = React.createClass
	getInitialState: ->
		records: @props.data # @props.data is coming from the line in the view: { data: @records }
	getDefaultProps: ->
		records: []
	render: ->
		React.DOM.div
			className: 'records'
			React.DOM.h2
				className: 'title'
				'Records'
			React.DOM.table
				className: 'table table-bordered'
				React.DOM.thead null,
					React.DOM.tr null,
						React.DOM.th null, 'Date',
						React.DOM.th null, 'Title',
						React.DOM.th null, 'Amount'
				React.DOM.tbody null,
					for record in @state.records # @state
						React.createElement Record, key: record.id, record: record