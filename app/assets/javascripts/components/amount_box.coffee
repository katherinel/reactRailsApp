@AmountBox = React.createClass # show total credit amount, total debit amount, and balance
	render: ->
		React.DOM.div
			className: 'col-md-4'
			React.DOM.div
				className: "panel panel-#{ @props.type }"
				React.DOM.div
					className: 'panel-heading'
					@props.text
				React.DOM.div
					className: 'panel-body'
					amountFormat(@props.amount)